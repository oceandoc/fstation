//
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'data.pbjson.dart' as $0;

@$core.Deprecated('Use userOpDescriptor instead')
const UserOp$json = {
  '1': 'UserOp',
  '2': [
    {'1': 'UserUnused', '2': 0},
    {'1': 'UserCreate', '2': 1},
    {'1': 'UserDelete', '2': 2},
    {'1': 'UserLogin', '2': 3},
    {'1': 'UserLogout', '2': 4},
    {'1': 'UserChangePassword', '2': 5},
    {'1': 'UserUpdateToken', '2': 6},
  ],
};

/// Descriptor for `UserOp`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userOpDescriptor = $convert.base64Decode(
    'CgZVc2VyT3ASDgoKVXNlclVudXNlZBAAEg4KClVzZXJDcmVhdGUQARIOCgpVc2VyRGVsZXRlEA'
    'ISDQoJVXNlckxvZ2luEAMSDgoKVXNlckxvZ291dBAEEhYKElVzZXJDaGFuZ2VQYXNzd29yZBAF'
    'EhMKD1VzZXJVcGRhdGVUb2tlbhAG');

@$core.Deprecated('Use serverOpDescriptor instead')
const ServerOp$json = {
  '1': 'ServerOp',
  '2': [
    {'1': 'ServerUnused', '2': 0},
    {'1': 'ServerStatus', '2': 1},
    {'1': 'ServerRestart', '2': 2},
    {'1': 'ServerShutdown', '2': 3},
    {'1': 'ServerFullScan', '2': 4},
    {'1': 'ServerHandShake', '2': 5},
    {'1': 'ServerFindingServer', '2': 6},
  ],
};

/// Descriptor for `ServerOp`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List serverOpDescriptor = $convert.base64Decode(
    'CghTZXJ2ZXJPcBIQCgxTZXJ2ZXJVbnVzZWQQABIQCgxTZXJ2ZXJTdGF0dXMQARIRCg1TZXJ2ZX'
    'JSZXN0YXJ0EAISEgoOU2VydmVyU2h1dGRvd24QAxISCg5TZXJ2ZXJGdWxsU2NhbhAEEhMKD1Nl'
    'cnZlckhhbmRTaGFrZRAFEhcKE1NlcnZlckZpbmRpbmdTZXJ2ZXIQBg==');

@$core.Deprecated('Use repoOpDescriptor instead')
const RepoOp$json = {
  '1': 'RepoOp',
  '2': [
    {'1': 'RepoUnused', '2': 0},
    {'1': 'RepoListServerDir', '2': 1},
    {'1': 'RepoCreateServerDir', '2': 2},
    {'1': 'RepoListUserRepo', '2': 3},
    {'1': 'RepoCreateRepo', '2': 4},
    {'1': 'RepoDeleteRepo', '2': 5},
    {'1': 'RepoChangeRepoOwner', '2': 6},
    {'1': 'RepoListRepoDir', '2': 7},
    {'1': 'RepoCreateRepoDir', '2': 8},
    {'1': 'RepoDeleteRepoDir', '2': 9},
    {'1': 'RepoDeleteRepoFile', '2': 10},
  ],
};

/// Descriptor for `RepoOp`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List repoOpDescriptor = $convert.base64Decode(
    'CgZSZXBvT3ASDgoKUmVwb1VudXNlZBAAEhUKEVJlcG9MaXN0U2VydmVyRGlyEAESFwoTUmVwb0'
    'NyZWF0ZVNlcnZlckRpchACEhQKEFJlcG9MaXN0VXNlclJlcG8QAxISCg5SZXBvQ3JlYXRlUmVw'
    'bxAEEhIKDlJlcG9EZWxldGVSZXBvEAUSFwoTUmVwb0NoYW5nZVJlcG9Pd25lchAGEhMKD1JlcG'
    '9MaXN0UmVwb0RpchAHEhUKEVJlcG9DcmVhdGVSZXBvRGlyEAgSFQoRUmVwb0RlbGV0ZVJlcG9E'
    'aXIQCRIWChJSZXBvRGVsZXRlUmVwb0ZpbGUQCg==');

@$core.Deprecated('Use fileOpDescriptor instead')
const FileOp$json = {
  '1': 'FileOp',
  '2': [
    {'1': 'FileUnused', '2': 0},
    {'1': 'FileExists', '2': 1},
    {'1': 'FilePut', '2': 2},
    {'1': 'FileDelete', '2': 3},
  ],
};

