

import 'package:flutter/material.dart';

class ControlBottomAppBar extends StatefulWidget {
  const ControlBottomAppBar({super.key});

  @override
  ControlBottomAppBarState createState() => ControlBottomAppBarState();
}



class ControlBottomAppBarState extends State<ControlBottomAppBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: const Text(
        'hello',
        style: TextStyle(fontSize: 16),
      ),
    );
  }


  // void onShareAssets(bool shareLocal) {
  //   processing.value = true;
  //   if (shareLocal) {
  //     // Share = Download + Send to OS specific share sheet
  //     handleShareAssets(ref, context, selection.value);
  //   } else {
  //     final ids =
  //     remoteSelection(errorMessage: "home_page_share_err_local".tr())
  //         .map((e) => e.remoteId!);
  //     context.pushRoute(SharedLinkEditRoute(assetsList: ids.toList()));
  //   }
  //   processing.value = false;
  //   selectionEnabledHook.value = false;
  // }
  //
  // void onFavoriteAssets() async {
  //   processing.value = true;
  //   try {
  //     final remoteAssets = ownedRemoteSelection(
  //       localErrorMessage: 'home_page_favorite_err_local'.tr(),
  //       ownerErrorMessage: 'home_page_favorite_err_partner'.tr(),
  //     );
  //     if (remoteAssets.isNotEmpty) {
  //       await handleFavoriteAssets(ref, context, remoteAssets.toList());
  //     }
  //   } finally {
  //     processing.value = false;
  //     selectionEnabledHook.value = false;
  //   }
  // }
  //
  // void onArchiveAsset() async {
  //   processing.value = true;
  //   try {
  //     final remoteAssets = ownedRemoteSelection(
  //       localErrorMessage: 'home_page_archive_err_local'.tr(),
  //       ownerErrorMessage: 'home_page_archive_err_partner'.tr(),
  //     );
  //     await handleArchiveAssets(ref, context, remoteAssets.toList());
  //   } finally {
  //     processing.value = false;
  //     selectionEnabledHook.value = false;
  //   }
  // }
  //
  // void onDelete([bool force = false]) async {
  //   processing.value = true;
  //   try {
  //     final toDelete = selection.value
  //         .ownedOnly(
  //       currentUser,
  //       errorCallback: errorBuilder('home_page_delete_err_partner'.tr()),
  //     )
  //         .toList();
  //     final isDeleted = await ref
  //         .read(assetProvider.notifier)
  //         .deleteAssets(toDelete, force: force);
  //
  //     if (isDeleted) {
  //       ImmichToast.show(
  //         context: context,
  //         msg: force
  //             ? 'assets_deleted_permanently'
  //             .tr(args: ["${selection.value.length}"])
  //             : 'assets_trashed'.tr(args: ["${selection.value.length}"]),
  //         gravity: ToastGravity.BOTTOM,
  //       );
  //       selectionEnabledHook.value = false;
  //     }
  //   } finally {
  //     processing.value = false;
  //   }
  // }
  //
  // void onDeleteLocal(bool onlyBackedUp) async {
  //   processing.value = true;
  //   try {
  //     // Select only the local assets from the selection
  //     final localIds = selection.value.where((a) => a.isLocal).toList();
  //
  //     // Delete only the backed-up assets if 'onlyBackedUp' is true
  //     final isDeleted = await ref
  //         .read(assetProvider.notifier)
  //         .deleteLocalOnlyAssets(localIds, onlyBackedUp: onlyBackedUp);
  //
  //     if (isDeleted) {
  //       // Show a toast with the correct number of deleted assets
  //       final deletedCount = localIds
  //           .where(
  //             (e) => !onlyBackedUp || e.isRemote,
  //       ) // Only count backed-up assets
  //           .length;
  //
  //       ImmichToast.show(
  //         context: context,
  //         msg: 'assets_removed_permanently_from_device'
  //             .tr(args: ["$deletedCount"]),
  //         gravity: ToastGravity.BOTTOM,
  //       );
  //
  //       // Reset the selection
  //       selectionEnabledHook.value = false;
  //     }
  //   } finally {
  //     processing.value = false;
  //   }
  // }
  //
  // void onDeleteRemote([bool force = false]) async {
  //   processing.value = true;
  //   try {
  //     final toDelete = ownedRemoteSelection(
  //       localErrorMessage: 'home_page_delete_remote_err_local'.tr(),
  //       ownerErrorMessage: 'home_page_delete_err_partner'.tr(),
  //     ).toList();
  //
  //     final isDeleted = await ref
  //         .read(assetProvider.notifier)
  //         .deleteRemoteOnlyAssets(toDelete, force: force);
  //     if (isDeleted) {
  //       ImmichToast.show(
  //         context: context,
  //         msg: force
  //             ? 'assets_deleted_permanently_from_server'
  //             .tr(args: ["${toDelete.length}"])
  //             : 'assets_trashed_from_server'.tr(args: ["${toDelete.length}"]),
  //         gravity: ToastGravity.BOTTOM,
  //       );
  //     }
  //   } finally {
  //     selectionEnabledHook.value = false;
  //     processing.value = false;
  //   }
  // }
  //
  // void onUpload() {
  //   processing.value = true;
  //   selectionEnabledHook.value = false;
  //   try {
  //     ref.read(manualUploadProvider.notifier).uploadAssets(
  //       context,
  //       selection.value.where((a) => a.storage == AssetState.local),
  //     );
  //   } finally {
  //     processing.value = false;
  //   }
  // }
  //
  // void onAddToAlbum(Album album) async {
  //   processing.value = true;
  //   try {
  //     final Iterable<Asset> assets = remoteSelection(
  //       errorMessage: "home_page_add_to_album_err_local".tr(),
  //     );
  //     if (assets.isEmpty) {
  //       return;
  //     }
  //     final result = await ref.read(albumServiceProvider).addAssets(
  //       album,
  //       assets,
  //     );
  //
  //     if (result != null) {
  //       if (result.alreadyInAlbum.isNotEmpty) {
  //         ImmichToast.show(
  //           context: context,
  //           msg: "home_page_add_to_album_conflicts".tr(
  //             namedArgs: {
  //               "album": album.name,
  //               "added": result.successfullyAdded.toString(),
  //               "failed": result.alreadyInAlbum.length.toString(),
  //             },
  //           ),
  //         );
  //       } else {
  //         ImmichToast.show(
  //           context: context,
  //           msg: "home_page_add_to_album_success".tr(
  //             namedArgs: {
  //               "album": album.name,
  //               "added": result.successfullyAdded.toString(),
  //             },
  //           ),
  //           toastType: ToastType.success,
  //         );
  //       }
  //     }
  //   } finally {
  //     processing.value = false;
  //     selectionEnabledHook.value = false;
  //   }
  // }
  //
  // void onCreateNewAlbum() async {
  //   processing.value = true;
  //   try {
  //     final Iterable<Asset> assets = remoteSelection(
  //       errorMessage: "home_page_add_to_album_err_local".tr(),
  //     );
  //     if (assets.isEmpty) {
  //       return;
  //     }
  //     final result = await ref
  //         .read(albumServiceProvider)
  //         .createAlbumWithGeneratedName(assets);
  //
  //     if (result != null) {
  //       ref.watch(albumProvider.notifier).refreshRemoteAlbums();
  //       selectionEnabledHook.value = false;
  //
  //       context.pushRoute(AlbumViewerRoute(albumId: result.id));
  //     }
  //   } finally {
  //     processing.value = false;
  //   }
  // }
  //
  // void onStack() async {
  //   try {
  //     processing.value = true;
  //     if (!selectionEnabledHook.value || selection.value.length < 2) {
  //       return;
  //     }
  //
  //     await ref.read(stackServiceProvider).createStack(
  //       selection.value.map((e) => e.remoteId!).toList(),
  //     );
  //   } finally {
  //     processing.value = false;
  //     selectionEnabledHook.value = false;
  //   }
  // }
  //
  // void onEditTime() async {
  //   try {
  //     final remoteAssets = ownedRemoteSelection(
  //       localErrorMessage: 'home_page_favorite_err_local'.tr(),
  //       ownerErrorMessage: 'home_page_favorite_err_partner'.tr(),
  //     );
  //
  //     if (remoteAssets.isNotEmpty) {
  //       handleEditDateTime(ref, context, remoteAssets.toList());
  //     }
  //   } finally {
  //     selectionEnabledHook.value = false;
  //   }
  // }
  //
  // void onEditLocation() async {
  //   try {
  //     final remoteAssets = ownedRemoteSelection(
  //       localErrorMessage: 'home_page_favorite_err_local'.tr(),
  //       ownerErrorMessage: 'home_page_favorite_err_partner'.tr(),
  //     );
  //
  //     if (remoteAssets.isNotEmpty) {
  //       handleEditLocation(ref, context, remoteAssets.toList());
  //     }
  //   } finally {
  //     selectionEnabledHook.value = false;
  //   }
  // }
  //
  //
  // final bool enabled;
  // final bool unfavorite;
  // final bool unarchive;
  // final AssetSelectionState selectionAssetState;
  //
  // const ControlBottomAppBarState({
  //   super.key,
  //   required this.onShare,
  //   this.onFavorite,
  //   this.onArchive,
  //   this.onDelete,
  //   this.onDeleteServer,
  //   this.onDeleteLocal,
  //   required this.onAddToAlbum,
  //   required this.onCreateNewAlbum,
  //   required this.onUpload,
  //   this.onStack,
  //   this.onEditTime,
  //   this.onEditLocation,
  //   this.onRemoveFromAlbum,
  //   this.selectionAssetState = const AssetSelectionState(),
  //   this.enabled = true,
  //   this.unarchive = false,
  //   this.unfavorite = false,
  // });
  //
  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final hasRemote =
  //       selectionAssetState.hasRemote || selectionAssetState.hasMerged;
  //   final hasLocal =
  //       selectionAssetState.hasLocal || selectionAssetState.hasMerged;
  //   final trashEnabled =
  //       ref.watch(serverInfoProvider.select((v) => v.serverFeatures.trash));
  //   final albums = ref.watch(albumProvider).where((a) => a.isRemote).toList();
  //   final sharedAlbums =
  //       ref.watch(albumProvider).where((a) => a.shared).toList();
  //   const bottomPadding = 0.20;
  //   final scrollController = useDraggableScrollController();
  //
  //   void minimize() {
  //     scrollController.animateTo(
  //       bottomPadding,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   }
  //
  //   useEffect(
  //     () {
  //       controlBottomAppBarNotifier.addListener(minimize);
  //       return () {
  //         controlBottomAppBarNotifier.removeListener(minimize);
  //       };
  //     },
  //     [],
  //   );
  //
  //   void showForceDeleteDialog(
  //     Function(bool) deleteCb, {
  //     String? alertMsg,
  //   }) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return DeleteDialog(
  //           alert: alertMsg,
  //           onDelete: () => deleteCb(true),
  //         );
  //       },
  //     );
  //   }
  //
  //   void handleRemoteDelete(
  //     bool force,
  //     Function(bool) deleteCb, {
  //     String? alertMsg,
  //   }) {
  //     if (!force) {
  //       deleteCb(force);
  //       return;
  //     }
  //     return showForceDeleteDialog(deleteCb, alertMsg: alertMsg);
  //   }
  //
  //   List<Widget> renderActionButtons() {
  //     return [
  //       if (hasRemote)
  //         ControlBoxButton(
  //           iconData: Icons.share_rounded,
  //           label: "control_bottom_app_bar_share".tr(),
  //           onPressed: enabled ? () => onShare(false) : null,
  //         ),
  //       ControlBoxButton(
  //         iconData: Icons.ios_share_rounded,
  //         label: "control_bottom_app_bar_share_to".tr(),
  //         onPressed: enabled ? () => onShare(true) : null,
  //       ),
  //       if (hasRemote && onArchive != null)
  //         ControlBoxButton(
  //           iconData: unarchive ? Icons.unarchive : Icons.archive,
  //           label: (unarchive
  //                   ? "control_bottom_app_bar_unarchive"
  //                   : "control_bottom_app_bar_archive")
  //               .tr(),
  //           onPressed: enabled ? onArchive : null,
  //         ),
  //       if (hasRemote && onFavorite != null)
  //         ControlBoxButton(
  //           iconData: unfavorite
  //               ? Icons.favorite_border_rounded
  //               : Icons.favorite_rounded,
  //           label: (unfavorite
  //                   ? "control_bottom_app_bar_unfavorite"
  //                   : "control_bottom_app_bar_favorite")
  //               .tr(),
  //           onPressed: enabled ? onFavorite : null,
  //         ),
  //       if (hasLocal && hasRemote && onDelete != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 90),
  //           child: ControlBoxButton(
  //             iconData: Icons.delete_sweep_outlined,
  //             label: "control_bottom_app_bar_delete".tr(),
  //             onPressed: enabled
  //                 ? () => handleRemoteDelete(!trashEnabled, onDelete!)
  //                 : null,
  //             onLongPressed:
  //                 enabled ? () => showForceDeleteDialog(onDelete!) : null,
  //           ),
  //         ),
  //       if (hasRemote && onDeleteServer != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 85),
  //           child: ControlBoxButton(
  //             iconData: Icons.cloud_off_outlined,
  //             label: trashEnabled
  //                 ? "control_bottom_app_bar_trash_from_immich".tr()
  //                 : "control_bottom_app_bar_delete_from_immich".tr(),
  //             onPressed: enabled
  //                 ? () => handleRemoteDelete(
  //                       !trashEnabled,
  //                       onDeleteServer!,
  //                       alertMsg: "delete_dialog_alert_remote",
  //                     )
  //                 : null,
  //             onLongPressed: enabled
  //                 ? () => showForceDeleteDialog(
  //                       onDeleteServer!,
  //                       alertMsg: "delete_dialog_alert_remote",
  //                     )
  //                 : null,
  //           ),
  //         ),
  //       if (hasLocal && onDeleteLocal != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 85),
  //           child: ControlBoxButton(
  //             iconData: Icons.no_cell_rounded,
  //             label: "control_bottom_app_bar_delete_from_local".tr(),
  //             onPressed: enabled
  //                 ? () {
  //                     if (!selectionAssetState.hasLocal) {
  //                       return onDeleteLocal?.call(true);
  //                     }
  //
  //                     showDialog(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return DeleteLocalOnlyDialog(
  //                           onDeleteLocal: onDeleteLocal!,
  //                         );
  //                       },
  //                     );
  //                   }
  //                 : null,
  //           ),
  //         ),
  //       if (hasRemote && onEditTime != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 95),
  //           child: ControlBoxButton(
  //             iconData: Icons.edit_calendar_outlined,
  //             label: "control_bottom_app_bar_edit_time".tr(),
  //             onPressed: enabled ? onEditTime : null,
  //           ),
  //         ),
  //       if (hasRemote && onEditLocation != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 90),
  //           child: ControlBoxButton(
  //             iconData: Icons.edit_location_alt_outlined,
  //             label: "control_bottom_app_bar_edit_location".tr(),
  //             onPressed: enabled ? onEditLocation : null,
  //           ),
  //         ),
  //       if (!selectionAssetState.hasLocal &&
  //           selectionAssetState.selectedCount > 1 &&
  //           onStack != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 90),
  //           child: ControlBoxButton(
  //             iconData: Icons.filter_none_rounded,
  //             label: "control_bottom_app_bar_stack".tr(),
  //             onPressed: enabled ? onStack : null,
  //           ),
  //         ),
  //       if (onRemoveFromAlbum != null)
  //         ConstrainedBox(
  //           constraints: const BoxConstraints(maxWidth: 90),
  //           child: ControlBoxButton(
  //             iconData: Icons.remove_circle_outline,
  //             label: 'album_viewer_appbar_share_remove'.tr(),
  //             onPressed: enabled ? onRemoveFromAlbum : null,
  //           ),
  //         ),
  //       if (selectionAssetState.hasLocal)
  //         ControlBoxButton(
  //           iconData: Icons.backup_outlined,
  //           label: "control_bottom_app_bar_upload".tr(),
  //           onPressed: enabled
  //               ? () => showDialog(
  //                     context: context,
  //                     builder: (BuildContext context) {
  //                       return UploadDialog(
  //                         onUpload: onUpload,
  //                       );
  //                     },
  //                   )
  //               : null,
  //         ),
  //     ];
  //   }
  //
  //   return DraggableScrollableSheet(
  //     controller: scrollController,
  //     initialChildSize: hasRemote ? 0.35 : bottomPadding,
  //     minChildSize: bottomPadding,
  //     maxChildSize: hasRemote ? 0.65 : bottomPadding,
  //     snap: true,
  //     builder: (
  //       BuildContext context,
  //       ScrollController scrollController,
  //     ) {
  //       return Card(
  //         color: context.colorScheme.surfaceContainerLow,
  //         surfaceTintColor: Colors.transparent,
  //         elevation: 18.0,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(12),
  //             topRight: Radius.circular(12),
  //           ),
  //         ),
  //         margin: const EdgeInsets.all(0),
  //         child: CustomScrollView(
  //           controller: scrollController,
  //           slivers: [
  //             SliverToBoxAdapter(
  //               child: Column(
  //                 children: <Widget>[
  //                   const SizedBox(height: 12),
  //                   const CustomDraggingHandle(),
  //                   const SizedBox(height: 12),
  //                   SizedBox(
  //                     height: 100,
  //                     child: ListView(
  //                       shrinkWrap: true,
  //                       scrollDirection: Axis.horizontal,
  //                       children: renderActionButtons(),
  //                     ),
  //                   ),
  //                   if (hasRemote)
  //                     const Divider(
  //                       indent: 16,
  //                       endIndent: 16,
  //                       thickness: 1,
  //                     ),
  //                   if (hasRemote)
  //                     _AddToAlbumTitleRow(
  //                       onCreateNewAlbum: enabled ? onCreateNewAlbum : null,
  //                     ),
  //                 ],
  //               ),
  //             ),
  //             if (hasRemote)
  //               SliverPadding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16),
  //                 sliver: AddToAlbumSliverList(
  //                   albums: albums,
  //                   sharedAlbums: sharedAlbums,
  //                   onAddToAlbum: onAddToAlbum,
  //                   enabled: enabled,
  //                 ),
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
//
// class _AddToAlbumTitleRow extends StatelessWidget {
//   const _AddToAlbumTitleRow({
//     required this.onCreateNewAlbum,
//   });
//
//   final VoidCallback? onCreateNewAlbum;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "common_add_to_album",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//           ).tr(),
//           TextButton.icon(
//             onPressed: onCreateNewAlbum,
//             icon: Icon(
//               Icons.add,
//               color: context.primaryColor,
//             ),
//             label: Text(
//               "common_create_new_album",
//               style: TextStyle(
//                 color: context.primaryColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ).tr(),
//           ),
//         ],
//       ),
//     );
//   }
// }
