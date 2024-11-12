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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'data.pbenum.dart';

export 'data.pbenum.dart';

class File extends $pb.GeneratedMessage {
  factory File({
    $core.String? fileName,
    $fixnum.Int64? fileSize,
    FileType? fileType,
    $fixnum.Int64? updateTime,
    $core.String? user,
    $core.String? group,
    $core.String? fileHash,
    $core.Iterable<$core.String>? visibleUsers,
  }) {
    final $result = create();
    if (fileName != null) {
      $result.fileName = fileName;
    }
    if (fileSize != null) {
      $result.fileSize = fileSize;
    }
    if (fileType != null) {
      $result.fileType = fileType;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (user != null) {
      $result.user = user;
    }
    if (group != null) {
      $result.group = group;
    }
    if (fileHash != null) {
      $result.fileHash = fileHash;
    }
    if (visibleUsers != null) {
      $result.visibleUsers.addAll(visibleUsers);
    }
    return $result;
  }
  File._() : super();
  factory File.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory File.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'File', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileName')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'fileSize', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<FileType>(3, _omitFieldNames ? '' : 'fileType', $pb.PbFieldType.OE, defaultOrMaker: FileType.FT_Unused, valueOf: FileType.valueOf, enumValues: FileType.values)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'updateTime', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'user')
    ..aOS(6, _omitFieldNames ? '' : 'group')
    ..aOS(7, _omitFieldNames ? '' : 'fileHash')
    ..pPS(8, _omitFieldNames ? '' : 'visibleUsers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  File clone() => File()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  File copyWith(void Function(File) updates) => super.copyWith((message) => updates(message as File)) as File;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static File create() => File._();
  File createEmptyInstance() => create();
  static $pb.PbList<File> createRepeated() => $pb.PbList<File>();
  @$core.pragma('dart2js:noInline')
  static File getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<File>(create);
  static File? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileName() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fileSize => $_getI64(1);
  @$pb.TagNumber(2)
  set fileSize($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileSize() => clearField(2);

  @$pb.TagNumber(3)
  FileType get fileType => $_getN(2);
  @$pb.TagNumber(3)
  set fileType(FileType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFileType() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileType() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get updateTime => $_getI64(3);
  @$pb.TagNumber(4)
  set updateTime($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUpdateTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdateTime() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get user => $_getSZ(4);
  @$pb.TagNumber(5)
  set user($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUser() => $_has(4);
  @$pb.TagNumber(5)
  void clearUser() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get group => $_getSZ(5);
  @$pb.TagNumber(6)
  set group($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGroup() => $_has(5);
  @$pb.TagNumber(6)
  void clearGroup() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get fileHash => $_getSZ(6);
  @$pb.TagNumber(7)
  set fileHash($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFileHash() => $_has(6);
  @$pb.TagNumber(7)
  void clearFileHash() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get visibleUsers => $_getList(7);
}

class Dir extends $pb.GeneratedMessage {
  factory Dir({
    $core.String? path,
    $fixnum.Int64? updateTime,
    $core.String? user,
    $core.String? group,
    $core.Map<$core.String, File>? files,
    $core.Iterable<$core.String>? visibleUsers,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (user != null) {
      $result.user = user;
    }
    if (group != null) {
      $result.group = group;
    }
    if (files != null) {
      $result.files.addAll(files);
    }
    if (visibleUsers != null) {
      $result.visibleUsers.addAll(visibleUsers);
    }
    return $result;
  }
  Dir._() : super();
  factory Dir.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Dir.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Dir', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'updateTime', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'user')
    ..aOS(4, _omitFieldNames ? '' : 'group')
    ..m<$core.String, File>(5, _omitFieldNames ? '' : 'files', entryClassName: 'Dir.FilesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: File.create, valueDefaultOrMaker: File.getDefault, packageName: const $pb.PackageName('oceandoc.proto'))
    ..pPS(6, _omitFieldNames ? '' : 'visibleUsers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Dir clone() => Dir()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Dir copyWith(void Function(Dir) updates) => super.copyWith((message) => updates(message as Dir)) as Dir;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Dir create() => Dir._();
  Dir createEmptyInstance() => create();
  static $pb.PbList<Dir> createRepeated() => $pb.PbList<Dir>();
  @$core.pragma('dart2js:noInline')
  static Dir getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Dir>(create);
  static Dir? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get updateTime => $_getI64(1);
  @$pb.TagNumber(2)
  set updateTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get user => $_getSZ(2);
  @$pb.TagNumber(3)
  set user($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get group => $_getSZ(3);
  @$pb.TagNumber(4)
  set group($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGroup() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroup() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, File> get files => $_getMap(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get visibleUsers => $_getList(5);
}

class ScanStatus extends $pb.GeneratedMessage {
  factory ScanStatus({
    $core.String? path,
    $core.Map<$core.String, Dir>? scannedDirs,
    $fixnum.Int64? completeTime,
    $core.Map<$core.String, $core.bool>? ignoredDirs,
    $core.String? uuid,
    $fixnum.Int64? fileNum,
    $fixnum.Int64? symlinkNum,
    $core.int? hashMethod,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (scannedDirs != null) {
      $result.scannedDirs.addAll(scannedDirs);
    }
    if (completeTime != null) {
      $result.completeTime = completeTime;
    }
    if (ignoredDirs != null) {
      $result.ignoredDirs.addAll(ignoredDirs);
    }
    if (uuid != null) {
      $result.uuid = uuid;
    }
    if (fileNum != null) {
      $result.fileNum = fileNum;
    }
    if (symlinkNum != null) {
      $result.symlinkNum = symlinkNum;
    }
    if (hashMethod != null) {
      $result.hashMethod = hashMethod;
    }
    return $result;
  }
  ScanStatus._() : super();
  factory ScanStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScanStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScanStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..m<$core.String, Dir>(2, _omitFieldNames ? '' : 'scannedDirs', entryClassName: 'ScanStatus.ScannedDirsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Dir.create, valueDefaultOrMaker: Dir.getDefault, packageName: const $pb.PackageName('oceandoc.proto'))
    ..aInt64(4, _omitFieldNames ? '' : 'completeTime')
    ..m<$core.String, $core.bool>(5, _omitFieldNames ? '' : 'ignoredDirs', entryClassName: 'ScanStatus.IgnoredDirsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OB, packageName: const $pb.PackageName('oceandoc.proto'))
    ..aOS(6, _omitFieldNames ? '' : 'uuid')
    ..aInt64(7, _omitFieldNames ? '' : 'fileNum')
    ..aInt64(8, _omitFieldNames ? '' : 'symlinkNum')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'hashMethod', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScanStatus clone() => ScanStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScanStatus copyWith(void Function(ScanStatus) updates) => super.copyWith((message) => updates(message as ScanStatus)) as ScanStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScanStatus create() => ScanStatus._();
  ScanStatus createEmptyInstance() => create();
  static $pb.PbList<ScanStatus> createRepeated() => $pb.PbList<ScanStatus>();
  @$core.pragma('dart2js:noInline')
  static ScanStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScanStatus>(create);
  static ScanStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, Dir> get scannedDirs => $_getMap(1);

  @$pb.TagNumber(4)
  $fixnum.Int64 get completeTime => $_getI64(2);
  @$pb.TagNumber(4)
  set completeTime($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompleteTime() => $_has(2);
  @$pb.TagNumber(4)
  void clearCompleteTime() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.bool> get ignoredDirs => $_getMap(3);

  @$pb.TagNumber(6)
  $core.String get uuid => $_getSZ(4);
  @$pb.TagNumber(6)
  set uuid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasUuid() => $_has(4);
  @$pb.TagNumber(6)
  void clearUuid() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get fileNum => $_getI64(5);
  @$pb.TagNumber(7)
  set fileNum($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasFileNum() => $_has(5);
  @$pb.TagNumber(7)
  void clearFileNum() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get symlinkNum => $_getI64(6);
  @$pb.TagNumber(8)
  set symlinkNum($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasSymlinkNum() => $_has(6);
  @$pb.TagNumber(8)
  void clearSymlinkNum() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get hashMethod => $_getIZ(7);
  @$pb.TagNumber(9)
  set hashMethod($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasHashMethod() => $_has(7);
  @$pb.TagNumber(9)
  void clearHashMethod() => clearField(9);
}

class RepoFile extends $pb.GeneratedMessage {
  factory RepoFile({
    $core.String? fileName,
    $core.String? fileHash,
    $core.Iterable<$core.String>? visibleUsers,
  }) {
    final $result = create();
    if (fileName != null) {
      $result.fileName = fileName;
    }
    if (fileHash != null) {
      $result.fileHash = fileHash;
    }
    if (visibleUsers != null) {
      $result.visibleUsers.addAll(visibleUsers);
    }
    return $result;
  }
  RepoFile._() : super();
  factory RepoFile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepoFile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepoFile', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileName')
    ..aOS(2, _omitFieldNames ? '' : 'fileHash')
    ..pPS(3, _omitFieldNames ? '' : 'visibleUsers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepoFile clone() => RepoFile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepoFile copyWith(void Function(RepoFile) updates) => super.copyWith((message) => updates(message as RepoFile)) as RepoFile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoFile create() => RepoFile._();
  RepoFile createEmptyInstance() => create();
  static $pb.PbList<RepoFile> createRepeated() => $pb.PbList<RepoFile>();
  @$core.pragma('dart2js:noInline')
  static RepoFile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepoFile>(create);
  static RepoFile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileHash() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get visibleUsers => $_getList(2);
}

class RepoDir extends $pb.GeneratedMessage {
  factory RepoDir({
    $core.String? path,
    $core.Map<$core.String, RepoFile>? files,
    $core.Iterable<$core.String>? visibleUsers,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (files != null) {
      $result.files.addAll(files);
    }
    if (visibleUsers != null) {
      $result.visibleUsers.addAll(visibleUsers);
    }
    return $result;
  }
  RepoDir._() : super();
  factory RepoDir.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepoDir.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepoDir', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..m<$core.String, RepoFile>(2, _omitFieldNames ? '' : 'files', entryClassName: 'RepoDir.FilesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: RepoFile.create, valueDefaultOrMaker: RepoFile.getDefault, packageName: const $pb.PackageName('oceandoc.proto'))
    ..pPS(3, _omitFieldNames ? '' : 'visibleUsers')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepoDir clone() => RepoDir()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepoDir copyWith(void Function(RepoDir) updates) => super.copyWith((message) => updates(message as RepoDir)) as RepoDir;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoDir create() => RepoDir._();
  RepoDir createEmptyInstance() => create();
  static $pb.PbList<RepoDir> createRepeated() => $pb.PbList<RepoDir>();
  @$core.pragma('dart2js:noInline')
  static RepoDir getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepoDir>(create);
  static RepoDir? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, RepoFile> get files => $_getMap(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get visibleUsers => $_getList(2);
}

class RepoData extends $pb.GeneratedMessage {
  factory RepoData({
    $core.String? repoName,
    $core.String? repoPath,
    $core.String? repoUuid,
    $core.String? repoLocationUuid,
    $fixnum.Int64? fileNum,
    $fixnum.Int64? symlinkNum,
    $core.Map<$core.String, RepoDir>? dirs,
  }) {
    final $result = create();
    if (repoName != null) {
      $result.repoName = repoName;
    }
    if (repoPath != null) {
      $result.repoPath = repoPath;
    }
    if (repoUuid != null) {
      $result.repoUuid = repoUuid;
    }
    if (repoLocationUuid != null) {
      $result.repoLocationUuid = repoLocationUuid;
    }
    if (fileNum != null) {
      $result.fileNum = fileNum;
    }
    if (symlinkNum != null) {
      $result.symlinkNum = symlinkNum;
    }
    if (dirs != null) {
      $result.dirs.addAll(dirs);
    }
    return $result;
  }
  RepoData._() : super();
  factory RepoData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepoData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepoData', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'repoName')
    ..aOS(2, _omitFieldNames ? '' : 'repoPath')
    ..aOS(3, _omitFieldNames ? '' : 'repoUuid')
    ..aOS(4, _omitFieldNames ? '' : 'repoLocationUuid')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'fileNum', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'symlinkNum', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..m<$core.String, RepoDir>(7, _omitFieldNames ? '' : 'dirs', entryClassName: 'RepoData.DirsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: RepoDir.create, valueDefaultOrMaker: RepoDir.getDefault, packageName: const $pb.PackageName('oceandoc.proto'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepoData clone() => RepoData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepoData copyWith(void Function(RepoData) updates) => super.copyWith((message) => updates(message as RepoData)) as RepoData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoData create() => RepoData._();
  RepoData createEmptyInstance() => create();
  static $pb.PbList<RepoData> createRepeated() => $pb.PbList<RepoData>();
  @$core.pragma('dart2js:noInline')
  static RepoData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepoData>(create);
  static RepoData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get repoName => $_getSZ(0);
  @$pb.TagNumber(1)
  set repoName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRepoName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRepoName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get repoPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set repoPath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRepoPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearRepoPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get repoUuid => $_getSZ(2);
  @$pb.TagNumber(3)
  set repoUuid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRepoUuid() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepoUuid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get repoLocationUuid => $_getSZ(3);
  @$pb.TagNumber(4)
  set repoLocationUuid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRepoLocationUuid() => $_has(3);
  @$pb.TagNumber(4)
  void clearRepoLocationUuid() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fileNum => $_getI64(4);
  @$pb.TagNumber(5)
  set fileNum($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFileNum() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileNum() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get symlinkNum => $_getI64(5);
  @$pb.TagNumber(6)
  set symlinkNum($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSymlinkNum() => $_has(5);
  @$pb.TagNumber(6)
  void clearSymlinkNum() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, RepoDir> get dirs => $_getMap(6);
}

class RepoMeta extends $pb.GeneratedMessage {
  factory RepoMeta({
    $core.String? repoName,
    $core.String? repoPath,
    $core.String? repoUuid,
    $core.String? repoLocationUuid,
    $core.String? createTime,
    $core.String? updateTime,
    $core.String? owner,
  }) {
    final $result = create();
    if (repoName != null) {
      $result.repoName = repoName;
    }
    if (repoPath != null) {
      $result.repoPath = repoPath;
    }
    if (repoUuid != null) {
      $result.repoUuid = repoUuid;
    }
    if (repoLocationUuid != null) {
      $result.repoLocationUuid = repoLocationUuid;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (owner != null) {
      $result.owner = owner;
    }
    return $result;
  }
  RepoMeta._() : super();
  factory RepoMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepoMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepoMeta', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'repoName')
    ..aOS(2, _omitFieldNames ? '' : 'repoPath')
    ..aOS(3, _omitFieldNames ? '' : 'repoUuid')
    ..aOS(4, _omitFieldNames ? '' : 'repoLocationUuid')
    ..aOS(5, _omitFieldNames ? '' : 'createTime')
    ..aOS(6, _omitFieldNames ? '' : 'updateTime')
    ..aOS(7, _omitFieldNames ? '' : 'owner')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepoMeta clone() => RepoMeta()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepoMeta copyWith(void Function(RepoMeta) updates) => super.copyWith((message) => updates(message as RepoMeta)) as RepoMeta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoMeta create() => RepoMeta._();
  RepoMeta createEmptyInstance() => create();
  static $pb.PbList<RepoMeta> createRepeated() => $pb.PbList<RepoMeta>();
  @$core.pragma('dart2js:noInline')
  static RepoMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepoMeta>(create);
  static RepoMeta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get repoName => $_getSZ(0);
  @$pb.TagNumber(1)
  set repoName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRepoName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRepoName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get repoPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set repoPath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRepoPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearRepoPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get repoUuid => $_getSZ(2);
  @$pb.TagNumber(3)
  set repoUuid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRepoUuid() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepoUuid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get repoLocationUuid => $_getSZ(3);
  @$pb.TagNumber(4)
  set repoLocationUuid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRepoLocationUuid() => $_has(3);
  @$pb.TagNumber(4)
  void clearRepoLocationUuid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createTime => $_getSZ(4);
  @$pb.TagNumber(5)
  set createTime($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreateTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreateTime() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get updateTime => $_getSZ(5);
  @$pb.TagNumber(6)
  set updateTime($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdateTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateTime() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get owner => $_getSZ(6);
  @$pb.TagNumber(7)
  set owner($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOwner() => $_has(6);
  @$pb.TagNumber(7)
  void clearOwner() => clearField(7);
}

class Repos extends $pb.GeneratedMessage {
  factory Repos({
    $core.Map<$core.String, RepoMeta>? repos,
  }) {
    final $result = create();
    if (repos != null) {
      $result.repos.addAll(repos);
    }
    return $result;
  }
  Repos._() : super();
  factory Repos.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Repos.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Repos', package: const $pb.PackageName(_omitMessageNames ? '' : 'oceandoc.proto'), createEmptyInstance: create)
    ..m<$core.String, RepoMeta>(1, _omitFieldNames ? '' : 'repos', entryClassName: 'Repos.ReposEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: RepoMeta.create, valueDefaultOrMaker: RepoMeta.getDefault, packageName: const $pb.PackageName('oceandoc.proto'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Repos clone() => Repos()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Repos copyWith(void Function(Repos) updates) => super.copyWith((message) => updates(message as Repos)) as Repos;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Repos create() => Repos._();
  Repos createEmptyInstance() => create();
  static $pb.PbList<Repos> createRepeated() => $pb.PbList<Repos>();
  @$core.pragma('dart2js:noInline')
  static Repos getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Repos>(create);
  static Repos? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, RepoMeta> get repos => $_getMap(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
