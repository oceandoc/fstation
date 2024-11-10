import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:build/build.dart';

class GitInfoBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$package$': ['lib/generated/git_info.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final result = await Process.run('git', ['log', '-1', '--pretty=%B']);
    final commitMessage = result.stdout.toString().trim();

    final outputId = AssetId(buildStep.inputId.package, 'lib/generated/git_info.dart');
    final content = '''
    // GENERATED CODE - DO NOT MODIFY BY HAND
    final String gitCommitMessage = ${json.encode(commitMessage)};
    ''';

    await buildStep.writeAsString(outputId, content);
  }
}

Builder gitInfoBuilder(BuilderOptions options) => GitInfoBuilder();