/// Descriptor for `FileOp`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fileOpDescriptor = $convert.base64Decode(
    'CgZGaWxlT3ASDgoKRmlsZVVudXNlZBAAEg4KCkZpbGVFeGlzdHMQARILCgdGaWxlUHV0EAISDg'
    'oKRmlsZURlbGV0ZRAD');

@$core.Deprecated('Use contextDescriptor instead')
const Context$json = {
  '1': 'Context',
  '2': [
    {'1': 'private_ipv4', '3': 1, '4': 3, '5': 9, '10': 'privateIpv4'},
    {'1': 'private_ipv6', '3': 2, '4': 3, '5': 9, '10': 'privateIpv6'},
    {'1': 'public_ipv4', '3': 3, '4': 3, '5': 9, '10': 'publicIpv4'},
    {'1': 'public_ipv6', '3': 4, '4': 3, '5': 9, '10': 'publicIpv6'},
    {'1': 'mac', '3': 5, '4': 3, '5': 9, '10': 'mac'},
  ],
};

/// Descriptor for `Context`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contextDescriptor = $convert.base64Decode(
    'CgdDb250ZXh0EiEKDHByaXZhdGVfaXB2NBgBIAMoCVILcHJpdmF0ZUlwdjQSIQoMcHJpdmF0ZV'
    '9pcHY2GAIgAygJUgtwcml2YXRlSXB2NhIfCgtwdWJsaWNfaXB2NBgDIAMoCVIKcHVibGljSXB2'
    'NBIfCgtwdWJsaWNfaXB2NhgEIAMoCVIKcHVibGljSXB2NhIQCgNtYWMYBSADKAlSA21hYw==');

@$core.Deprecated('Use userReqDescriptor instead')
const UserReq$json = {
  '1': 'UserReq',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'op', '3': 2, '4': 1, '5': 14, '6': '.oceandoc.proto.UserOp', '10': 'op'},
    {'1': 'user', '3': 3, '4': 1, '5': 9, '10': 'user'},
    {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
    {'1': 'token', '3': 5, '4': 1, '5': 9, '10': 'token'},
    {'1': 'to_delete_user', '3': 6, '4': 1, '5': 9, '10': 'toDeleteUser'},
    {'1': 'old_password', '3': 7, '4': 1, '5': 9, '10': 'oldPassword'},
  ],
};

/// Descriptor for `UserReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userReqDescriptor = $convert.base64Decode(
    'CgdVc2VyUmVxEh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3RJZBImCgJvcBgCIAEoDjIWLm'
    '9jZWFuZG9jLnByb3RvLlVzZXJPcFICb3ASEgoEdXNlchgDIAEoCVIEdXNlchIaCghwYXNzd29y'
    'ZBgEIAEoCVIIcGFzc3dvcmQSFAoFdG9rZW4YBSABKAlSBXRva2VuEiQKDnRvX2RlbGV0ZV91c2'
    'VyGAYgASgJUgx0b0RlbGV0ZVVzZXISIQoMb2xkX3Bhc3N3b3JkGAcgASgJUgtvbGRQYXNzd29y'
    'ZA==');

