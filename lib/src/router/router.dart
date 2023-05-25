import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:zxplore_app/src/features/sign_in/sign_in_page.dart';
import 'package:zxplore_app/src/router/nav_observer.dart';
import 'package:zxplore_app/src/router/not_found_page.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final log = Logger('Router');

/// gorouter provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: $appRoutes,
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    errorBuilder: (context, state) => NotFoundScreen(
      error: state.error!,
    ).build(context),
    // debugLogDiagnostics: kDebugMode,
    observers: <NavigatorObserver>[NavObserver()],
  );
});

@TypedGoRoute<SignInRoute>(path: '/')
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}
