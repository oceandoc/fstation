import 'package:flutter/widgets.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fstation/util/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

import '../generated/l10n.dart';
import '../ui/dialog.dart';

part 'api.g.dart';

@JsonSerializable()
class WorkerResponse {
  int? status;
  dynamic error;

  String? message;
  dynamic body;

  WorkerResponse({
    this.status,
    this.error,
    this.message,
    this.body,
  });

  factory WorkerResponse.fromJson(Map<String, dynamic> json) => _$WorkerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerResponseToJson(this);

  bool get hasError => error != null;

  String get fullMessage {
    String msg = <String>[
      if (message != null) message!,
      if (error != null) error.toString(),
      if (message == null && body != null) body.toString(),
    ].join('\n');
    return msg.isEmpty ? 'No message' : msg;
  }

  Future<void> showDialog([BuildContext? context]) {
    return SimpleCancelOkDialog(
      title: Text(error != null ? Localization.current.error : Localization.current.success),
      content: Text(fullMessage),
      scrollable: true,
      hideCancel: true,
    ).showDialog(context);
  }

  Future<void> showToast() {
    final msg = fullMessage;
    if (hasError) {
      return EasyLoading.showError(msg);
    } else {
      return EasyLoading.showSuccess(message ?? Localization.current.success);
    }
  }
}
