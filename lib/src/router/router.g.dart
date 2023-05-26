// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $signInRoute,
      $dashboardRoute,
    ];

RouteBase get $signInRoute => GoRouteData.$route(
      path: '/',
      factory: $SignInRouteExtension._fromState,
    );

extension $SignInRouteExtension on SignInRoute {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $dashboardRoute => ShellRouteData.$route(
      factory: $DashboardRouteExtension._fromState,
      navigatorKey: DashboardRoute.$navigatorKey,
      routes: [
        GoRouteData.$route(
          path: '/accountInformation',
          factory: $AccountInformationRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/contactDetails',
          factory: $ContactDetailsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/meansOfIdentification',
          factory: $MeansOfIdentificationRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/personalInformation',
          factory: $PersonalInformationRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/signatory',
          factory: $SignatoryRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/uploadId',
          factory: $UploadIdRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/uploadPassport',
          factory: $UploadPassportRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/uploadUtilityBill',
          factory: $UploadUtilityBillRouteExtension._fromState,
        ),
      ],
    );

extension $DashboardRouteExtension on DashboardRoute {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();
}

extension $AccountInformationRouteExtension on AccountInformationRoute {
  static AccountInformationRoute _fromState(GoRouterState state) =>
      const AccountInformationRoute();

  String get location => GoRouteData.$location(
        '/accountInformation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $ContactDetailsRouteExtension on ContactDetailsRoute {
  static ContactDetailsRoute _fromState(GoRouterState state) =>
      const ContactDetailsRoute();

  String get location => GoRouteData.$location(
        '/contactDetails',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $MeansOfIdentificationRouteExtension on MeansOfIdentificationRoute {
  static MeansOfIdentificationRoute _fromState(GoRouterState state) =>
      const MeansOfIdentificationRoute();

  String get location => GoRouteData.$location(
        '/meansOfIdentification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $PersonalInformationRouteExtension on PersonalInformationRoute {
  static PersonalInformationRoute _fromState(GoRouterState state) =>
      const PersonalInformationRoute();

  String get location => GoRouteData.$location(
        '/personalInformation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $SignatoryRouteExtension on SignatoryRoute {
  static SignatoryRoute _fromState(GoRouterState state) =>
      const SignatoryRoute();

  String get location => GoRouteData.$location(
        '/signatory',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $UploadIdRouteExtension on UploadIdRoute {
  static UploadIdRoute _fromState(GoRouterState state) => const UploadIdRoute();

  String get location => GoRouteData.$location(
        '/uploadId',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $UploadPassportRouteExtension on UploadPassportRoute {
  static UploadPassportRoute _fromState(GoRouterState state) =>
      const UploadPassportRoute();

  String get location => GoRouteData.$location(
        '/uploadPassport',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $UploadUtilityBillRouteExtension on UploadUtilityBillRoute {
  static UploadUtilityBillRoute _fromState(GoRouterState state) =>
      const UploadUtilityBillRoute();

  String get location => GoRouteData.$location(
        '/uploadUtilityBill',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
