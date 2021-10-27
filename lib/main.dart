import 'app.dart';
import 'package:flutter/material.dart';
import 'package:catcher/catcher_plugin.dart';

main() {
  CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(["mobileunit@cyberspace.net.ng"])
  ]);

  WidgetsFlutterBinding.ensureInitialized();

  Catcher(ZxploreApp(),
      debugConfig: debugOptions, releaseConfig: releaseOptions);
}

//void main() => runApp(ZxploreApp());




