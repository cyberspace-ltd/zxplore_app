import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxplore_app/src/shared/providers.dart';

import 'src/app.dart';

void main() async {
  final log = Logger('Main');
  log.onRecord.listen((LogRecord e) => debugPrint('$e'));
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final sharedPreferences = await SharedPreferences.getInstance();
      ByteData pemContent =
          await rootBundle.load('assets/server_certificate.pem');
      ByteData keyContent =
          await rootBundle.load('assets/server_certificate_key.pem');
      ByteData crtContent =
          await rootBundle.load('assets/server_certificate.crt');

      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPreferences),
            keyContentProvider.overrideWithValue(keyContent),
            pemContentProvider.overrideWithValue(pemContent),
            crtContentProvider.overrideWithValue(crtContent),
          ],
          child: const MyApp(),
        ),
      );

      // * This code will present some error UI if any uncaught exception happens
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text('An error occurred'),
          ),
          body: Center(child: Text(details.toString())),
        );
      };
    },
    (Object error, StackTrace stack) => log.severe('Oh noes!', error, stack),
  );
}
