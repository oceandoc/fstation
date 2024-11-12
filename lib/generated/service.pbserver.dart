//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $2;
import 'service.pbjson.dart';

export 'service.pb.dart';

abstract class OceanFileServiceBase extends $pb.GeneratedService {
  $async.Future<$2.UserRes> userOp($pb.ServerContext ctx, $2.UserReq request);
  $async.Future<$2.ServerRes> serverOp($pb.ServerContext ctx, $2.ServerReq request);
  $async.Future<$2.RepoRes> repoOp($pb.ServerContext ctx, $2.RepoReq request);
  $async.Future<$2.FileRes> fileOp($pb.ServerContext ctx, $2.FileReq request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'UserOp': return $2.UserReq();
      case 'ServerOp': return $2.ServerReq();
      case 'RepoOp': return $2.RepoReq();
      case 'FileOp': return $2.FileReq();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'UserOp': return this.userOp(ctx, request as $2.UserReq);
      case 'ServerOp': return this.serverOp(ctx, request as $2.ServerReq);
      case 'RepoOp': return this.repoOp(ctx, request as $2.RepoReq);
      case 'FileOp': return this.fileOp(ctx, request as $2.FileReq);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => OceanFileServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => OceanFileServiceBase$messageJson;
}

