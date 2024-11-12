//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UserOp extends $pb.ProtobufEnum {
  static const UserOp UserUnused = UserOp._(0, _omitEnumNames ? '' : 'UserUnused');
  static const UserOp UserCreate = UserOp._(1, _omitEnumNames ? '' : 'UserCreate');
  static const UserOp UserDelete = UserOp._(2, _omitEnumNames ? '' : 'UserDelete');
  static const UserOp UserLogin = UserOp._(3, _omitEnumNames ? '' : 'UserLogin');
  static const UserOp UserLogout = UserOp._(4, _omitEnumNames ? '' : 'UserLogout');
  static const UserOp UserChangePassword = UserOp._(5, _omitEnumNames ? '' : 'UserChangePassword');

  static const $core.List<UserOp> values = <UserOp> [
    UserUnused,
    UserCreate,
    UserDelete,
    UserLogin,
    UserLogout,
    UserChangePassword,
  ];

  static final $core.Map<$core.int, UserOp> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserOp? valueOf($core.int value) => _byValue[value];

  const UserOp._($core.int v, $core.String n) : super(v, n);
}

class ServerOp extends $pb.ProtobufEnum {
  static const ServerOp ServerUnused = ServerOp._(0, _omitEnumNames ? '' : 'ServerUnused');
  static const ServerOp ServerStatus = ServerOp._(1, _omitEnumNames ? '' : 'ServerStatus');
  static const ServerOp ServerRestart = ServerOp._(2, _omitEnumNames ? '' : 'ServerRestart');
  static const ServerOp ServerShutdown = ServerOp._(3, _omitEnumNames ? '' : 'ServerShutdown');
  static const ServerOp ServerFullScan = ServerOp._(4, _omitEnumNames ? '' : 'ServerFullScan');

  static const $core.List<ServerOp> values = <ServerOp> [
    ServerUnused,
    ServerStatus,
    ServerRestart,
    ServerShutdown,
    ServerFullScan,
  ];

  static final $core.Map<$core.int, ServerOp> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ServerOp? valueOf($core.int value) => _byValue[value];

  const ServerOp._($core.int v, $core.String n) : super(v, n);
}

class RepoOp extends $pb.ProtobufEnum {
  static const RepoOp RepoUnused = RepoOp._(0, _omitEnumNames ? '' : 'RepoUnused');
  static const RepoOp RepoListServerDir = RepoOp._(1, _omitEnumNames ? '' : 'RepoListServerDir');
  static const RepoOp RepoCreateServerDir = RepoOp._(2, _omitEnumNames ? '' : 'RepoCreateServerDir');
  static const RepoOp RepoListUserRepo = RepoOp._(3, _omitEnumNames ? '' : 'RepoListUserRepo');
  static const RepoOp RepoCreateRepo = RepoOp._(4, _omitEnumNames ? '' : 'RepoCreateRepo');
  static const RepoOp RepoDeleteRepo = RepoOp._(5, _omitEnumNames ? '' : 'RepoDeleteRepo');
  static const RepoOp RepoChangeRepoOwner = RepoOp._(6, _omitEnumNames ? '' : 'RepoChangeRepoOwner');
  static const RepoOp RepoListRepoDir = RepoOp._(7, _omitEnumNames ? '' : 'RepoListRepoDir');
  static const RepoOp RepoCreateRepoDir = RepoOp._(8, _omitEnumNames ? '' : 'RepoCreateRepoDir');
  static const RepoOp RepoDeleteRepoDir = RepoOp._(9, _omitEnumNames ? '' : 'RepoDeleteRepoDir');
  static const RepoOp RepoDeleteRepoFile = RepoOp._(10, _omitEnumNames ? '' : 'RepoDeleteRepoFile');

  static const $core.List<RepoOp> values = <RepoOp> [
    RepoUnused,
    RepoListServerDir,
    RepoCreateServerDir,
    RepoListUserRepo,
    RepoCreateRepo,
    RepoDeleteRepo,
    RepoChangeRepoOwner,
    RepoListRepoDir,
    RepoCreateRepoDir,
    RepoDeleteRepoDir,
    RepoDeleteRepoFile,
  ];

  static final $core.Map<$core.int, RepoOp> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RepoOp? valueOf($core.int value) => _byValue[value];

  const RepoOp._($core.int v, $core.String n) : super(v, n);
}

class FileOp extends $pb.ProtobufEnum {
  static const FileOp FileUnused = FileOp._(0, _omitEnumNames ? '' : 'FileUnused');
  static const FileOp FileExists = FileOp._(1, _omitEnumNames ? '' : 'FileExists');
  static const FileOp FilePut = FileOp._(2, _omitEnumNames ? '' : 'FilePut');
  static const FileOp FileDelete = FileOp._(3, _omitEnumNames ? '' : 'FileDelete');

  static const $core.List<FileOp> values = <FileOp> [
    FileUnused,
    FileExists,
    FilePut,
    FileDelete,
  ];

  static final $core.Map<$core.int, FileOp> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FileOp? valueOf($core.int value) => _byValue[value];

  const FileOp._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
