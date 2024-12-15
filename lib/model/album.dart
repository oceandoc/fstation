class Album {
  Album({
    this.remoteId,
    this.localId,
    required this.name,
    required this.createdAt,
    required this.modifiedAt,
    this.startDate,
    this.endDate,
    this.lastModifiedAssetTimestamp,
  });

  // fields stored in DB
  int? id ;
  String? remoteId;
  String? localId;
  String name;
  DateTime createdAt;
  DateTime modifiedAt;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? lastModifiedAssetTimestamp;

  bool isAll = false;

  String? remoteThumbnailAssetId;
  int remoteAssetCount = 0;
  bool get isRemote => remoteId != null;
  bool get isLocal => localId != null;

  bool operator ==(other) {
    if (other is! Album) return false;
    return id == other.id &&
        remoteId == other.remoteId &&
        localId == other.localId &&
        name == other.name &&
        createdAt.isAtSameMomentAs(other.createdAt) &&
        modifiedAt.isAtSameMomentAs(other.modifiedAt);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      remoteId.hashCode ^
      localId.hashCode ^
      name.hashCode ^
      createdAt.hashCode ^
      modifiedAt.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      lastModifiedAssetTimestamp.hashCode;

  @override
  String toString() => name;
}