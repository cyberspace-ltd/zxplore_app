import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';

final sharedPreferencesServiceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

void main() async {
  final log = Logger('Main');
  log.onRecord.listen((LogRecord e) => debugPrint('$e'));
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final sharedPreferences = await SharedPreferences.getInstance();

      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesServiceProvider
                .overrideWithValue(sharedPreferences),
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

class DarkModeNotifier extends StateNotifier<bool> {
  SharedPreferences prefs;

  Future _init() async {
    var darkMode = prefs.getBool("darkMode");
    state = darkMode ?? false;
  }

  DarkModeNotifier(this.prefs) : super(false) {
    _init();
  }

  void toggle() async {
    state = !state;
    prefs.setBool("darkMode", state);
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
  (ref) => DarkModeNotifier(ref.watch(sharedPreferencesServiceProvider)),
);