@$core.Deprecated('Use userResDescriptor instead')
const UserRes$json = {
  '1': 'UserRes',
  '2': [
    {'1': 'err_code', '3': 1, '4': 1, '5': 14, '6': '.oceandoc.proto.ErrCode', '10': 'errCode'},
    {'1': 'token', '3': 5, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `UserRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userResDescriptor = $convert.base64Decode(
    'CgdVc2VyUmVzEjIKCGVycl9jb2RlGAEgASgOMhcub2NlYW5kb2MucHJvdG8uRXJyQ29kZVIHZX'
    'JyQ29kZRIUCgV0b2tlbhgFIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use serverReqDescriptor instead')
const ServerReq$json = {
  '1': 'ServerReq',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'op', '3': 2, '4': 1, '5': 14, '6': '.oceandoc.proto.ServerOp', '10': 'op'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    {'1': 'repo_uuid', '3': 4, '4': 1, '5': 9, '10': 'repoUuid'},
  ],
};

/// Descriptor for `ServerReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverReqDescriptor = $convert.base64Decode(
    'CglTZXJ2ZXJSZXESHQoKcmVxdWVzdF9pZBgBIAEoCVIJcmVxdWVzdElkEigKAm9wGAIgASgOMh'
    'gub2NlYW5kb2MucHJvdG8uU2VydmVyT3BSAm9wEhIKBHBhdGgYAyABKAlSBHBhdGgSGwoJcmVw'
    'b191dWlkGAQgASgJUghyZXBvVXVpZA==');

@$core.Deprecated('Use serverResDescriptor instead')
const ServerRes$json = {
  '1': 'ServerRes',
  '2': [
    {'1': 'err_code', '3': 1, '4': 1, '5': 14, '6': '.oceandoc.proto.ErrCode', '10': 'errCode'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'server_uuid', '3': 3, '4': 1, '5': 9, '10': 'serverUuid'},
  ],
};

/// Descriptor for `ServerRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverResDescriptor = $convert.base64Decode(
    'CglTZXJ2ZXJSZXMSMgoIZXJyX2NvZGUYASABKA4yFy5vY2VhbmRvYy5wcm90by5FcnJDb2RlUg'
    'dlcnJDb2RlEhYKBnN0YXR1cxgCIAEoCVIGc3RhdHVzEh8KC3NlcnZlcl91dWlkGAMgASgJUgpz'
    'ZXJ2ZXJVdWlk');

@$core.Deprecated('Use repoReqDescriptor instead')
const RepoReq$json = {
  '1': 'RepoReq',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'op', '3': 2, '4': 1, '5': 14, '6': '.oceandoc.proto.RepoOp', '10': 'op'},
    {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.oceandoc.proto.RepoType', '10': 'type'},
    {'1': 'path', '3': 4, '4': 1, '5': 9, '10': 'path'},
    {'1': 'repo_uuid', '3': 5, '4': 1, '5': 9, '10': 'repoUuid'},
    {'1': 'repo_name', '3': 6, '4': 1, '5': 9, '10': 'repoName'},
    {'1': 'token', '3': 7, '4': 1, '5': 9, '10': 'token'},
    {'1': 'user', '3': 8, '4': 1, '5': 9, '10': 'user'},
  ],
};

/// Descriptor for `RepoReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoReqDescriptor = $convert.base64Decode(
    'CgdSZXBvUmVxEh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3RJZBImCgJvcBgCIAEoDjIWLm'
    '9jZWFuZG9jLnByb3RvLlJlcG9PcFICb3ASLAoEdHlwZRgDIAEoDjIYLm9jZWFuZG9jLnByb3Rv'
    'LlJlcG9UeXBlUgR0eXBlEhIKBHBhdGgYBCABKAlSBHBhdGgSGwoJcmVwb191dWlkGAUgASgJUg'
    'hyZXBvVXVpZBIbCglyZXBvX25hbWUYBiABKAlSCHJlcG9OYW1lEhQKBXRva2VuGAcgASgJUgV0'
    'b2tlbhISCgR1c2VyGAggASgJUgR1c2Vy');

@$core.Deprecated('Use repoResDescriptor instead')
const RepoRes$json = {
  '1': 'RepoRes',
  '2': [
    {'1': 'err_code', '3': 1, '4': 1, '5': 14, '6': '.oceandoc.proto.ErrCode', '10': 'errCode'},
    {'1': 'repos', '3': 2, '4': 3, '5': 11, '6': '.oceandoc.proto.RepoRes.ReposEntry', '10': 'repos'},
    {'1': 'repo_dir', '3': 3, '4': 1, '5': 11, '6': '.oceandoc.proto.RepoDir', '10': 'repoDir'},
    {'1': 'dir', '3': 4, '4': 1, '5': 11, '6': '.oceandoc.proto.Dir', '10': 'dir'},
    {'1': 'repo', '3': 5, '4': 1, '5': 11, '6': '.oceandoc.proto.RepoMeta', '10': 'repo'},
  ],
  '3': [RepoRes_ReposEntry$json],
};

