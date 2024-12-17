import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fstation/impl/setting_impl.dart';
import 'package:fstation/impl/user_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:photo_manager/photo_manager.dart' as pm;

import '../bloc/auth_session_bloc.dart';
import '../bloc/auth_session_event.dart';
import '../exception/validation_exceptions.dart';
import '../generated/error.pbenum.dart';
import '../generated/l10n.dart';
import '../model/album.dart';
import '../model/asset.dart';
import '../model/failures.dart';
import '../model/user.dart';
import '../util/network_util.dart';
import '../util/util.dart';
import '../util/validator/name_validator.dart';
import '../util/validator/password_validator.dart';
import 'grpc_client.dart';
import 'logger.dart';
import 'store.dart';

class MediaManager {
  MediaManager._internal();

  static final MediaManager _instance = MediaManager._internal();

  static MediaManager get instance => _instance;

  Future<List<Album>> getAllAlbums() async {
    final assetPathEntities = await pm.PhotoManager.getAssetPathList(
      filterOption: pm.FilterOptionGroup(containsPathModified: true),
    );
    return assetPathEntities.map(_toAlbum).toList();
  }

  Future<Album> getAlbum(
    String id, {
    DateTime? modifiedFrom,
    DateTime? modifiedUntil,
  }) async {
    final assetPathEntity = await pm.AssetPathEntity.fromId(id);
    return _toAlbum(assetPathEntity);
  }

  static Album _toAlbum(pm.AssetPathEntity assetPathEntity) {
    final album = Album(
      name: assetPathEntity.name,
      createdAt:
          assetPathEntity.lastModified?.toUtc() ?? DateTime.now().toUtc(),
      modifiedAt:
          assetPathEntity.lastModified?.toUtc() ?? DateTime.now().toUtc(),
    );
    album.localId = assetPathEntity.id;
    album.isAll = assetPathEntity.isAll;
    return album;
  }

  Future<List<String>> getAlbumAssetIds(String albumId) async {
    final album = await pm.AssetPathEntity.fromId(albumId);
    final List<pm.AssetEntity> assets =
        await album.getAssetListRange(start: 0, end: 0x7fffffffffffffff);
    return assets.map((e) => e.id).toList();
  }

  Future<int> getAlbumAssetCount(String albumId) async {
    final album = await pm.AssetPathEntity.fromId(albumId);
    return album.assetCountAsync;
  }

  Future<List<Asset>> getAlbumAssets(
    String albumId, {
    int start = 0,
    int end = 0x7fffffffffffffff,
    DateTime? modifiedFrom,
    DateTime? modifiedUntil,
    bool orderByModificationDate = false,
  }) async {
    final onDevice = await pm.AssetPathEntity.fromId(
      albumId,
      filterOption: pm.FilterOptionGroup(
        containsPathModified: true,
        orders: orderByModificationDate
            ? [const pm.OrderOption(type: pm.OrderOptionType.updateDate)]
            : [],
        imageOption: const pm.FilterOption(needTitle: true),
        videoOption: const pm.FilterOption(needTitle: true),
        updateTimeCond: modifiedFrom == null && modifiedUntil == null
            ? null
            : pm.DateTimeCond(
                min: modifiedFrom ?? DateTime.utc(-271820),
                max: modifiedUntil ?? DateTime.utc(275760),
              ),
      ),
    );

    final List<pm.AssetEntity> assets =
        await onDevice.getAssetListRange(start: start, end: end);
    return assets.map(toAsset).toList().cast();
  }

  static Asset? toAsset(pm.AssetEntity? local) {
    if (local == null) return null;
    final Asset asset = Asset(
      checksum: "",
      localId: local.id,
      owner: UserManager.instance.currentUser!.name,
      fileCreatedAt: local.createDateTime,
      fileModifiedAt: local.modifiedDateTime,
      updatedAt: local.modifiedDateTime,
      durationInSeconds: local.duration,
      type: AssetType.values[local.typeInt],
      fileName: local.title!,
      width: local.width,
      height: local.height,
      isFavorite: local.isFavorite,
    );
    if (asset.fileCreatedAt.year == 1970) {
      asset.fileCreatedAt = asset.fileModifiedAt;
    }
    asset.local = local;
    return asset;
  }

  Future<List<Asset>> getCachedAssets() async {
    try {
      final maps = await Store.instance.queryFiles(
        where: 'deleted = ?',
        whereArgs: [0],
        orderBy: 'update_time DESC',
      );

      return maps
          .map((map) => Asset(
                localId: map['local_id'] as String,
                checksum: map['hash'] as String,
                fileCreatedAt: DateTime.fromMillisecondsSinceEpoch(
                    map['create_time'] as int),
                fileModifiedAt: DateTime.fromMillisecondsSinceEpoch(
                    map['update_time'] as int),
                updatedAt: DateTime.fromMillisecondsSinceEpoch(
                    map['update_time'] as int),
                durationInSeconds: map['duration'] as int? ?? 0,
                type: AssetType.values[map['type'] as int],
                fileName: map['file_name'] as String,
                width: map['width'] as int,
                height: map['height'] as int,
                isFavorite: (map['favorite'] as int) == 1,
                owner: map['owner'] as String,
              ))
          .toList();
    } catch (e, s) {
      Logger.error('Error getting cached assets', e, s);
      return [];
    }
  }
}
