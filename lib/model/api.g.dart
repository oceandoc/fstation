// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerResponse _$WorkerResponseFromJson(Map<String, dynamic> json) =>
    WorkerResponse(
      status: (json['status'] as num?)?.toInt(),
      error: json['error'],
      message: json['message'] as String?,
      body: json['body'],
    );

Map<String, dynamic> _$WorkerResponseToJson(WorkerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'body': instance.body,
    };
