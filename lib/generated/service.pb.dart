//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'data.pb.dart' as $0;
import 'data.pbenum.dart' as $0;
import 'error.pbenum.dart' as $1;
import 'service.pbenum.dart';

export 'service.pbenum.dart';

class Context extends $pb.GeneratedMessage {
  factory Context({
    $core.Iterable<$core.String>? privateIpv4,
    $core.Iterable<$core.String>? privateIpv6,
    $core.Iterable<$core.String>? publicIpv4,
    $core.Iterable<$core.String>? publicIpv6,
    $core.Iterable<$core.String>? mac,
  }) {
    final $result = create();
    if (privateIpv4 != null) {
      $result.privateIpv4.addAll(privateIpv4);
    }
    if (privateIpv6 != null) {
      $result.privateIpv6.addAll(privateIpv6);
    }
    if (publicIpv4 != null) {
      $result.publicIpv4.addAll(publicIpv4);
    }
    if (publicIpv6 != null) {
      $result.publicIpv6.addAll(publicIpv6);
    }
    if (mac != null) {
      $result.mac.addAll(mac);
    }
    return $result;
  }
  Context._() : super();
  factory Context.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Context.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Context', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'privateIpv4')
    ..pPS(2, _omitFieldNames ? '' : 'privateIpv6')
    ..pPS(3, _omitFieldNames ? '' : 'publicIpv4')
    ..pPS(4, _omitFieldNames ? '' : 'publicIpv6')
    ..pPS(5, _omitFieldNames ? '' : 'mac')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Context clone() => Context()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Context copyWith(void Function(Context) updates) => super.copyWith((message) => updates(message as Context)) as Context;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Context create() => Context._();
  Context createEmptyInstance() => create();
  static $pb.PbList<Context> createRepeated() => $pb.PbList<Context>();
  @$core.pragma('dart2js:noInline')
  static Context getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Context>(create);
  static Context? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get privateIpv4 => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get privateIpv6 => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get publicIpv4 => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get publicIpv6 => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get mac => $_getList(4);
}

