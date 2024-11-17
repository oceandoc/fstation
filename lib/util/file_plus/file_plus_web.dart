import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'file_plus.dart';

const fsName = 'webfs';

/// all async methods are not async actually
class FilePlusWeb implements FilePlus {

  FilePlusWeb(String fp, {Uint8List? box})
      : _path = normalizePath(fp),
        _box = box;
  static late Uint8List _defaultBox;

  final String _path;
  final Uint8List? _box;

  Uint8List get effectiveBox => _box ?? _defaultBox;

  static Future<void> initWebFileSystem() async {
    assert(kIsWeb, 'DO NOT init for non-web');
  }

  static String normalizePath(String fp) {
    return fp
        .split(RegExp(r'[/\\]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .join('/');
  }

  @override
  String get path => _path;

  @override
  Future<bool> exists() => Future.value(existsSync());

  /// failed
  @override
  Uint8List readAsBytesSync() {
    throw UnimplementedError('Sync read is not available on web');
  }

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) =>
      readAsString(encoding: encoding).then((value) => value.split('\n'));

  /// failed
  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) =>
      readAsStringSync(encoding: encoding).split('\n');

  @override
  Future<String> readAsString({Encoding encoding = utf8}) =>
      readAsBytes().then((value) => encoding.decode(value));

  /// failed
  @override
  String readAsStringSync({Encoding encoding = utf8}) =>
      encoding.decode(readAsBytesSync());

  /// not sync
  @override
  void writeAsBytesSync(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    writeAsBytes(bytes);
  }

  @override
  Future<FilePlus> writeAsString(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    return writeAsBytes(encoding.encode(contents), mode: mode, flush: flush);
  }

  /// not sync
  @override
  void writeAsStringSync(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    writeAsString(contents, mode: mode, encoding: encoding, flush: flush);
  }

  @override
  Future<void> create({bool recursive = false}) => Future.value();

  @override
  void createSync({bool recursive = false}) {}

  @override
  Future<void> deleteSafe() => Future.value();

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  bool existsSync() {
    // TODO: implement existsSync
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readAsBytes() {
    // TODO: implement readAsBytes
    throw UnimplementedError();
  }

  @override
  Future<FilePlus> writeAsBytes(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    // TODO: implement writeAsBytes
    throw UnimplementedError();
  }
}
