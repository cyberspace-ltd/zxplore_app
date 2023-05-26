import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/main.dart';
import 'package:zxplore_app/src/router/router.dart';
import 'package:zxplore_app/src/theme/dark/dark_appbar_theme.dart';
import 'package:zxplore_app/src/theme/dark/dark_evelated_button_theme.dart';
import 'package:zxplore_app/src/theme/dark/dark_input_decoration_theme.dart';
import 'package:zxplore_app/src/theme/dark/dark_text_button_theme.dart';
import 'package:zxplore_app/src/theme/light/light_appbar_theme.dart';
import 'package:zxplore_app/src/theme/light/light_evelated_button_theme.dart';
import 'package:zxplore_app/src/theme/light/light_input_decoration_theme.dart';
import 'package:zxplore_app/src/theme/light/light_text_button_theme.dart';

/// The Widget that configures your application.
/// Root scaffold messenger key used for showing snackbars anywhere in the app
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// The main app widget
class MyApp extends ConsumerWidget {
  /// Constructor for main app widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    var darkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      theme: ThemeData(
        useMaterial3: true,
        // textTheme: lightTextTheme,
        brightness: Brightness.light,
        textButtonTheme: lightTextButtonTheme,
        colorSchemeSeed: Colors.redAccent.shade700,
        elevatedButtonTheme: lightElevatedButtonTheme,
        inputDecorationTheme: lightInputDecorationTheme,
        appBarTheme: lightAppBarTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        // textTheme: darkTextTheme,
        brightness: Brightness.dark,
        textButtonTheme: darkTextButtonTheme,
        colorSchemeSeed: Colors.redAccent.shade700,
        elevatedButtonTheme: darkElevatedButtonTheme,
        inputDecorationTheme: darkInputDecorationTheme,
        appBarTheme: darkAppBarTheme,
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
