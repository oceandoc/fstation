import 'dart:async';

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:flutter/cupertino.dart';
import 'package:fstation/generated/data.pb.dart';
import 'package:fstation/generated/error.pb.dart';
import 'package:fstation/generated/service.pb.dart';
import 'package:fstation/impl/logger.dart';
import 'package:fstation/impl/setting_impl.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import '../model/user.dart';

class GrpcClient {
  GrpcClient._();

  static final instance = GrpcClient._();

  static const _uuid = Uuid();
  ClientChannel? _channel;
  GrpcFileClient? _stub;

  String get _token => UserManager.instance.currentUser?.token ?? '';

  String get _user_name => UserManager.instance.currentUser?.name ?? '';

  Future<void> connect(String host, int port, {bool secure = false}) async {
    try {
      await _channel?.shutdown();

      _channel = ClientChannel(
        host,
        port: port,
        options: ChannelOptions(
          credentials: secure
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure(),
          idleTimeout: const Duration(seconds: 5),
        ),
      );

      await _channel!.getConnection().timeout(
            const Duration(seconds: 5),
            onTimeout: () =>
                throw const GrpcError.deadlineExceeded('Connection timeout'),
          );

      _stub = GrpcFileClient(_channel!);
      Logger.info('Connected to gRPC server at $host:$port');
    } catch (e, stack) {
      Logger.error('Failed to connect to gRPC server', e, stack);
      await shutdown();
      rethrow;
    }
  }

  Future<void> shutdown() async {
    await _channel?.shutdown();
    _channel = null;
    _stub = null;
  }

