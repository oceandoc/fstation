import 'dart:async';

import 'package:fstation/generated/data.pb.dart';
import 'package:fstation/generated/error.pb.dart';
import 'package:fstation/generated/service.pb.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

class OceanClient {
  factory OceanClient() => _instance;
  OceanClient._internal();
  static final OceanClient _instance = OceanClient._internal();
  static const _uuid = Uuid();

  ClientChannel? _channel;
  OceanFileClient? _stub;
  String? _token;

  Future<void> connect(String host, int port, {bool secure = false}) async {
    await _channel?.shutdown();

    _channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: secure
            ? const ChannelCredentials.secure()
            : const ChannelCredentials.insecure(),
        idleTimeout: const Duration(minutes: 1),
      ),
    );

    _stub = OceanFileClient(_channel!);
  }

  Future<void> shutdown() async {
    await _channel?.shutdown();
    _channel = null;
    _stub = null;
    _token = null;
  }

  set token(String value) {
    _token = value;
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
      if (response.errCode == ErrCode.Success) {
        _token = response.token;
      }
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
      rethrow;
    }
  }

  Future<UserRes> changePassword(String oldPassword, String newPassword) async {
    final request = UserReq()
      ..requestId = _uuid.v4()
      ..op = UserOp.UserChangePassword
      ..oldPassword = oldPassword
      ..password = newPassword
      ..token = _token ?? '';

    try {
      return await _stub!.userOp(request);
    } catch (e) {
      rethrow;
    }
  }

  // Repository Operations
  Future<RepoRes> listUserRepos() async {
    final request = RepoReq()
      ..requestId = _uuid.v4()
      ..op = RepoOp.RepoListUserRepo
      ..token = _token ?? '';

    try {
      return await _stub!.repoOp(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<RepoRes> createRepo(String repoName, String path) async {
    final request = RepoReq()
      ..requestId = _uuid.v4()
      ..op = RepoOp.RepoCreateRepo
      ..repoName = repoName
      ..path = path
      ..token = _token ?? '';

    try {
      return await _stub!.repoOp(request);
    } catch (e) {
      rethrow;
    }
  }

  // File Operations
  Stream<FileRes> uploadFile(
    String src,
    String dst,
    String repoUuid,
    List<int> content,
    FileType fileType,
  ) async* {
    final request = FileReq()
      ..requestId = _uuid.v4()
      ..op = FileOp.FilePut
      ..src = src
      ..dst = dst
      ..repoUuid = repoUuid
      ..content = content
      ..fileType = fileType
      ..token = _token ?? '';

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
      ..token = _token ?? '';

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
}

class OceanFileClient extends Client {
  OceanFileClient(ClientChannel super.channel);

  static final _$userOp = ClientMethod<UserReq, UserRes>(
    'OceanFile/UserOp',
    (UserReq value) => value.writeToBuffer(),
    UserRes.fromBuffer,
  );

  static final _$serverOp = ClientMethod<ServerReq, ServerRes>(
    'OceanFile/ServerOp',
    (ServerReq value) => value.writeToBuffer(),
    ServerRes.fromBuffer,
  );

  static final _$repoOp = ClientMethod<RepoReq, RepoRes>(
    'OceanFile/RepoOp',
    (RepoReq value) => value.writeToBuffer(),
    RepoRes.fromBuffer,
  );

  static final _$fileOp = ClientMethod<FileReq, FileRes>(
    'OceanFile/FileOp',
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
