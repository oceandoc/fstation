import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fstation/impl/logger.dart';
import 'package:uuid/uuid.dart';

import '../generated/error.pb.dart';
import '../generated/service.pb.dart';

class LocalHostDiscover {
  LocalHostDiscover._internal();

  static final LocalHostDiscover _instance = LocalHostDiscover._internal();

  static LocalHostDiscover get instance => _instance;

  final List<String> _services = [];

  List<String> get services => _services;
  static const _uuid = Uuid();

  final _serviceController = StreamController<String>.broadcast();

  Stream<String> get onServiceFound => _serviceController.stream;

  Future<void> discoverServices() async {
    _services.clear(); // Clear previous results
    final socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      0,
      reusePort: !Platform.isWindows,
    );
    socket.broadcastEnabled = true;

    final request = ServerReq()
      ..requestId = _uuid.v4()
      ..op = ServerOp.ServerFindingServer;

    final jsonString = jsonEncode({
      'request_id': request.requestId,
      'op': request.op.value,
    });
    Logger.debug('Sending: $jsonString');

    socket
      ..send(utf8.encode(jsonString), InternetAddress('255.255.255.255'), 10001)
      ..listen((RawSocketEvent event) async {
        if (event == RawSocketEvent.read) {
          final datagram = socket.receive();
          if (datagram != null) {
            try {
              final responseStr = utf8.decode(datagram.data);
              final serverAddr = '${datagram.address.address}:${datagram.port}';
              Logger.debug('Response from $serverAddr');

              final responseJson =
                  jsonDecode(responseStr) as Map<String, dynamic>;
              final response = ServerRes()
                ..errCode = ErrCode.valueOf(responseJson['err_code'] as int)!
                ..status = responseJson['status'] as String;

              if (response.errCode == ErrCode.Success) {
                if (!_services.contains(serverAddr)) {
                  _services.add(serverAddr);
                  Logger.debug('Added server: $serverAddr');
                  _serviceController.add(serverAddr);
                }
              }
            } catch (e) {
              Logger.error('Failed to parse response', e);
            }
          }
        }
      });

    // Wait for responses
    await Future.delayed(const Duration(seconds: 2));
  }
}
