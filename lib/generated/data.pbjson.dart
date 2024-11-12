//
//  Generated code. Do not modify.
//  source: data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fileTypeDescriptor instead')
const FileType$json = {
  '1': 'FileType',
  '2': [
    {'1': 'FT_Unused', '2': 0},
    {'1': 'Regular', '2': 1},
    {'1': 'Symlink', '2': 2},
    {'1': 'Direcotry', '2': 3},
  ],
};

/// Descriptor for `FileType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fileTypeDescriptor = $convert.base64Decode(
    'CghGaWxlVHlwZRINCglGVF9VbnVzZWQQABILCgdSZWd1bGFyEAESCwoHU3ltbGluaxACEg0KCU'
    'RpcmVjb3RyeRAD');

@$core.Deprecated('Use repoTypeDescriptor instead')
const RepoType$json = {
  '1': 'RepoType',
  '2': [
    {'1': 'RT_Unused', '2': 0},
    {'1': 'RT_Local', '2': 1},
    {'1': 'RT_Remote', '2': 2},
    {'1': 'RT_Ocean', '2': 3},
  ],
};

/// Descriptor for `RepoType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List repoTypeDescriptor = $convert.base64Decode(
    'CghSZXBvVHlwZRINCglSVF9VbnVzZWQQABIMCghSVF9Mb2NhbBABEg0KCVJUX1JlbW90ZRACEg'
    'wKCFJUX09jZWFuEAM=');

@$core.Deprecated('Use fileDescriptor instead')
const File$json = {
  '1': 'File',
  '2': [
    {'1': 'file_name', '3': 1, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'file_size', '3': 2, '4': 1, '5': 4, '10': 'fileSize'},
    {'1': 'file_type', '3': 3, '4': 1, '5': 14, '6': '.oceandoc.proto.FileType', '10': 'fileType'},
    {'1': 'update_time', '3': 4, '4': 1, '5': 4, '10': 'updateTime'},
    {'1': 'user', '3': 5, '4': 1, '5': 9, '10': 'user'},
    {'1': 'group', '3': 6, '4': 1, '5': 9, '10': 'group'},
    {'1': 'file_hash', '3': 7, '4': 1, '5': 9, '10': 'fileHash'},
    {'1': 'visible_users', '3': 8, '4': 3, '5': 9, '10': 'visibleUsers'},
  ],
};

/// Descriptor for `File`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDescriptor = $convert.base64Decode(
    'CgRGaWxlEhsKCWZpbGVfbmFtZRgBIAEoCVIIZmlsZU5hbWUSGwoJZmlsZV9zaXplGAIgASgEUg'
    'hmaWxlU2l6ZRI1CglmaWxlX3R5cGUYAyABKA4yGC5vY2VhbmRvYy5wcm90by5GaWxlVHlwZVII'
    'ZmlsZVR5cGUSHwoLdXBkYXRlX3RpbWUYBCABKARSCnVwZGF0ZVRpbWUSEgoEdXNlchgFIAEoCV'
    'IEdXNlchIUCgVncm91cBgGIAEoCVIFZ3JvdXASGwoJZmlsZV9oYXNoGAcgASgJUghmaWxlSGFz'
    'aBIjCg12aXNpYmxlX3VzZXJzGAggAygJUgx2aXNpYmxlVXNlcnM=');

@$core.Deprecated('Use dirDescriptor instead')
const Dir$json = {
  '1': 'Dir',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'update_time', '3': 2, '4': 1, '5': 4, '10': 'updateTime'},
    {'1': 'user', '3': 3, '4': 1, '5': 9, '10': 'user'},
    {'1': 'group', '3': 4, '4': 1, '5': 9, '10': 'group'},
    {'1': 'files', '3': 5, '4': 3, '5': 11, '6': '.oceandoc.proto.Dir.FilesEntry', '10': 'files'},
    {'1': 'visible_users', '3': 6, '4': 3, '5': 9, '10': 'visibleUsers'},
  ],
  '3': [Dir_FilesEntry$json],
};

