import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:build/build.dart';

class GitInfoBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$lib$': ['generated/git_info.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Get the latest commit hash
    final hashResult = await Process.run('git', ['rev-parse', 'HEAD']);
    final commitHash = hashResult.stdout.toString().trim();

    // Get the latest commit timestamp
    final timeResult = await Process.run('git', ['log', '-1', '--format=%ct']);
    final commitTimestamp = timeResult.stdout.toString().trim();

    final outputId =
        AssetId(buildStep.inputId.package, 'lib/generated/git_info.dart');
    final content = '''
    // GENERATED CODE - DO NOT MODIFY BY HAND
    const String kCommitHash = ${json.encode(commitHash)};
    const int kCommitTimestamp = ${int.parse(commitTimestamp)};
    ''';

    await buildStep.writeAsString(outputId, content);
  }
}

Builder gitInfoBuilder(BuilderOptions options) => GitInfoBuilder();
