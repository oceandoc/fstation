import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Switcher')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          child: Text('Toggle Theme'),
        ),
      ),
    );
  }
}