@$core.Deprecated('Use repoResDescriptor instead')
const RepoRes_ReposEntry$json = {
  '1': 'ReposEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.oceandoc.proto.RepoMeta', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RepoRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoResDescriptor = $convert.base64Decode(
    'CgdSZXBvUmVzEjIKCGVycl9jb2RlGAEgASgOMhcub2NlYW5kb2MucHJvdG8uRXJyQ29kZVIHZX'
    'JyQ29kZRI4CgVyZXBvcxgCIAMoCzIiLm9jZWFuZG9jLnByb3RvLlJlcG9SZXMuUmVwb3NFbnRy'
    'eVIFcmVwb3MSMgoIcmVwb19kaXIYAyABKAsyFy5vY2VhbmRvYy5wcm90by5SZXBvRGlyUgdyZX'
    'BvRGlyEiUKA2RpchgEIAEoCzITLm9jZWFuZG9jLnByb3RvLkRpclIDZGlyEiwKBHJlcG8YBSAB'
    'KAsyGC5vY2VhbmRvYy5wcm90by5SZXBvTWV0YVIEcmVwbxpSCgpSZXBvc0VudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5Ei4KBXZhbHVlGAIgASgLMhgub2NlYW5kb2MucHJvdG8uUmVwb01ldGFSBXZh'
    'bHVlOgI4AQ==');

@$core.Deprecated('Use fileReqDescriptor instead')
const FileReq$json = {
  '1': 'FileReq',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'repo_type', '3': 2, '4': 1, '5': 14, '6': '.oceandoc.proto.RepoType', '10': 'repoType'},
    {'1': 'op', '3': 3, '4': 1, '5': 14, '6': '.oceandoc.proto.FileOp', '10': 'op'},
    {'1': 'src', '3': 4, '4': 1, '5': 9, '10': 'src'},
    {'1': 'dst', '3': 5, '4': 1, '5': 9, '10': 'dst'},
    {'1': 'file_type', '3': 6, '4': 1, '5': 14, '6': '.oceandoc.proto.FileType', '10': 'fileType'},
    {'1': 'file_hash', '3': 7, '4': 1, '5': 9, '10': 'fileHash'},
    {'1': 'file_size', '3': 8, '4': 1, '5': 3, '10': 'fileSize'},
    {'1': 'content', '3': 9, '4': 1, '5': 12, '10': 'content'},
    {'1': 'update_time', '3': 10, '4': 1, '5': 3, '10': 'updateTime'},
    {'1': 'partition_num', '3': 11, '4': 1, '5': 5, '10': 'partitionNum'},
    {'1': 'repo_uuid', '3': 12, '4': 1, '5': 9, '10': 'repoUuid'},
    {'1': 'partition_size', '3': 13, '4': 1, '5': 3, '10': 'partitionSize'},
    {'1': 'user', '3': 14, '4': 1, '5': 9, '10': 'user'},
    {'1': 'group', '3': 15, '4': 1, '5': 9, '10': 'group'},
    {'1': 'token', '3': 17, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `FileReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileReqDescriptor = $convert.base64Decode(
    'CgdGaWxlUmVxEh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3RJZBI1CglyZXBvX3R5cGUYAi'
    'ABKA4yGC5vY2VhbmRvYy5wcm90by5SZXBvVHlwZVIIcmVwb1R5cGUSJgoCb3AYAyABKA4yFi5v'
    'Y2VhbmRvYy5wcm90by5GaWxlT3BSAm9wEhAKA3NyYxgEIAEoCVIDc3JjEhAKA2RzdBgFIAEoCV'
    'IDZHN0EjUKCWZpbGVfdHlwZRgGIAEoDjIYLm9jZWFuZG9jLnByb3RvLkZpbGVUeXBlUghmaWxl'
    'VHlwZRIbCglmaWxlX2hhc2gYByABKAlSCGZpbGVIYXNoEhsKCWZpbGVfc2l6ZRgIIAEoA1IIZm'
    'lsZVNpemUSGAoHY29udGVudBgJIAEoDFIHY29udGVudBIfCgt1cGRhdGVfdGltZRgKIAEoA1IK'
    'dXBkYXRlVGltZRIjCg1wYXJ0aXRpb25fbnVtGAsgASgFUgxwYXJ0aXRpb25OdW0SGwoJcmVwb1'
    '91dWlkGAwgASgJUghyZXBvVXVpZBIlCg5wYXJ0aXRpb25fc2l6ZRgNIAEoA1INcGFydGl0aW9u'
    'U2l6ZRISCgR1c2VyGA4gASgJUgR1c2VyEhQKBWdyb3VwGA8gASgJUgVncm91cBIUCgV0b2tlbh'
    'gRIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use fileResDescriptor instead')
const FileRes$json = {
  '1': 'FileRes',
  '2': [
    {'1': 'err_code', '3': 1, '4': 1, '5': 14, '6': '.oceandoc.proto.ErrCode', '10': 'errCode'},
    {'1': 'src', '3': 2, '4': 1, '5': 9, '10': 'src'},
    {'1': 'dst', '3': 3, '4': 1, '5': 9, '10': 'dst'},
    {'1': 'file_type', '3': 4, '4': 1, '5': 14, '6': '.oceandoc.proto.FileType', '10': 'fileType'},
    {'1': 'file_hash', '3': 5, '4': 1, '5': 9, '10': 'fileHash'},
    {'1': 'partition_num', '3': 6, '4': 1, '5': 5, '10': 'partitionNum'},
    {'1': 'request_id', '3': 7, '4': 1, '5': 9, '10': 'requestId'},
    {'1': 'op', '3': 8, '4': 1, '5': 14, '6': '.oceandoc.proto.FileOp', '10': 'op'},
    {'1': 'can_skip_upload', '3': 9, '4': 1, '5': 8, '10': 'canSkipUpload'},
  ],
};

/// Descriptor for `FileRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileResDescriptor = $convert.base64Decode(
    'CgdGaWxlUmVzEjIKCGVycl9jb2RlGAEgASgOMhcub2NlYW5kb2MucHJvdG8uRXJyQ29kZVIHZX'
    'JyQ29kZRIQCgNzcmMYAiABKAlSA3NyYxIQCgNkc3QYAyABKAlSA2RzdBI1CglmaWxlX3R5cGUY'
    'BCABKA4yGC5vY2VhbmRvYy5wcm90by5GaWxlVHlwZVIIZmlsZVR5cGUSGwoJZmlsZV9oYXNoGA'
    'UgASgJUghmaWxlSGFzaBIjCg1wYXJ0aXRpb25fbnVtGAYgASgFUgxwYXJ0aXRpb25OdW0SHQoK'
    'cmVxdWVzdF9pZBgHIAEoCVIJcmVxdWVzdElkEiYKAm9wGAggASgOMhYub2NlYW5kb2MucHJvdG'
    '8uRmlsZU9wUgJvcBImCg9jYW5fc2tpcF91cGxvYWQYCSABKAhSDWNhblNraXBVcGxvYWQ=');

const $core.Map<$core.String, $core.dynamic> OceanFileServiceBase$json = {
  '1': 'OceanFile',
  '2': [
    {'1': 'UserOp', '2': '.oceandoc.proto.UserReq', '3': '.oceandoc.proto.UserRes'},
    {'1': 'ServerOp', '2': '.oceandoc.proto.ServerReq', '3': '.oceandoc.proto.ServerRes'},
    {'1': 'RepoOp', '2': '.oceandoc.proto.RepoReq', '3': '.oceandoc.proto.RepoRes'},
    {'1': 'FileOp', '2': '.oceandoc.proto.FileReq', '3': '.oceandoc.proto.FileRes', '5': true, '6': true},
  ],
};

@$core.Deprecated('Use oceanFileServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> OceanFileServiceBase$messageJson = {
  '.oceandoc.proto.UserReq': UserReq$json,
  '.oceandoc.proto.UserRes': UserRes$json,
  '.oceandoc.proto.ServerReq': ServerReq$json,
  '.oceandoc.proto.ServerRes': ServerRes$json,
  '.oceandoc.proto.RepoReq': RepoReq$json,
  '.oceandoc.proto.RepoRes': RepoRes$json,
  '.oceandoc.proto.RepoRes.ReposEntry': RepoRes_ReposEntry$json,
  '.oceandoc.proto.RepoMeta': $0.RepoMeta$json,
  '.oceandoc.proto.RepoDir': $0.RepoDir$json,
  '.oceandoc.proto.RepoDir.FilesEntry': $0.RepoDir_FilesEntry$json,
  '.oceandoc.proto.RepoFile': $0.RepoFile$json,
  '.oceandoc.proto.Dir': $0.Dir$json,
  '.oceandoc.proto.Dir.FilesEntry': $0.Dir_FilesEntry$json,
  '.oceandoc.proto.File': $0.File$json,
  '.oceandoc.proto.FileReq': FileReq$json,
  '.oceandoc.proto.FileRes': FileRes$json,
};

/// Descriptor for `OceanFile`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List oceanFileServiceDescriptor = $convert.base64Decode(
    'CglPY2VhbkZpbGUSOgoGVXNlck9wEhcub2NlYW5kb2MucHJvdG8uVXNlclJlcRoXLm9jZWFuZG'
    '9jLnByb3RvLlVzZXJSZXMSQAoIU2VydmVyT3ASGS5vY2VhbmRvYy5wcm90by5TZXJ2ZXJSZXEa'
    'GS5vY2VhbmRvYy5wcm90by5TZXJ2ZXJSZXMSOgoGUmVwb09wEhcub2NlYW5kb2MucHJvdG8uUm'
    'Vwb1JlcRoXLm9jZWFuZG9jLnByb3RvLlJlcG9SZXMSPgoGRmlsZU9wEhcub2NlYW5kb2MucHJv'
    'dG8uRmlsZVJlcRoXLm9jZWFuZG9jLnByb3RvLkZpbGVSZXMoATAB');

