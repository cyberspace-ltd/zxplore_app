import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:zxplore_app/src/features/forms/account_information_page.dart';
import 'package:zxplore_app/src/features/forms/contact_details_page.dart';
import 'package:zxplore_app/src/features/forms/means_of_identification_page.dart';
import 'package:zxplore_app/src/features/forms/personal_information_page.dart';
import 'package:zxplore_app/src/features/forms/signatory_page.dart';
import 'package:zxplore_app/src/features/forms/upload_id_page.dart';
import 'package:zxplore_app/src/features/forms/upload_passport_page.dart';
import 'package:zxplore_app/src/features/forms/upload_utility_bill_page.dart';
import 'package:zxplore_app/src/features/sign_in/sign_in_page.dart';
import 'package:zxplore_app/src/router/dashboard_page.dart';
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

@TypedShellRoute<DashboardRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<AccountInformationRoute>(path: '/accountInformation'),
    TypedGoRoute<ContactDetailsRoute>(path: '/contactDetails'),
    TypedGoRoute<MeansOfIdentificationRoute>(path: '/meansOfIdentification'),
    TypedGoRoute<PersonalInformationRoute>(path: '/personalInformation'),
    TypedGoRoute<SignatoryRoute>(path: '/signatory'),
    TypedGoRoute<UploadIdRoute>(path: '/uploadId'),
    TypedGoRoute<UploadPassportRoute>(path: '/uploadPassport'),
    TypedGoRoute<UploadUtilityBillRoute>(path: '/uploadUtilityBill'),
  ],
)
class DashboardRoute extends ShellRouteData {
  const DashboardRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return DashboardPage(child: navigator);
  }
}

class AccountInformationRoute extends GoRouteData {
  const AccountInformationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountInformationPage();
  }
}

class ContactDetailsRoute extends GoRouteData {
  const ContactDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ContactDetailsPage();
  }
}

class MeansOfIdentificationRoute extends GoRouteData {
  const MeansOfIdentificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MeansOfIdentificationPage();
  }
}

class PersonalInformationRoute extends GoRouteData {
  const PersonalInformationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PersonalInformationPage();
  }
}

class SignatoryRoute extends GoRouteData {
  const SignatoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignatoryPage();
  }
}

class UploadIdRoute extends GoRouteData {
  const UploadIdRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadIdPage();
  }
}

class UploadPassportRoute extends GoRouteData {
  const UploadPassportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadPassportPage();
  }
}

class UploadUtilityBillRoute extends GoRouteData {
  const UploadUtilityBillRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadUtilityBillPage();
  }
}
