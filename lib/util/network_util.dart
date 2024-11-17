import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityUtil {
  ConnectivityUtil._internal();

  static final ConnectivityUtil _instance = ConnectivityUtil._internal();

  static ConnectivityUtil get instance => _instance;

  final Connectivity _connectivity = Connectivity();
  List<ConnectivityResult> _connectionStatus = [];
  final StreamController<List<ConnectivityResult>> _controller =
      StreamController<List<ConnectivityResult>>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  // Get current connection status
  List<ConnectivityResult> get connectionStatus => _connectionStatus;

  // Get stream of connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _controller.stream;

  // Initialize connectivity monitoring
  Future<void> init() async {
    // Check initial connectivity
    await checkConnectivity();

    // Listen for subsequent connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
      _connectionStatus = results;
      _controller.add(results);
    });
  }

  // Check current connectivity
  Future<List<ConnectivityResult>> checkConnectivity() async {
    try {
      _connectionStatus = await _connectivity.checkConnectivity();
      _controller.add(_connectionStatus);
      return _connectionStatus;
    } catch (e) {
      if (kDebugMode) {
        print('Connectivity check failed: $e');
      }
      return [];
    }
  }

  // Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _controller.close();
  }

  // Helper method to check if device has internet connection
  bool hasInternetConnection() {
    return _connectionStatus.any((result) =>
        result != ConnectivityResult.none &&
        result != ConnectivityResult.bluetooth);
  }

  // Helper method to check if connected to WiFi
  bool hasWifiConnection() {
    return _connectionStatus.contains(ConnectivityResult.wifi);
  }

  // Helper method to check if connected to mobile data
  bool hasMobileConnection() {
    return _connectionStatus.contains(ConnectivityResult.mobile);
  }

  // Helper method to check if connected to VPN
  bool hasVpnConnection() {
    return _connectionStatus.contains(ConnectivityResult.vpn);
  }

  // Helper method to check if connected to Ethernet
  bool hasEthernetConnection() {
    return _connectionStatus.contains(ConnectivityResult.ethernet);
  }

  // Get connection type as string
  String getConnectionString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return 'No Connection';
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.other:
        return 'Other Network';
    }
  }

  // Get all current connection types as list of strings
  List<String> getCurrentConnectionTypes() {
    return _connectionStatus
        .map(getConnectionString)
        .toList();
  }
}