@$core.Deprecated('Use dirDescriptor instead')
const Dir_FilesEntry$json = {
  '1': 'FilesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.oceandoc.proto.File', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Dir`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dirDescriptor = $convert.base64Decode(
    'CgNEaXISEgoEcGF0aBgBIAEoCVIEcGF0aBIfCgt1cGRhdGVfdGltZRgCIAEoBFIKdXBkYXRlVG'
    'ltZRISCgR1c2VyGAMgASgJUgR1c2VyEhQKBWdyb3VwGAQgASgJUgVncm91cBI0CgVmaWxlcxgF'
    'IAMoCzIeLm9jZWFuZG9jLnByb3RvLkRpci5GaWxlc0VudHJ5UgVmaWxlcxIjCg12aXNpYmxlX3'
    'VzZXJzGAYgAygJUgx2aXNpYmxlVXNlcnMaTgoKRmlsZXNFbnRyeRIQCgNrZXkYASABKAlSA2tl'
    'eRIqCgV2YWx1ZRgCIAEoCzIULm9jZWFuZG9jLnByb3RvLkZpbGVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use scanStatusDescriptor instead')
const ScanStatus$json = {
  '1': 'ScanStatus',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'scanned_dirs', '3': 2, '4': 3, '5': 11, '6': '.oceandoc.proto.ScanStatus.ScannedDirsEntry', '10': 'scannedDirs'},
    {'1': 'complete_time', '3': 4, '4': 1, '5': 3, '10': 'completeTime'},
    {'1': 'ignored_dirs', '3': 5, '4': 3, '5': 11, '6': '.oceandoc.proto.ScanStatus.IgnoredDirsEntry', '10': 'ignoredDirs'},
    {'1': 'uuid', '3': 6, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'file_num', '3': 7, '4': 1, '5': 3, '10': 'fileNum'},
    {'1': 'symlink_num', '3': 8, '4': 1, '5': 3, '10': 'symlinkNum'},
    {'1': 'hash_method', '3': 9, '4': 1, '5': 5, '10': 'hashMethod'},
  ],
  '3': [ScanStatus_ScannedDirsEntry$json, ScanStatus_IgnoredDirsEntry$json],
};

@$core.Deprecated('Use scanStatusDescriptor instead')
const ScanStatus_ScannedDirsEntry$json = {
  '1': 'ScannedDirsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.oceandoc.proto.Dir', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use scanStatusDescriptor instead')
const ScanStatus_IgnoredDirsEntry$json = {
  '1': 'IgnoredDirsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 8, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ScanStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scanStatusDescriptor = $convert.base64Decode(
    'CgpTY2FuU3RhdHVzEhIKBHBhdGgYASABKAlSBHBhdGgSTgoMc2Nhbm5lZF9kaXJzGAIgAygLMi'
    'sub2NlYW5kb2MucHJvdG8uU2NhblN0YXR1cy5TY2FubmVkRGlyc0VudHJ5UgtzY2FubmVkRGly'
    'cxIjCg1jb21wbGV0ZV90aW1lGAQgASgDUgxjb21wbGV0ZVRpbWUSTgoMaWdub3JlZF9kaXJzGA'
    'UgAygLMisub2NlYW5kb2MucHJvdG8uU2NhblN0YXR1cy5JZ25vcmVkRGlyc0VudHJ5UgtpZ25v'
    'cmVkRGlycxISCgR1dWlkGAYgASgJUgR1dWlkEhkKCGZpbGVfbnVtGAcgASgDUgdmaWxlTnVtEh'
    '8KC3N5bWxpbmtfbnVtGAggASgDUgpzeW1saW5rTnVtEh8KC2hhc2hfbWV0aG9kGAkgASgFUgpo'
    'YXNoTWV0aG9kGlMKEFNjYW5uZWREaXJzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSKQoFdmFsdW'
    'UYAiABKAsyEy5vY2VhbmRvYy5wcm90by5EaXJSBXZhbHVlOgI4ARo+ChBJZ25vcmVkRGlyc0Vu'
    'dHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgIUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use repoFileDescriptor instead')
const RepoFile$json = {
  '1': 'RepoFile',
  '2': [
    {'1': 'file_name', '3': 1, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'file_hash', '3': 2, '4': 1, '5': 9, '10': 'fileHash'},
    {'1': 'visible_users', '3': 3, '4': 3, '5': 9, '10': 'visibleUsers'},
  ],
};

/// Descriptor for `RepoFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoFileDescriptor = $convert.base64Decode(
    'CghSZXBvRmlsZRIbCglmaWxlX25hbWUYASABKAlSCGZpbGVOYW1lEhsKCWZpbGVfaGFzaBgCIA'
    'EoCVIIZmlsZUhhc2gSIwoNdmlzaWJsZV91c2VycxgDIAMoCVIMdmlzaWJsZVVzZXJz');

@$core.Deprecated('Use repoDirDescriptor instead')
const RepoDir$json = {
  '1': 'RepoDir',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'files', '3': 2, '4': 3, '5': 11, '6': '.oceandoc.proto.RepoDir.FilesEntry', '10': 'files'},
    {'1': 'visible_users', '3': 3, '4': 3, '5': 9, '10': 'visibleUsers'},
  ],
  '3': [RepoDir_FilesEntry$json],
};

