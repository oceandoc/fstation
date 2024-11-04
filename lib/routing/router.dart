import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/setting.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SettingPage(),
    ),
  ],
);
