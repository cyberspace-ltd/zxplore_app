import 'package:flutter/material.dart';

import 'colors.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'package:flutter/services.dart';

import 'package:zxplore_app/utils/util.dart';
import 'package:zxplore_app/utils/theme.dart';

class ZxploreApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ZxploreAppState();
}

class _ZxploreAppState extends State<ZxploreApp> {
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Lato", "Lato");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      title: 'Z-XPLORE GH',
      home: MyHomePage(title: 'Z-XPLORE Home Page'),
      initialRoute: '/splash',
      onGenerateRoute: _getRoute,
      // theme: _zXploreTheme,
    );
  }
}

Route<dynamic>? _getRoute(RouteSettings settings) {
  if (settings.name != '/splash') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => SplashScreen(),
    fullscreenDialog: true,
  );
}

final ThemeData _zXploreTheme = _buildZxploreTheme();

ThemeData _buildZxploreTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: ZxplorePrimaryColor,
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    dialogBackgroundColor: Colors.red[100],
    cardColor: kShrineBackgroundWhite,
    
    colorScheme: ColorScheme(
      onPrimary: ZxplorePrimaryColor,
      primary: kShrineBackgroundWhite,
      onError: kShrineErrorRed,
      error: kShrineErrorRed,
      brightness: Brightness.light,
      secondary: Colors.red,
      surface: kShrineBackgroundWhite,
      onSurface: ZxplorePrimaryColor,
      onSecondary: ZxplorePrimaryColor,
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: ZxplorePrimaryColor,
      textTheme: ButtonTextTheme.normal,
    ),
       textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ZxplorePrimaryColor, // Change this to the color you want
      ),
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: ZxplorePrimaryColor),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
    textTheme: _buildZxploreTextTheme(base.textTheme),
    primaryTextTheme: _buildZxploreTextTheme(base.primaryTextTheme),
  );
}

TextTheme _buildZxploreTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall!
            .copyWith(fontWeight: FontWeight.w500, color: ZxplorePrimaryColor),
        titleLarge: base.titleLarge!.copyWith(fontSize: 18.0),
        bodySmall: base.bodySmall!
            .copyWith(fontSize: 11.0, color: ZxplorePrimaryColor),
        bodyMedium: base.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        displayColor: Colors.black87,
        bodyColor: Colors.black87,
      );
}
