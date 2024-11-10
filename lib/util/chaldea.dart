import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../model/api.dart';
import '../model/remote_config.dart';
import 'language.dart';

// ignore: unused_element
bool _defaultValidateStat(int? statusCode) {
  return statusCode != null && statusCode >= 200 && statusCode < 500;
}

class ChaldeaWorkerApi {
  ChaldeaWorkerApi._();

  static const apiV4 = '/api/v4';


  static void dispatchError(RequestOptions options, Response? response,
      dynamic error, dynamic stackTrace) async {
    dynamic error2;
    if (response != null) {
      String? text;
      try {
        if (response.data is List<int>) {
          text = utf8.decode(response.data as List<int>);
        } else if (response.data is String) {
          text = response.data as String;
        } else if (response.data is Map) {
          text = jsonEncode(response.data);
        }
      } catch (e) {
        //
      }
      if (text != null) {
        try {
          final resp = WorkerResponse.fromJson(jsonDecode(text) as Map<String, dynamic>);
          error2 = resp.error ?? resp.message ?? resp.body;
        } catch (e) {
          error2 = text;
        }
      }
    }
    error2 ??= error;
    if (EasyLoading.instance.overlayEntry?.mounted != true) return;
    String msg = error2.toString();
    if (response?.statusCode == 500 &&
        msg.contains('D1_ERROR: Error 9000: something went wrong')) {
      // msg += Language.isZH ? '\n目前服务器不稳定，请稍后重试s' : '\nThe server is currently unstable, please try again later';
    }
    EasyLoading.showError(msg);
  }


  static Options addAuthHeader({Options? options}) {
    options ??= Options();
    final secret = "";
    String? authHeader;
    if (secret.isNotEmpty) {
      authHeader = secret;
    }
    if (authHeader == null) {
      return options;
    }
    options.headers = {
      ...?options.headers,
      "Authorization": "Basic $authHeader",
    };
    return options;
  }


  // to chaldea server rather worker
  static Future<WorkerResponse?> sendFeedback({
    String? subject,
    String? senderName,
    String? html,
    String? text,
    // <filename, bytes>
    Map<String, Uint8List> files = const {},
  }) {
    var formData = FormData.fromMap({
      if (html != null) 'html': html,
      if (text != null) 'text': text,
      if (subject != null) 'subject': subject,
      if (senderName != null) 'sender': senderName,
      'files': [
        for (final file in files.entries) MultipartFile.fromBytes(
            file.value, filename: file.key),
      ]
    });
    return postCommon("${HostsX.apiHost}/feedback", formData);
  }

  static Future<WorkerResponse?> postCommon(String url,
      dynamic data, {
        Options? options,
        bool addAuth = false,
      }) {
    return Future.value(WorkerResponse());
    // return cacheManager.postModel(
    //   url,
    //   fromJson: (data) => WorkerResponse.fromJson(data),
    //   data: data,
    //   expireAfter: Duration.zero,
    //   options: addAuth ? addAuthHeader(options: options) : options,
    // );
  }
} // ChaldeaWorkerApi

