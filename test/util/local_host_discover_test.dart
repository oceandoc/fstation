import 'package:flutter_test/flutter_test.dart';
import 'package:fstation/impl/logger.dart';
import 'package:fstation/util/local_host_discover.dart';

void main() {
  group('LocalHostDiscover', () {
    late LocalHostDiscover discover;

    setUpAll(() async {
      await Logger.instance.init();
    });

    setUp(() {
      discover = LocalHostDiscover.instance;
    });

    test('should discover services on network', () async {
      await Logger.instance.init();
      // Run discovery
      await discover.discoverServices();

      // Wait a moment for potential responses
      await Future.delayed(const Duration(seconds: 2));
      // Log discovered services
      for (final service in discover.services) {
        Logger.debug('Discovered service: $service');
      }
    });
  });
}
