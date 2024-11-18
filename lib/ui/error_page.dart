import 'package:flutter/material.dart';
import 'package:fstation/ui/widget/unfocus.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.error,
  });

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: List.filled(2, Colors.black),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Unfocus(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'oops! something went wrong',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          child: const Text('home'),
                          onPressed: () => context.go('/home'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
