import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';

class Asset {
  Asset({
    this.id,
    required this.checksum,
    this.remoteId,
    required this.localId,
    required this.owner,
    required this.fileCreatedAt,
    required this.fileModifiedAt,
    required this.updatedAt,
    required this.durationInSeconds,
    required this.type,
    this.width,
    this.height,
    required this.fileName,
    this.livePhotoVideoId,
    this.isFavorite = false,
    this.isArchived = false,
    this.isTrashed = false,
    this.stackId,
    this.stackPrimaryAssetId,
    this.stackCount = 0,
    this.isOffline = false,
    this.thumbhash,
  });


  AssetEntity? _local;

  AssetEntity? get local {
    if (isLocal && _local == null) {
      _local = AssetEntity(
        id: localId!,
        typeInt: isImage ? 1 : 2,
        width: width ?? 0,
        height: height ?? 0,
        duration: durationInSeconds,
        createDateSecond: fileCreatedAt.millisecondsSinceEpoch ~/ 1000,
        modifiedDateSecond: fileModifiedAt.millisecondsSinceEpoch ~/ 1000,
        title: fileName,
      );
    }
    return _local;
  }

  set local(AssetEntity? assetEntity) => _local = assetEntity;


  int? id;
  String checksum;
  String? thumbhash;
  String? remoteId;
  String? localId;
  String? owner;
  DateTime fileCreatedAt;
  DateTime fileModifiedAt;
  DateTime updatedAt;
  int durationInSeconds;
  AssetType type;
  int? width;
  int? height;
  String fileName;
  String? livePhotoVideoId;
  bool isFavorite;
  bool isArchived;
  bool isTrashed;
  bool isOffline;
  // ExifInfo? exifInfo;
  String? stackId;
  String? stackPrimaryAssetId;
  int stackCount;
  bool get isLocal => localId != null;


  String get name => withoutExtension(fileName);
  bool get isRemote => remoteId != null;
  bool get isImage => type == AssetType.image;
  bool get isVideo => type == AssetType.video;
  bool get isMotionPhoto => livePhotoVideoId != null;

  AssetState get storage {
    if (isRemote && isLocal) {
      return AssetState.merged;
    } else if (isRemote) {
      return AssetState.remote;
    } else if (isLocal) {
      return AssetState.local;
    } else {
      throw Exception("Asset has illegal state: $this");
    }
  }


  Duration get duration => Duration(seconds: durationInSeconds);


  set byteHash(List<int> hash) => checksum = base64.encode(hash);

  @override
  bool operator ==(other) {
    if (other is! Asset) return false;
    if (identical(this, other)) return true;
    return id == other.id &&
        checksum == other.checksum &&
        remoteId == other.remoteId &&
        localId == other.localId &&
        owner == other.owner &&
        fileCreatedAt.isAtSameMomentAs(other.fileCreatedAt) &&
        fileModifiedAt.isAtSameMomentAs(other.fileModifiedAt) &&
        updatedAt.isAtSameMomentAs(other.updatedAt) &&
        durationInSeconds == other.durationInSeconds &&
        type == other.type &&
        width == other.width &&
        height == other.height &&
        fileName == other.fileName &&
        livePhotoVideoId == other.livePhotoVideoId &&
        isFavorite == other.isFavorite &&
        isLocal == other.isLocal &&
        isArchived == other.isArchived &&
        isTrashed == other.isTrashed &&
        stackCount == other.stackCount &&
        stackPrimaryAssetId == other.stackPrimaryAssetId &&
        stackId == other.stackId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      checksum.hashCode ^
      remoteId.hashCode ^
      localId.hashCode ^
      owner.hashCode ^
      fileCreatedAt.hashCode ^
      fileModifiedAt.hashCode ^
      updatedAt.hashCode ^
      durationInSeconds.hashCode ^
      type.hashCode ^
      width.hashCode ^
      height.hashCode ^
      fileName.hashCode ^
      livePhotoVideoId.hashCode ^
      isFavorite.hashCode ^
      isLocal.hashCode ^
      isArchived.hashCode ^
      isTrashed.hashCode ^
      stackCount.hashCode ^
      stackPrimaryAssetId.hashCode ^
      stackId.hashCode;


  Asset _copyWith({
    int? id,
    String? checksum,
    String? remoteId,
    String? localId,
    String? owne,
    DateTime? fileCreatedAt,
    DateTime? fileModifiedAt,
    DateTime? updatedAt,
    int? durationInSeconds,
    AssetType? type,
    int? width,
    int? height,
    String? fileName,
    String? livePhotoVideoId,
    bool? isFavorite,
    bool? isArchived,
    bool? isTrashed,
    bool? isOffline,
    String? stackId,
    String? stackPrimaryAssetId,
    int? stackCount,
    String? thumbhash,
  }) =>
      Asset(
        id: id ?? this.id,
        checksum: checksum ?? this.checksum,
        remoteId: remoteId ?? this.remoteId,
        localId: localId ?? this.localId,
        owner: owne ?? this.owner,
        fileCreatedAt: fileCreatedAt ?? this.fileCreatedAt,
        fileModifiedAt: fileModifiedAt ?? this.fileModifiedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        durationInSeconds: durationInSeconds ?? this.durationInSeconds,
        type: type ?? this.type,
        width: width ?? this.width,
        height: height ?? this.height,
        fileName: fileName ?? this.fileName,
        livePhotoVideoId: livePhotoVideoId ?? this.livePhotoVideoId,
        isFavorite: isFavorite ?? this.isFavorite,
        isArchived: isArchived ?? this.isArchived,
        isTrashed: isTrashed ?? this.isTrashed,
        isOffline: isOffline ?? this.isOffline,
        stackId: stackId ?? this.stackId,
        stackPrimaryAssetId: stackPrimaryAssetId ?? this.stackPrimaryAssetId,
        stackCount: stackCount ?? this.stackCount,
        thumbhash: thumbhash ?? this.thumbhash,
      );

  static int compareByChecksum(Asset a, Asset b) =>
      a.checksum.compareTo(b.checksum);

  @override
  String toString() {
    return """
{
  "id": ${id ?? "N/A"},
  "remoteId": "${remoteId ?? "N/A"}",
  "localId": "${localId ?? "N/A"}",
  "checksum": "$checksum",
  "ownerId": $owner,
  "livePhotoVideoId": "${livePhotoVideoId ?? "N/A"}",
  "stackId": "${stackId ?? "N/A"}",
  "stackPrimaryAssetId": "${stackPrimaryAssetId ?? "N/A"}",
  "stackCount": "$stackCount",
  "fileCreatedAt": "$fileCreatedAt",
  "fileModifiedAt": "$fileModifiedAt",
  "updatedAt": "$updatedAt",
  "durationInSeconds": $durationInSeconds,
  "type": "$type",
  "fileName": "$fileName",
  "isFavorite": $isFavorite,
  "isRemote": $isRemote,
  "storage": "$storage",
  "width": ${width ?? "N/A"},
  "height": ${height ?? "N/A"},
  "isArchived": $isArchived,
  "isTrashed": $isTrashed,
  "isOffline": $isOffline,
}""";
  }
}


enum AssetState {
  local,
  remote,
  merged,
}