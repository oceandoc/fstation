// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteConfig _$RemoteConfigFromJson(Map<String, dynamic> json) => RemoteConfig(
      forceUpgradeVersion: json['forceUpgradeVersion'] as String?,
      blockedCarousels: (json['blockedCarousels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blockedErrors: (json['blockedErrors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      urls: json['urls'] == null
          ? null
          : ServerUrlConfig.fromJson(json['urls'] as Map<String, dynamic>),
      silenceStart: (json['silenceStart'] as num?)?.toInt() ?? 0,
      silenceEnd: (json['silenceEnd'] as num?)?.toInt() ?? 0,
      ad: json['ad'] == null
          ? null
          : AdConfig.fromJson(json['ad'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteConfigToJson(RemoteConfig instance) =>
    <String, dynamic>{
      'forceUpgradeVersion': instance.forceUpgradeVersion,
      'blockedCarousels': instance.blockedCarousels,
      'blockedErrors': instance.blockedErrors,
      'urls': instance.urls,
      'silenceStart': instance.silenceStart,
      'silenceEnd': instance.silenceEnd,
      'ad': instance.ad,
    };

ServerUrlConfig _$ServerUrlConfigFromJson(Map<String, dynamic> json) =>
    ServerUrlConfig(
      api: json['api'] == null
          ? null
          : UrlProxy.fromJson(json['api'] as Map<String, dynamic>),
      worker: json['worker'] == null
          ? null
          : UrlProxy.fromJson(json['worker'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : UrlProxy.fromJson(json['data'] as Map<String, dynamic>),
      atlasApi: json['atlasApi'] == null
          ? null
          : UrlProxy.fromJson(json['atlasApi'] as Map<String, dynamic>),
      atlasAsset: json['atlasAsset'] == null
          ? null
          : UrlProxy.fromJson(json['atlasAsset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerUrlConfigToJson(ServerUrlConfig instance) =>
    <String, dynamic>{
      'api': instance.api,
      'worker': instance.worker,
      'data': instance.data,
      'atlasApi': instance.atlasApi,
      'atlasAsset': instance.atlasAsset,
    };

UrlProxy _$UrlProxyFromJson(Map<String, dynamic> json) => UrlProxy._(
      global: json['global'] as String?,
      cn: json['cn'] as String?,
    );

Map<String, dynamic> _$UrlProxyToJson(UrlProxy instance) => <String, dynamic>{
      'global': instance.global,
      'cn': instance.cn,
    };

AdConfig _$AdConfigFromJson(Map<String, dynamic> json) => AdConfig(
      enabled: json['enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$AdConfigToJson(AdConfig instance) => <String, dynamic>{
      'enabled': instance.enabled,
    };

ProxySettings _$ProxySettingsFromJson(Map<String, dynamic> json) =>
    ProxySettings(
      proxy: json['proxy'] as bool? ?? false,
      api: json['api'] as bool?,
      worker: json['worker'] as bool?,
      data: json['data'] as bool?,
      atlasApi: json['atlasApi'] as bool?,
      atlasAsset: json['atlasAsset'] as bool?,
      enableHttpProxy: json['enableHttpProxy'] as bool? ?? false,
      proxyHost: json['proxyHost'] as String?,
      proxyPort: (json['proxyPort'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProxySettingsToJson(ProxySettings instance) =>
    <String, dynamic>{
      'proxy': instance.proxy,
      'api': instance.api,
      'worker': instance.worker,
      'data': instance.data,
      'atlasApi': instance.atlasApi,
      'atlasAsset': instance.atlasAsset,
      'enableHttpProxy': instance.enableHttpProxy,
      'proxyHost': instance.proxyHost,
      'proxyPort': instance.proxyPort,
    };