@$core.Deprecated('Use repoDirDescriptor instead')
const RepoDir_FilesEntry$json = {
  '1': 'FilesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.oceandoc.proto.RepoFile', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RepoDir`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoDirDescriptor = $convert.base64Decode(
    'CgdSZXBvRGlyEhIKBHBhdGgYASABKAlSBHBhdGgSOAoFZmlsZXMYAiADKAsyIi5vY2VhbmRvYy'
    '5wcm90by5SZXBvRGlyLkZpbGVzRW50cnlSBWZpbGVzEiMKDXZpc2libGVfdXNlcnMYAyADKAlS'
    'DHZpc2libGVVc2VycxpSCgpGaWxlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5Ei4KBXZhbHVlGA'
    'IgASgLMhgub2NlYW5kb2MucHJvdG8uUmVwb0ZpbGVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use repoDataDescriptor instead')
const RepoData$json = {
  '1': 'RepoData',
  '2': [
    {'1': 'repo_name', '3': 1, '4': 1, '5': 9, '10': 'repoName'},
    {'1': 'repo_path', '3': 2, '4': 1, '5': 9, '10': 'repoPath'},
    {'1': 'repo_uuid', '3': 3, '4': 1, '5': 9, '10': 'repoUuid'},
    {'1': 'repo_location_uuid', '3': 4, '4': 1, '5': 9, '10': 'repoLocationUuid'},
    {'1': 'file_num', '3': 5, '4': 1, '5': 4, '10': 'fileNum'},
    {'1': 'symlink_num', '3': 6, '4': 1, '5': 4, '10': 'symlinkNum'},
    {'1': 'dirs', '3': 7, '4': 3, '5': 11, '6': '.oceandoc.proto.RepoData.DirsEntry', '10': 'dirs'},
  ],
  '3': [RepoData_DirsEntry$json],
};

@$core.Deprecated('Use repoDataDescriptor instead')
const RepoData_DirsEntry$json = {
  '1': 'DirsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.oceandoc.proto.RepoDir', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RepoData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoDataDescriptor = $convert.base64Decode(
    'CghSZXBvRGF0YRIbCglyZXBvX25hbWUYASABKAlSCHJlcG9OYW1lEhsKCXJlcG9fcGF0aBgCIA'
    'EoCVIIcmVwb1BhdGgSGwoJcmVwb191dWlkGAMgASgJUghyZXBvVXVpZBIsChJyZXBvX2xvY2F0'
    'aW9uX3V1aWQYBCABKAlSEHJlcG9Mb2NhdGlvblV1aWQSGQoIZmlsZV9udW0YBSABKARSB2ZpbG'
    'VOdW0SHwoLc3ltbGlua19udW0YBiABKARSCnN5bWxpbmtOdW0SNgoEZGlycxgHIAMoCzIiLm9j'
    'ZWFuZG9jLnByb3RvLlJlcG9EYXRhLkRpcnNFbnRyeVIEZGlycxpQCglEaXJzRW50cnkSEAoDa2'
    'V5GAEgASgJUgNrZXkSLQoFdmFsdWUYAiABKAsyFy5vY2VhbmRvYy5wcm90by5SZXBvRGlyUgV2'
    'YWx1ZToCOAE=');

@$core.Deprecated('Use repoMetaDescriptor instead')
const RepoMeta$json = {
  '1': 'RepoMeta',
  '2': [
    {'1': 'repo_name', '3': 1, '4': 1, '5': 9, '10': 'repoName'},
    {'1': 'repo_path', '3': 2, '4': 1, '5': 9, '10': 'repoPath'},
    {'1': 'repo_uuid', '3': 3, '4': 1, '5': 9, '10': 'repoUuid'},
    {'1': 'repo_location_uuid', '3': 4, '4': 1, '5': 9, '10': 'repoLocationUuid'},
    {'1': 'create_time', '3': 5, '4': 1, '5': 9, '10': 'createTime'},
    {'1': 'update_time', '3': 6, '4': 1, '5': 9, '10': 'updateTime'},
    {'1': 'owner', '3': 7, '4': 1, '5': 9, '10': 'owner'},
  ],
};

/// Descriptor for `RepoMeta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoMetaDescriptor = $convert.base64Decode(
    'CghSZXBvTWV0YRIbCglyZXBvX25hbWUYASABKAlSCHJlcG9OYW1lEhsKCXJlcG9fcGF0aBgCIA'
    'EoCVIIcmVwb1BhdGgSGwoJcmVwb191dWlkGAMgASgJUghyZXBvVXVpZBIsChJyZXBvX2xvY2F0'
    'aW9uX3V1aWQYBCABKAlSEHJlcG9Mb2NhdGlvblV1aWQSHwoLY3JlYXRlX3RpbWUYBSABKAlSCm'
    'NyZWF0ZVRpbWUSHwoLdXBkYXRlX3RpbWUYBiABKAlSCnVwZGF0ZVRpbWUSFAoFb3duZXIYByAB'
    'KAlSBW93bmVy');

@$core.Deprecated('Use reposDescriptor instead')
const Repos$json = {
  '1': 'Repos',
  '2': [
    {'1': 'repos', '3': 1, '4': 3, '5': 11, '6': '.oceandoc.proto.Repos.ReposEntry', '10': 'repos'},
  ],
  '3': [Repos_ReposEntry$json],
};

@$core.Deprecated('Use reposDescriptor instead')
const Repos_ReposEntry$json = {
  '1': 'ReposEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.oceandoc.proto.RepoMeta', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Repos`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reposDescriptor = $convert.base64Decode(
    'CgVSZXBvcxI2CgVyZXBvcxgBIAMoCzIgLm9jZWFuZG9jLnByb3RvLlJlcG9zLlJlcG9zRW50cn'
    'lSBXJlcG9zGlIKClJlcG9zRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSLgoFdmFsdWUYAiABKAsy'
    'GC5vY2VhbmRvYy5wcm90by5SZXBvTWV0YVIFdmFsdWU6AjgB');