  // User Operations
  Future<UserRes> login(String username, String password) async {
    final request = UserReq()
      ..requestId = _uuid.v4()
      ..op = UserOp.UserLogin
      ..user = username
      ..password = password;

    try {
      final response = await _stub!.userOp(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserRes> register(String username, String password) async {
    final request = UserReq()
      ..requestId = _uuid.v4()
      ..op = UserOp.UserCreate
      ..user = username
      ..password = password;

    try {
      return await _stub!.userOp(request);
    } catch (e) {
      Logger.error('register error');
      rethrow;
    }
  }

  Future<UserRes> changePassword(String oldPassword, String newPassword) async {
    final request = UserReq()
      ..requestId = _uuid.v4()
      ..op = UserOp.UserChangePassword
      ..oldPassword = oldPassword
      ..password = newPassword
      ..token = _token;

    try {
      return await _stub!.userOp(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserRes> updateToken(User user) async {
    if (user.name == null || user.token == null) {
      throw Exception('User token is null');
    }
    final request = UserReq()
      ..requestId = _uuid.v4()
      ..op = UserOp.UserUpdateToken
      ..user = user.name!
      ..token = user.token!;

    try {
      final response = await _stub!.userOp(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Repository Operations
  Future<RepoRes> listUserRepos() async {
    final request = RepoReq()
      ..requestId = _uuid.v4()
      ..op = RepoOp.RepoListUserRepo
      ..token = _token;

    try {
      return await _stub!.repoOp(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<RepoRes> createRepo(String path) async {
    final request = RepoReq()
      ..requestId = _uuid.v4()
      ..op = RepoOp.RepoCreateRepo
      ..path = path
      ..token = _token
      ..user = UserManager.instance.currentUser?.name ?? '';

    try {
      return await _stub!.repoOp(request);
    } catch (e) {
      Logger.error('Failed to create repository', e);
      rethrow;
    }
  }

  Future<RepoRes> listServerDir(String path) async {
    final request = RepoReq()
      ..requestId = _uuid.v4()
      ..op = RepoOp.RepoListServerDir
      ..path = path
      ..token = _token
      ..user = UserManager.instance.currentUser?.name ?? '';

    try {
      return await _stub!.repoOp(request);
    } catch (e) {
      Logger.error('Failed to list server directory', e);
      rethrow;
    }
  }

  // File Operations
  Stream<FileRes> uploadFile({
    String? src,
    String? dst,
    String? repoUuid,
    List<int>? content,
    FileType? fileType,
    int? partitionNum,
    int? partitionSize,
    int? fileSize,
    RepoType? repoType,
    String? fileHash,
  }) async* {
    final request = FileReq()
      ..requestId = _uuid.v4()
      ..op = FileOp.FilePut
      ..src = src!
      ..dst = dst!
      ..repoUuid = repoUuid!
      ..content = content!
      ..fileType = fileType!
      ..repoType = repoType!
      ..partitionNum = partitionNum!
      ..partitionSize = $fixnum.Int64(partitionSize!)
      ..fileSize = $fixnum.Int64(fileSize!)
      ..fileHash = fileHash!
      ..token = UserManager.instance.token!
      ..user = UserManager.instance.lastLoginUser!;
    try {
      await for (final response in _stub!.fileOp(request)) {
        yield response;
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<FileRes> downloadFile(
    String src,
    String repoUuid,
  ) async* {
    final request = FileReq()
      ..requestId = _uuid.v4()
      ..op = FileOp.FileExists
      ..src = src
      ..repoUuid = repoUuid
      ..token = _token;

    try {
      await for (final response in _stub!.fileOp(request)) {
        yield response;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Server Operations
  Future<ServerRes> getServerStatus() async {
    final request = ServerReq()
      ..requestId = _uuid.v4()
      ..op = ServerOp.ServerStatus;

    try {
      return await _stub!.serverOp(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<ServerRes> handshake() async {
    final request = ServerReq()
      ..requestId = _uuid.v4()
      ..op = ServerOp.ServerHandShake;

    try {
      final response = await _stub!.serverOp(request);
      if (response.errCode == ErrCode.Success &&
          response.serverUuid.isNotEmpty) {
        Logger.info(
            'Server handshake successful, UUID: ${response.serverUuid}');
      } else {
        Logger.error('Server handshake failed, UUID: ${response.serverUuid}');
      }
      return response;
    } catch (e, stack) {
      Logger.error('Server handshake failed', e, stack);
      rethrow;
    }
  }
}

class GrpcFileClient extends Client {
  GrpcFileClient(ClientChannel super.channel);

  static final _$userOp = ClientMethod<UserReq, UserRes>(
    '/oceandoc.proto.OceanFile/UserOp',
    (UserReq value) => value.writeToBuffer(),
    UserRes.fromBuffer,
  );

  static final _$serverOp = ClientMethod<ServerReq, ServerRes>(
    '/oceandoc.proto.OceanFile/ServerOp',
    (ServerReq value) => value.writeToBuffer(),
    ServerRes.fromBuffer,
  );

  static final _$repoOp = ClientMethod<RepoReq, RepoRes>(
    '/oceandoc.proto.OceanFile/RepoOp',
    (RepoReq value) => value.writeToBuffer(),
    RepoRes.fromBuffer,
  );

  static final _$fileOp = ClientMethod<FileReq, FileRes>(
    '/oceandoc.proto.OceanFile/FileOp',
    (FileReq value) => value.writeToBuffer(),
    FileRes.fromBuffer,
  );

  Future<UserRes> userOp(UserReq request, {CallOptions? options}) async {
    return $createUnaryCall(_$userOp, request, options: options);
  }

  Future<ServerRes> serverOp(ServerReq request, {CallOptions? options}) async {
    return $createUnaryCall(_$serverOp, request, options: options);
  }

  Future<RepoRes> repoOp(RepoReq request, {CallOptions? options}) async {
    return $createUnaryCall(_$repoOp, request, options: options);
  }

  Stream<FileRes> fileOp(FileReq request, {CallOptions? options}) {
    return $createStreamingCall(_$fileOp, Stream.value(request),
        options: options);
  }
}
