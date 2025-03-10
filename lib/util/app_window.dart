import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fstation/extension/extensions.dart';
import 'package:fstation/generated/l10n.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../impl/logger.dart';
import '../ui/widget/dialog/dialog.dart';
import 'app_info.dart';
import 'constants.dart';

class WindowUtil {
  WindowUtil._internal();

  static final WindowUtil _instance = WindowUtil._internal();

  static WindowUtil get instance => _instance;

  static bool _trayInstalled = false;

  static Future<void> init() async {
    if (kIsDesktop) {
      await windowManager.ensureInitialized();
      await windowManager.setTitle(kAppName);
      await windowManager.setMinimumSize(
          kDebugMode ? const Size(100, 100) : const Size(375, 568));
      // windowManager.setMaximumSize(Size.infinite); // ?
      await windowManager.setPreventClose(true);
    }
  }

  /// window ops

  static Future<void> minimizeWindow() async {
    if (kIsWindows) {
      return windowManager.hide();
    } else if (kIsMacOS) {
      return windowManager.minimize();
    } else if (kIsLinux) {
      return windowManager.minimize();
    }
  }

  static Future<void> showWindow() async {
    if (kIsDesktop) {
      return windowManager.show();
    }
  }

  static Future<void> destroyWindow() async {
    if (kDebugMode) {
      final confirm = await SimpleCancelOkDialog(
        title: Text(Localization.current.general_close),
      ).showDialog(kAppKey.currentContext!);
      if (confirm != true) return;
    }
    await windowManager.destroy();
  }

  static Future<void> setAlwaysOnTop([bool? onTop]) async {
    if (kIsDesktop) {
      // onTop ??= db.settings.alwaysOnTop;
      await windowManager.setAlwaysOnTop(true);
    }
  }

  /// tray ops

  static Future<void> toggleTray([bool? value]) {
    if (value != null) {
      return value ? setTray() : destroyTray();
    } else {
      return _trayInstalled ? destroyTray() : setTray();
    }
  }

  @protected
  static Future<void> destroyTray() async {
    if (_trayInstalled) {
      _trayInstalled = false;
      return trayManager.destroy();
    }
  }

  static Future<void> setTray() async {
    if (!kIsDesktop) return;
    try {
      final icon =
          'res/img/launcher_icon/${kIsWindows ? 'app_icon.ico' : 'app_icon_rounded.png'}';
      await trayManager.setIcon(icon);
      final menuMain = Menu(items: [
        MenuItem(
          label: '$kAppName v${AppInfo.instance.versionString}',
          disabled: true,
        ),
        MenuItem.separator(),
        // MenuItem(
        //   label: S.current.show,
        //   onClick: (menuItem) => showWindow(),
        // ),
        // MenuItem.separator(),
        // MenuItem(
        //   label: S.current.hide,
        //   onClick: (menuItem) => minimizeWindow(),
        // ),
        // MenuItem.separator(),
        // MenuItem(
        //   label: S.current.quit,
        //   onClick: (menuItem) async {
        //     await db.saveAll();
        //     if (await _shouldCloseCheckUpload()) {
        //       await destroyWindow();
        //     }
        //   },
        // ),
      ]);

      await trayManager.setContextMenu(menuMain);
      if (kDebugMode) {
        print('set tray menu');
      }
      _trayInstalled = true;
    } catch (e, s) {
      Logger.error('init system tray failed', e, s);
      // EasyLoading.showError('${S.current.failed}: ${S.current.show_system_tray}');
    }
  }

  /// events

  static Future<void> onTrayClick() async {
    if (kIsWindows) {
      return windowManager.show();
    } else if (kIsMacOS) {
      return trayManager.popUpContextMenu();
    } else if (kIsLinux) {
      return windowManager.show();
      // not supported
      // trayManager.popUpContextMenu();
    }
  }

  static Future<void> onTrayRightClick() async {
    if (kIsWindows) {
      return trayManager.popUpContextMenu();
    } else if (kIsMacOS) {
      return windowManager.show();
    } else if (kIsLinux) {
      return windowManager.show();
    }
  }

  static Future<void> onWindowClose() async {
    // await db.saveAll();
    // if (db.settings.showSystemTray) {
    //   await minimizeWindow();
    //   return;
    // }
    // if (await _shouldCloseCheckUpload()) {
    //   await destroyWindow();
    // }
  }

  // close window if return true
  static Future<bool> _shouldCloseCheckUpload() async {
    Logger.info('closing desktop app...');
    // final alertUploadUserData = db.settings.alertUploadUserData && kDebugMode;
    // if (!alertUploadUserData) {
    //   await Future.delayed(const Duration(milliseconds: 200));
    //   return true;
    // }

    final visible = await windowManager.isVisible();
    if (!visible) await windowManager.show();

    final ctx = kAppKey.currentContext;
    if (ctx == null || !ctx.mounted) return true;

    // final close = await showDialog(
    //   context: ctx,
    //   builder: (context) => AlertDialog(
    //     content: Text(S.current.upload_and_close_app_alert),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.pop(context, false);
    //         },
    //         child: Text(S.current.cancel),
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           Navigator.pop(context, true);
    //         },
    //         child: Text(S.current.general_close),
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           bool success;
    //           if (kDebugMode) {
    //             success = true;
    //           } else {
    //             success = await ChaldeaServerBackup().backup();
    //           }
    //           if (success && context.mounted) Navigator.pop(context, true);
    //         },
    //         child: Text(S.current.upload_and_close_app),
    //       ),
    //     ],
    //   ),
    // );
    return true;
  }
}
