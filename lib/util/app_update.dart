import 'dart:io';


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/widget/dialog/gradient_alert_dialog.dart';


Future<Map<String, dynamic>> githubUpdate() async {
  // http.Response response;
  // try {
  //   response = await http.get(
  //     Uri.parse(
  //         'https://api.github.com/repos/HemantKArya/BloomeeTunes/releases/latest'),
  //   );
  // } catch (e) {
  //   log('Failed to load latest version!', name: 'UpdaterTools');
  //   return {
  //     "results": false,
  //   };
  // }
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // if (response.statusCode == 200) {
  //   Map<String, dynamic> data = json.decode(response.body);
  //   String newBuildVer = (data['tag_name'] as String).split("+")[1];
  //   return {
  //     "results": isUpdateAvailable(
  //       packageInfo.version,
  //       packageInfo.buildNumber,
  //       data["tag_name"].toString().split("+")[0].replaceFirst("v", ''),
  //       newBuildVer,
  //       checkBuild: false,
  //     ),
  //     "newBuild": newBuildVer,
  //     "currBuild": packageInfo.buildNumber,
  //     "currVer": packageInfo.version,
  //     "newVer": data["tag_name"].toString().split("+")[0].replaceFirst("v", ''),
  //     // "download_url": extractUpUrl(data),
  //     "download_url":
  //     "https://sourceforge.net/projects/bloomee/files/latest/download",
  //   };
  // } else {
  //   log('Failed to load latest version!', name: 'UpdaterTools');
  //   return {
  //     "currBuild": packageInfo.buildNumber,
  //     "currVer": packageInfo.version,
  //     "results": false,
  //   };
  // }

    return {
      "currBuild": "1",
      "currVer": "2",
      "results": false,
    };
}

Future<Map<String, dynamic>> getLatestVersion() async {
    return await githubUpdate();
}

Future<void> updateDialog(BuildContext context) async {
  if (Platform.isAndroid) {
    Map<String, dynamic> _updateData = await getLatestVersion();
    if (_updateData["results"] != null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return GradientDialog(
            "New Version of Bloomee🌸 is now available!!\n\nVersion: ${_updateData["newVer"]} + ${_updateData["newBuild"]}",
            onOk: openURL,
            okText: "Update Now!",
            // downloadURL: _updateData["download_url"],
            downloadURL: "https://bloomee.sourceforge.io/",
          );
        },
      );
    }
  }
}

Future<void> openURL(String url) async {
  launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

// Future<void> downloadApk(String url) async {
//   ReceivePort receivePort = ReceivePort();

//   bool isSuccess = IsolateNameServer.registerPortWithName(
//       receivePort.sendPort, "update_port");
//   if (!isSuccess) {
//     IsolateNameServer.removePortNameMapping("update_port");
//     IsolateNameServer.registerPortWithName(receivePort.sendPort, "update_port");
//   }
//   FlutterDownloader.registerCallback(callback);
//   final taskId = await FlutterDownloader.enqueue(
//     url: url,
//     headers: {}, // optional: header send with url (auth token etc)
//     savedDir: (await getExternalStorageDirectory())!.path,
//     saveInPublicStorage: true,
//     showNotification:
//         true, // show download progress in status bar (for Android)
//     openFileFromNotification:
//         true, // click on notification to open downloaded file (for Android)
//   );

//   receivePort.listen((dynamic data) async {
//     String id = data[0];
//     // DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
//     int status = data[1];
//     int progress = data[2];
//     print("=============================");
//     if (status == 3) {
//       final tasks = await FlutterDownloader.loadTasksWithRawQuery(
//         query: "SELECT * FROM task WHERE task_id='" + taskId.toString() + "'",
//       );
//       // print(tasks![0].filename.toString());
//       String full_path =
//           tasks![0].savedDir.toString() + "/" + tasks[0].filename.toString();
//       print(full_path);
//       if (Platform.isAndroid) {
//         await FlutterDownloader.open(taskId: taskId.toString());
//       }
//     }
//     print(
//       'Background Isolate Callback: task ($taskId) is in status ($status) and process ($progress)',
//     );
//   });
// }

// @pragma('vm:entry-point')
// Future callback(String taskId, int status, int progress) async {
//   final SendPort? send = IsolateNameServer.lookupPortByName('update_port');
//   send?.send([taskId, status, progress]);
// }