class UserReq extends $pb.GeneratedMessage {
  factory UserReq({
    $core.String? requestId,
    UserOp? op,
    $core.String? user,
    $core.String? password,
    $core.String? token,
    $core.String? toDeleteUser,
    $core.String? oldPassword,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (op != null) {
      $result.op = op;
    }
    if (user != null) {
      $result.user = user;
    }
    if (password != null) {
      $result.password = password;
    }
    if (token != null) {
      $result.token = token;
    }
    if (toDeleteUser != null) {
      $result.toDeleteUser = toDeleteUser;
    }
    if (oldPassword != null) {
      $result.oldPassword = oldPassword;
    }
    return $result;
  }
  UserReq._() : super();
  factory UserReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..e<UserOp>(2, _omitFieldNames ? '' : 'op', $pb.PbFieldType.OE, defaultOrMaker: UserOp.UserUnused, valueOf: UserOp.valueOf, enumValues: UserOp.values)
    ..aOS(3, _omitFieldNames ? '' : 'user')
    ..aOS(4, _omitFieldNames ? '' : 'password')
    ..aOS(5, _omitFieldNames ? '' : 'token')
    ..aOS(6, _omitFieldNames ? '' : 'toDeleteUser')
    ..aOS(7, _omitFieldNames ? '' : 'oldPassword')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserReq clone() => UserReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserReq copyWith(void Function(UserReq) updates) => super.copyWith((message) => updates(message as UserReq)) as UserReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserReq create() => UserReq._();
  UserReq createEmptyInstance() => create();
  static $pb.PbList<UserReq> createRepeated() => $pb.PbList<UserReq>();
  @$core.pragma('dart2js:noInline')
  static UserReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserReq>(create);
  static UserReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  UserOp get op => $_getN(1);
  @$pb.TagNumber(2)
  set op(UserOp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOp() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get user => $_getSZ(2);
  @$pb.TagNumber(3)
  set user($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get token => $_getSZ(4);
  @$pb.TagNumber(5)
  set token($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get toDeleteUser => $_getSZ(5);
  @$pb.TagNumber(6)
  set toDeleteUser($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasToDeleteUser() => $_has(5);
  @$pb.TagNumber(6)
  void clearToDeleteUser() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get oldPassword => $_getSZ(6);
  @$pb.TagNumber(7)
  set oldPassword($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOldPassword() => $_has(6);
  @$pb.TagNumber(7)
  void clearOldPassword() => clearField(7);
}

class UserRes extends $pb.GeneratedMessage {
  factory UserRes({
    $1.ErrCode? errCode,
    $core.String? token,
  }) {
    final $result = create();
    if (errCode != null) {
      $result.errCode = errCode;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  UserRes._() : super();
  factory UserRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..e<$1.ErrCode>(1, _omitFieldNames ? '' : 'errCode', $pb.PbFieldType.OE, defaultOrMaker: $1.ErrCode.Success, valueOf: $1.ErrCode.valueOf, enumValues: $1.ErrCode.values)
    ..aOS(5, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserRes clone() => UserRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserRes copyWith(void Function(UserRes) updates) => super.copyWith((message) => updates(message as UserRes)) as UserRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRes create() => UserRes._();
  UserRes createEmptyInstance() => create();
  static $pb.PbList<UserRes> createRepeated() => $pb.PbList<UserRes>();
  @$core.pragma('dart2js:noInline')
  static UserRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRes>(create);
  static UserRes? _defaultInstance;

  @$pb.TagNumber(1)
  $1.ErrCode get errCode => $_getN(0);
  @$pb.TagNumber(1)
  set errCode($1.ErrCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrCode() => clearField(1);

  @$pb.TagNumber(5)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(5)
  set token($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(5)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(5)
  void clearToken() => clearField(5);
}

class ServerReq extends $pb.GeneratedMessage {
  factory ServerReq({
    $core.String? requestId,
    ServerOp? op,
    $core.String? path,
    $core.String? repoUuid,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (op != null) {
      $result.op = op;
    }
    if (path != null) {
      $result.path = path;
    }
    if (repoUuid != null) {
      $result.repoUuid = repoUuid;
    }
    return $result;
  }
  ServerReq._() : super();
  factory ServerReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServerReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ServerReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..e<ServerOp>(2, _omitFieldNames ? '' : 'op', $pb.PbFieldType.OE, defaultOrMaker: ServerOp.ServerUnused, valueOf: ServerOp.valueOf, enumValues: ServerOp.values)
    ..aOS(3, _omitFieldNames ? '' : 'path')
    ..aOS(4, _omitFieldNames ? '' : 'repoUuid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ServerReq clone() => ServerReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ServerReq copyWith(void Function(ServerReq) updates) => super.copyWith((message) => updates(message as ServerReq)) as ServerReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerReq create() => ServerReq._();
  ServerReq createEmptyInstance() => create();
  static $pb.PbList<ServerReq> createRepeated() => $pb.PbList<ServerReq>();
  @$core.pragma('dart2js:noInline')
  static ServerReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerReq>(create);
  static ServerReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  ServerOp get op => $_getN(1);
  @$pb.TagNumber(2)
  set op(ServerOp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOp() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get repoUuid => $_getSZ(3);
  @$pb.TagNumber(4)
  set repoUuid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRepoUuid() => $_has(3);
  @$pb.TagNumber(4)
  void clearRepoUuid() => clearField(4);
}

class ServerRes extends $pb.GeneratedMessage {
  factory ServerRes({
    $1.ErrCode? errCode,
    $core.String? status,
    $core.String? serverUuid,
  }) {
    final $result = create();
    if (errCode != null) {
      $result.errCode = errCode;
    }
    if (status != null) {
      $result.status = status;
    }
    if (serverUuid != null) {
      $result.serverUuid = serverUuid;
    }
    return $result;
  }
  ServerRes._() : super();
  factory ServerRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServerRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ServerRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..e<$1.ErrCode>(1, _omitFieldNames ? '' : 'errCode', $pb.PbFieldType.OE, defaultOrMaker: $1.ErrCode.Success, valueOf: $1.ErrCode.valueOf, enumValues: $1.ErrCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'serverUuid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ServerRes clone() => ServerRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ServerRes copyWith(void Function(ServerRes) updates) => super.copyWith((message) => updates(message as ServerRes)) as ServerRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerRes create() => ServerRes._();
  ServerRes createEmptyInstance() => create();
  static $pb.PbList<ServerRes> createRepeated() => $pb.PbList<ServerRes>();
  @$core.pragma('dart2js:noInline')
  static ServerRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerRes>(create);
  static ServerRes? _defaultInstance;

  @$pb.TagNumber(1)
  $1.ErrCode get errCode => $_getN(0);
  @$pb.TagNumber(1)
  set errCode($1.ErrCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serverUuid => $_getSZ(2);
  @$pb.TagNumber(3)
  set serverUuid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServerUuid() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerUuid() => clearField(3);
}

class RepoReq extends $pb.GeneratedMessage {
  factory RepoReq({
    $core.String? requestId,
    RepoOp? op,
    $0.RepoType? type,
    $core.String? path,
    $core.String? repoUuid,
    $core.String? repoName,
    $core.String? token,
    $core.String? user,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (op != null) {
      $result.op = op;
    }
    if (type != null) {
      $result.type = type;
    }
    if (path != null) {
      $result.path = path;
    }
    if (repoUuid != null) {
      $result.repoUuid = repoUuid;
    }
    if (repoName != null) {
      $result.repoName = repoName;
    }
    if (token != null) {
      $result.token = token;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  RepoReq._() : super();
  factory RepoReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepoReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepoReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..e<RepoOp>(2, _omitFieldNames ? '' : 'op', $pb.PbFieldType.OE, defaultOrMaker: RepoOp.RepoUnused, valueOf: RepoOp.valueOf, enumValues: RepoOp.values)
    ..e<$0.RepoType>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $0.RepoType.RT_Unused, valueOf: $0.RepoType.valueOf, enumValues: $0.RepoType.values)
    ..aOS(4, _omitFieldNames ? '' : 'path')
    ..aOS(5, _omitFieldNames ? '' : 'repoUuid')
    ..aOS(6, _omitFieldNames ? '' : 'repoName')
    ..aOS(7, _omitFieldNames ? '' : 'token')
    ..aOS(8, _omitFieldNames ? '' : 'user')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepoReq clone() => RepoReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepoReq copyWith(void Function(RepoReq) updates) => super.copyWith((message) => updates(message as RepoReq)) as RepoReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoReq create() => RepoReq._();
  RepoReq createEmptyInstance() => create();
  static $pb.PbList<RepoReq> createRepeated() => $pb.PbList<RepoReq>();
  @$core.pragma('dart2js:noInline')
  static RepoReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepoReq>(create);
  static RepoReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  RepoOp get op => $_getN(1);
  @$pb.TagNumber(2)
  set op(RepoOp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOp() => clearField(2);

  @$pb.TagNumber(3)
  $0.RepoType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type($0.RepoType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get path => $_getSZ(3);
  @$pb.TagNumber(4)
  set path($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPath() => $_has(3);
  @$pb.TagNumber(4)
  void clearPath() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get repoUuid => $_getSZ(4);
  @$pb.TagNumber(5)
  set repoUuid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRepoUuid() => $_has(4);
  @$pb.TagNumber(5)
  void clearRepoUuid() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get repoName => $_getSZ(5);
  @$pb.TagNumber(6)
  set repoName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRepoName() => $_has(5);
  @$pb.TagNumber(6)
  void clearRepoName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get token => $_getSZ(6);
  @$pb.TagNumber(7)
  set token($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearToken() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get user => $_getSZ(7);
  @$pb.TagNumber(8)
  set user($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUser() => $_has(7);
  @$pb.TagNumber(8)
  void clearUser() => clearField(8);
}

class RepoRes extends $pb.GeneratedMessage {
  factory RepoRes({
    $1.ErrCode? errCode,
    $core.Map<$core.String, $0.RepoMeta>? repos,
    $0.RepoDir? repoDir,
    $0.Dir? dir,
    $0.RepoMeta? repo,
  }) {
    final $result = create();
    if (errCode != null) {
      $result.errCode = errCode;
    }
    if (repos != null) {
      $result.repos.addAll(repos);
    }
    if (repoDir != null) {
      $result.repoDir = repoDir;
    }
    if (dir != null) {
      $result.dir = dir;
    }
    if (repo != null) {
      $result.repo = repo;
    }
    return $result;
  }
  RepoRes._() : super();
  factory RepoRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepoRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepoRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..e<$1.ErrCode>(1, _omitFieldNames ? '' : 'errCode', $pb.PbFieldType.OE, defaultOrMaker: $1.ErrCode.Success, valueOf: $1.ErrCode.valueOf, enumValues: $1.ErrCode.values)
    ..m<$core.String, $0.RepoMeta>(2, _omitFieldNames ? '' : 'repos', entryClassName: 'RepoRes.ReposEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: $0.RepoMeta.create, valueDefaultOrMaker: $0.RepoMeta.getDefault, packageName: const $pb.PackageName('oceandoc.proto'))
    ..aOM<$0.RepoDir>(3, _omitFieldNames ? '' : 'repoDir', subBuilder: $0.RepoDir.create)
    ..aOM<$0.Dir>(4, _omitFieldNames ? '' : 'dir', subBuilder: $0.Dir.create)
    ..aOM<$0.RepoMeta>(5, _omitFieldNames ? '' : 'repo', subBuilder: $0.RepoMeta.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepoRes clone() => RepoRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepoRes copyWith(void Function(RepoRes) updates) => super.copyWith((message) => updates(message as RepoRes)) as RepoRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoRes create() => RepoRes._();
  RepoRes createEmptyInstance() => create();
  static $pb.PbList<RepoRes> createRepeated() => $pb.PbList<RepoRes>();
  @$core.pragma('dart2js:noInline')
  static RepoRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepoRes>(create);
  static RepoRes? _defaultInstance;

  @$pb.TagNumber(1)
  $1.ErrCode get errCode => $_getN(0);
  @$pb.TagNumber(1)
  set errCode($1.ErrCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $0.RepoMeta> get repos => $_getMap(1);

  @$pb.TagNumber(3)
  $0.RepoDir get repoDir => $_getN(2);
  @$pb.TagNumber(3)
  set repoDir($0.RepoDir v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRepoDir() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepoDir() => clearField(3);
  @$pb.TagNumber(3)
  $0.RepoDir ensureRepoDir() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Dir get dir => $_getN(3);
  @$pb.TagNumber(4)
  set dir($0.Dir v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDir() => $_has(3);
  @$pb.TagNumber(4)
  void clearDir() => clearField(4);
  @$pb.TagNumber(4)
  $0.Dir ensureDir() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.RepoMeta get repo => $_getN(4);
  @$pb.TagNumber(5)
  set repo($0.RepoMeta v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRepo() => $_has(4);
  @$pb.TagNumber(5)
  void clearRepo() => clearField(5);
  @$pb.TagNumber(5)
  $0.RepoMeta ensureRepo() => $_ensure(4);
}

class FileReq extends $pb.GeneratedMessage {
  factory FileReq({
    $core.String? requestId,
    $0.RepoType? repoType,
    FileOp? op,
    $core.String? src,
    $core.String? dst,
    $0.FileType? fileType,
    $core.String? fileHash,
    $fixnum.Int64? fileSize,
    $core.List<$core.int>? content,
    $fixnum.Int64? updateTime,
    $core.int? partitionNum,
    $core.String? repoUuid,
    $fixnum.Int64? partitionSize,
    $core.String? user,
    $core.String? group,
    $core.String? token,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (repoType != null) {
      $result.repoType = repoType;
    }
    if (op != null) {
      $result.op = op;
    }
    if (src != null) {
      $result.src = src;
    }
    if (dst != null) {
      $result.dst = dst;
    }
    if (fileType != null) {
      $result.fileType = fileType;
    }
    if (fileHash != null) {
      $result.fileHash = fileHash;
    }
    if (fileSize != null) {
      $result.fileSize = fileSize;
    }
    if (content != null) {
      $result.content = content;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (partitionNum != null) {
      $result.partitionNum = partitionNum;
    }
    if (repoUuid != null) {
      $result.repoUuid = repoUuid;
    }
    if (partitionSize != null) {
      $result.partitionSize = partitionSize;
    }
    if (user != null) {
      $result.user = user;
    }
    if (group != null) {
      $result.group = group;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  FileReq._() : super();
  factory FileReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..e<$0.RepoType>(2, _omitFieldNames ? '' : 'repoType', $pb.PbFieldType.OE, defaultOrMaker: $0.RepoType.RT_Unused, valueOf: $0.RepoType.valueOf, enumValues: $0.RepoType.values)
    ..e<FileOp>(3, _omitFieldNames ? '' : 'op', $pb.PbFieldType.OE, defaultOrMaker: FileOp.FileUnused, valueOf: FileOp.valueOf, enumValues: FileOp.values)
    ..aOS(4, _omitFieldNames ? '' : 'src')
    ..aOS(5, _omitFieldNames ? '' : 'dst')
    ..e<$0.FileType>(6, _omitFieldNames ? '' : 'fileType', $pb.PbFieldType.OE, defaultOrMaker: $0.FileType.FT_Unused, valueOf: $0.FileType.valueOf, enumValues: $0.FileType.values)
    ..aOS(7, _omitFieldNames ? '' : 'fileHash')
    ..aInt64(8, _omitFieldNames ? '' : 'fileSize')
    ..a<$core.List<$core.int>>(9, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..aInt64(10, _omitFieldNames ? '' : 'updateTime')
    ..a<$core.int>(11, _omitFieldNames ? '' : 'partitionNum', $pb.PbFieldType.O3)
    ..aOS(12, _omitFieldNames ? '' : 'repoUuid')
    ..aInt64(13, _omitFieldNames ? '' : 'partitionSize')
    ..aOS(14, _omitFieldNames ? '' : 'user')
    ..aOS(15, _omitFieldNames ? '' : 'group')
    ..aOS(17, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileReq clone() => FileReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileReq copyWith(void Function(FileReq) updates) => super.copyWith((message) => updates(message as FileReq)) as FileReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileReq create() => FileReq._();
  FileReq createEmptyInstance() => create();
  static $pb.PbList<FileReq> createRepeated() => $pb.PbList<FileReq>();
  @$core.pragma('dart2js:noInline')
  static FileReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileReq>(create);
  static FileReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  $0.RepoType get repoType => $_getN(1);
  @$pb.TagNumber(2)
  set repoType($0.RepoType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRepoType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRepoType() => clearField(2);

  @$pb.TagNumber(3)
  FileOp get op => $_getN(2);
  @$pb.TagNumber(3)
  set op(FileOp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOp() => $_has(2);
  @$pb.TagNumber(3)
  void clearOp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get src => $_getSZ(3);
  @$pb.TagNumber(4)
  set src($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSrc() => $_has(3);
  @$pb.TagNumber(4)
  void clearSrc() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dst => $_getSZ(4);
  @$pb.TagNumber(5)
  set dst($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDst() => $_has(4);
  @$pb.TagNumber(5)
  void clearDst() => clearField(5);

  @$pb.TagNumber(6)
  $0.FileType get fileType => $_getN(5);
  @$pb.TagNumber(6)
  set fileType($0.FileType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFileType() => $_has(5);
  @$pb.TagNumber(6)
  void clearFileType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get fileHash => $_getSZ(6);
  @$pb.TagNumber(7)
  set fileHash($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFileHash() => $_has(6);
  @$pb.TagNumber(7)
  void clearFileHash() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get fileSize => $_getI64(7);
  @$pb.TagNumber(8)
  set fileSize($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFileSize() => $_has(7);
  @$pb.TagNumber(8)
  void clearFileSize() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.int> get content => $_getN(8);
  @$pb.TagNumber(9)
  set content($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasContent() => $_has(8);
  @$pb.TagNumber(9)
  void clearContent() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get updateTime => $_getI64(9);
  @$pb.TagNumber(10)
  set updateTime($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdateTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdateTime() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get partitionNum => $_getIZ(10);
  @$pb.TagNumber(11)
  set partitionNum($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPartitionNum() => $_has(10);
  @$pb.TagNumber(11)
  void clearPartitionNum() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get repoUuid => $_getSZ(11);
  @$pb.TagNumber(12)
  set repoUuid($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasRepoUuid() => $_has(11);
  @$pb.TagNumber(12)
  void clearRepoUuid() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get partitionSize => $_getI64(12);
  @$pb.TagNumber(13)
  set partitionSize($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPartitionSize() => $_has(12);
  @$pb.TagNumber(13)
  void clearPartitionSize() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get user => $_getSZ(13);
  @$pb.TagNumber(14)
  set user($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasUser() => $_has(13);
  @$pb.TagNumber(14)
  void clearUser() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get group => $_getSZ(14);
  @$pb.TagNumber(15)
  set group($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasGroup() => $_has(14);
  @$pb.TagNumber(15)
  void clearGroup() => clearField(15);

  @$pb.TagNumber(17)
  $core.String get token => $_getSZ(15);
  @$pb.TagNumber(17)
  set token($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(17)
  $core.bool hasToken() => $_has(15);
  @$pb.TagNumber(17)
  void clearToken() => clearField(17);
}

class FileRes extends $pb.GeneratedMessage {
  factory FileRes({
    $1.ErrCode? errCode,
    $core.String? src,
    $core.String? dst,
    $0.FileType? fileType,
    $core.String? fileHash,
    $core.int? partitionNum,
    $core.String? requestId,
    FileOp? op,
    $core.bool? canSkipUpload,
  }) {
    final $result = create();
    if (errCode != null) {
      $result.errCode = errCode;
    }
    if (src != null) {
      $result.src = src;
    }
    if (dst != null) {
      $result.dst = dst;
    }
    if (fileType != null) {
      $result.fileType = fileType;
    }
    if (fileHash != null) {
      $result.fileHash = fileHash;
    }
    if (partitionNum != null) {
      $result.partitionNum = partitionNum;
    }
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (op != null) {
      $result.op = op;
    }
    if (canSkipUpload != null) {
      $result.canSkipUpload = canSkipUpload;
    }
    return $result;
  }
  FileRes._() : super();
  factory FileRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileRes', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..e<$1.ErrCode>(1, _omitFieldNames ? '' : 'errCode', $pb.PbFieldType.OE, defaultOrMaker: $1.ErrCode.Success, valueOf: $1.ErrCode.valueOf, enumValues: $1.ErrCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'src')
    ..aOS(3, _omitFieldNames ? '' : 'dst')
    ..e<$0.FileType>(4, _omitFieldNames ? '' : 'fileType', $pb.PbFieldType.OE, defaultOrMaker: $0.FileType.FT_Unused, valueOf: $0.FileType.valueOf, enumValues: $0.FileType.values)
    ..aOS(5, _omitFieldNames ? '' : 'fileHash')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'partitionNum', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'requestId')
    ..e<FileOp>(8, _omitFieldNames ? '' : 'op', $pb.PbFieldType.OE, defaultOrMaker: FileOp.FileUnused, valueOf: FileOp.valueOf, enumValues: FileOp.values)
    ..aOB(9, _omitFieldNames ? '' : 'canSkipUpload')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileRes clone() => FileRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileRes copyWith(void Function(FileRes) updates) => super.copyWith((message) => updates(message as FileRes)) as FileRes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileRes create() => FileRes._();
  FileRes createEmptyInstance() => create();
  static $pb.PbList<FileRes> createRepeated() => $pb.PbList<FileRes>();
  @$core.pragma('dart2js:noInline')
  static FileRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileRes>(create);
  static FileRes? _defaultInstance;

  @$pb.TagNumber(1)
  $1.ErrCode get errCode => $_getN(0);
  @$pb.TagNumber(1)
  set errCode($1.ErrCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasErrCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get src => $_getSZ(1);
  @$pb.TagNumber(2)
  set src($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSrc() => $_has(1);
  @$pb.TagNumber(2)
  void clearSrc() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dst => $_getSZ(2);
  @$pb.TagNumber(3)
  set dst($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDst() => $_has(2);
  @$pb.TagNumber(3)
  void clearDst() => clearField(3);

  @$pb.TagNumber(4)
  $0.FileType get fileType => $_getN(3);
  @$pb.TagNumber(4)
  set fileType($0.FileType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFileType() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFileHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileHash() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get partitionNum => $_getIZ(5);
  @$pb.TagNumber(6)
  set partitionNum($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPartitionNum() => $_has(5);
  @$pb.TagNumber(6)
  void clearPartitionNum() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get requestId => $_getSZ(6);
  @$pb.TagNumber(7)
  set requestId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRequestId() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequestId() => clearField(7);

  @$pb.TagNumber(8)
  FileOp get op => $_getN(7);
  @$pb.TagNumber(8)
  set op(FileOp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasOp() => $_has(7);
  @$pb.TagNumber(8)
  void clearOp() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get canSkipUpload => $_getBF(8);
  @$pb.TagNumber(9)
  set canSkipUpload($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCanSkipUpload() => $_has(8);
  @$pb.TagNumber(9)
  void clearCanSkipUpload() => clearField(9);
}

class OceanFileApi {
  $pb.RpcClient _client;
  OceanFileApi(this._client);

  $async.Future<UserRes> userOp($pb.ClientContext? ctx, UserReq request) =>
    _client.invoke<UserRes>(ctx, 'OceanFile', 'UserOp', request, UserRes())
  ;
  $async.Future<ServerRes> serverOp($pb.ClientContext? ctx, ServerReq request) =>
    _client.invoke<ServerRes>(ctx, 'OceanFile', 'ServerOp', request, ServerRes())
  ;
  $async.Future<RepoRes> repoOp($pb.ClientContext? ctx, RepoReq request) =>
    _client.invoke<RepoRes>(ctx, 'OceanFile', 'RepoOp', request, RepoRes())
  ;
  $async.Future<FileRes> fileOp($pb.ClientContext? ctx, FileReq request) =>
    _client.invoke<FileRes>(ctx, 'OceanFile', 'FileOp', request, FileRes())
  ;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
