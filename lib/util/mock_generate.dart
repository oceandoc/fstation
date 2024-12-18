import 'package:fstation/util/ring_buffer.dart';
import 'package:photo_manager/photo_manager.dart';

import '../model/asset.dart';

List<Asset> mockServerReturnAssets() {
  final ret = <Asset>[]
    ..add(Asset(
      checksum: 'xxxx',
      localId: 'localId',
      owner: 'owner',
      fileCreatedAt: DateTime(2024, 12, 16),
      fileModifiedAt: DateTime(2024, 12, 16),
      updatedAt: DateTime(2024, 12, 16),
      durationInSeconds: 0,
      type: AssetType.image,
      fileName: '',
      thumbhash: '0bd81a7c60859e06d81d30f36f395840d71ad2e14c4b81d7832d2b16e2221322',
    ))
    ..add(Asset(
      checksum: 'xxxx',
      localId: 'localId',
      owner: 'owner',
      fileCreatedAt: DateTime(2024, 12, 16),
      fileModifiedAt: DateTime(2024, 12, 16),
      updatedAt: DateTime(2024, 12, 16),
      durationInSeconds: 0,
      type: AssetType.image,
      fileName: '',
      thumbhash: '0bd81a7c60859e06d81d30f36f395840d71ad2e14c4b81d7832d2b16e2221322',
    ))
    ..add(Asset(
      checksum: 'xxxx',
      localId: 'localId',
      owner: 'owner',
      fileCreatedAt: DateTime(2024, 12, 14),
      fileModifiedAt: DateTime(2024, 12, 14),
      updatedAt: DateTime(2024, 12, 14),
      durationInSeconds: 0,
      type: AssetType.image,
      fileName: '',
      thumbhash: '0bd81a7c60859e06d81d30f36f395840d71ad2e14c4b81d7832d2b16e2221322',
    ))
    ..add(Asset(
      checksum: 'xxxx',
      localId: 'localId',
      owner: 'owner',
      fileCreatedAt: DateTime(2024, 12, 14),
      fileModifiedAt: DateTime(2024, 12, 14),
      updatedAt: DateTime(2024, 12, 14),
      durationInSeconds: 0,
      type: AssetType.image,
      fileName: '',
      thumbhash: '0bd81a7c60859e06d81d30f36f395840d71ad2e14c4b81d7832d2b16e2221322',
    ))
    ..add(Asset(
      checksum: 'xxxx',
      localId: 'localId',
      owner: 'owner',
      fileCreatedAt: DateTime(2024, 12, 14),
      fileModifiedAt: DateTime(2024, 12, 14),
      updatedAt: DateTime(2024, 12, 14),
      durationInSeconds: 0,
      type: AssetType.image,
      fileName: '',
      thumbhash: '0bd81a7c60859e06d81d30f36f395840d71ad2e14c4b81d7832d2b16e2221322',
    ))
    ..add(Asset(
      checksum: 'xxxx',
      localId: 'localId',
      owner: 'owner',
      fileCreatedAt: DateTime(2024, 12, 14),
      fileModifiedAt: DateTime(2024, 12, 14),
      updatedAt: DateTime(2024, 12, 14),
      durationInSeconds: 0,
      type: AssetType.image,
      fileName: '',
      thumbhash: '0bd81a7c60859e06d81d30f36f395840d71ad2e14c4b81d7832d2b16e2221322',
    ));

  return ret;
}
