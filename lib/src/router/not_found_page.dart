import 'package:flutter/material.dart';
import 'package:zxplore_app/src/router/router.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  /// Creates a new not found screen
  const NotFoundScreen({super.key, this.error});
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error != null ? '404 - Page not found!' : error.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () => const SignInRoute().go(context),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
