//
//  Generated code. Do not modify.
//  source: data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FileType extends $pb.ProtobufEnum {
  static const FileType FT_Unused = FileType._(0, _omitEnumNames ? '' : 'FT_Unused');
  static const FileType Regular = FileType._(1, _omitEnumNames ? '' : 'Regular');
  static const FileType Symlink = FileType._(2, _omitEnumNames ? '' : 'Symlink');
  static const FileType Direcotry = FileType._(3, _omitEnumNames ? '' : 'Direcotry');

  static const $core.List<FileType> values = <FileType> [
    FT_Unused,
    Regular,
    Symlink,
    Direcotry,
  ];

  static final $core.Map<$core.int, FileType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FileType? valueOf($core.int value) => _byValue[value];

  const FileType._($core.int v, $core.String n) : super(v, n);
}

class RepoType extends $pb.ProtobufEnum {
  static const RepoType RT_Unused = RepoType._(0, _omitEnumNames ? '' : 'RT_Unused');
  static const RepoType RT_Local = RepoType._(1, _omitEnumNames ? '' : 'RT_Local');
  static const RepoType RT_Remote = RepoType._(2, _omitEnumNames ? '' : 'RT_Remote');
  static const RepoType RT_Ocean = RepoType._(3, _omitEnumNames ? '' : 'RT_Ocean');

  static const $core.List<RepoType> values = <RepoType> [
    RT_Unused,
    RT_Local,
    RT_Remote,
    RT_Ocean,
  ];

  static final $core.Map<$core.int, RepoType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RepoType? valueOf($core.int value) => _byValue[value];

  const RepoType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
