import 'package:flutter/material.dart';
import 'package:fstation/impl/logger.dart';
import 'package:fstation/ui/widget/form_dimensions.dart';
import 'package:fstation/ui/widget/glassmorphism_cover.dart';
import 'package:fstation/ui/widget/server_input_field.dart';
import 'package:fstation/util/local_host_discover.dart';
import 'package:go_router/go_router.dart';

import '../generated/l10n.dart';
import '../impl/setting_impl.dart';
import '../impl/user_manager.dart';
import '../util/util.dart';

class ServerConfigPage extends StatefulWidget {
  const ServerConfigPage({super.key});

  @override
  ServerConfigPageState createState() => ServerConfigPageState();
}

class ServerConfigPageState extends State<ServerConfigPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotCount;
  final _localHostDiscover = LocalHostDiscover.instance;
  final _urlController = TextEditingController();
  bool _serverSelected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _dotCount = IntTween(begin: 0, end: 3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // Listen for discovered services
    _localHostDiscover.onServiceFound.listen(_showLocalServerDialog);

    // Start discovering local servers
    _startDiscovery();
  }

  Future<void> _startDiscovery() async {
    await _localHostDiscover.discoverServices();
    if (_localHostDiscover.services.isNotEmpty) {
      await _showLocalServerDialog(_localHostDiscover.services.first);
    }
  }

  Future<void> _showLocalServerDialog(String serverAddress) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Localization.current.local_server_found),
        content:
            Text('${Localization.current.use_local_server}: $serverAddress?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.current.cancel),
          ),
          TextButton(
            onPressed: () {
              _urlController.text = serverAddress;
              _serverSelected = true;
              setState(() {});
              Navigator.pop(context);
            },
            child: Text(Localization.current.confirm),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? getServerAddrErrors() {
      return null;
    }

    // void onServerChanged(String email) =>
    //     bloc.add(AuthFormInputsChangedEvent(email: email));

    // void onServerAddrChanged(String email) =>
    //     return;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: GlassMorphismCover(
            borderRadius: BorderRadius.circular(16),
            child: FormDimensions(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      Localization.current.setup_server,
                      style: const TextStyle(
                        fontSize: 25,
                        // color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UrlInputField(
                          controller: _urlController,
                          getUrlErrors: getServerAddrErrors,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (!_serverSelected)
                          AnimatedBuilder(
                            animation: _dotCount,
                            builder: (context, child) {
                              final dots = '.' * _dotCount.value;
                              return Text(
                                '${Localization.current.finding_server}$dots',
                                style: const TextStyle(fontSize: 14),
                              );
                            },
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(50),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue.withOpacity(0.7),
                          ),
                          onPressed: () async {
                            // TODO(xieyz): validate it
                            if (_urlController.text.isNotEmpty) {
                              if (SettingImpl.instance.serverAddr.isEmpty ||
                                  SettingImpl.instance.serverAddr !=
                                      _urlController.text) {
                                await SettingImpl.instance
                                    .saveServerAddr(_urlController.text);
                                Logger.info("server_config");
                                await connectAndHandshake();
                              }
                              await SettingImpl.instance
                                  .saveFirstLaunch(firstLaunch: false);
                              if (UserManager.instance.isAuth) {
                                Logger.debug('go to home page');
                                context.go('/home');
                              } else {
                                Logger.debug('go to login page');
                                context.go('/login');
                              }
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Localization.current.next,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  shadows: [Shadow(color: Colors.grey)],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 30,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey,
                                    blurRadius: 3,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
