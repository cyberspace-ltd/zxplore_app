// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $signInRoute,
      $dashboardRouteData,
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

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dashboardRouteData => StatefulShellRouteData.$route(
      restorationScopeId: DashboardRouteData.$restorationScopeId,
      navigatorContainerBuilder: DashboardRouteData.$navigatorContainerBuilder,
      factory: $DashboardRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/accountInformation',
              factory: $AccountInformationRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/contactDetails',
              factory: $ContactDetailsRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/meansOfIdentification',
              factory: $MeansOfIdentificationRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/personalInformation',
              factory: $PersonalInformationRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/signatory',
              factory: $SignatoryRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/uploadId',
              factory: $UploadIdRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/uploadPassport',
              factory: $UploadPassportRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/uploadUtilityBill',
              factory: $UploadUtilityBillRouteDataExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $DashboardRouteDataExtension on DashboardRouteData {
  static DashboardRouteData _fromState(GoRouterState state) =>
      const DashboardRouteData();
}

extension $AccountInformationRouteDataExtension on AccountInformationRouteData {
  static AccountInformationRouteData _fromState(GoRouterState state) =>
      const AccountInformationRouteData();

  String get location => GoRouteData.$location(
        '/accountInformation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ContactDetailsRouteDataExtension on ContactDetailsRouteData {
  static ContactDetailsRouteData _fromState(GoRouterState state) =>
      const ContactDetailsRouteData();

  String get location => GoRouteData.$location(
        '/contactDetails',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MeansOfIdentificationRouteDataExtension
    on MeansOfIdentificationRouteData {
  static MeansOfIdentificationRouteData _fromState(GoRouterState state) =>
      const MeansOfIdentificationRouteData();

  String get location => GoRouteData.$location(
        '/meansOfIdentification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PersonalInformationRouteDataExtension
    on PersonalInformationRouteData {
  static PersonalInformationRouteData _fromState(GoRouterState state) =>
      const PersonalInformationRouteData();

  String get location => GoRouteData.$location(
        '/personalInformation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignatoryRouteDataExtension on SignatoryRouteData {
  static SignatoryRouteData _fromState(GoRouterState state) =>
      const SignatoryRouteData();

  String get location => GoRouteData.$location(
        '/signatory',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UploadIdRouteDataExtension on UploadIdRouteData {
  static UploadIdRouteData _fromState(GoRouterState state) =>
      const UploadIdRouteData();

  String get location => GoRouteData.$location(
        '/uploadId',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UploadPassportRouteDataExtension on UploadPassportRouteData {
  static UploadPassportRouteData _fromState(GoRouterState state) =>
      const UploadPassportRouteData();

  String get location => GoRouteData.$location(
        '/uploadPassport',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UploadUtilityBillRouteDataExtension on UploadUtilityBillRouteData {
  static UploadUtilityBillRouteData _fromState(GoRouterState state) =>
      const UploadUtilityBillRouteData();

  String get location => GoRouteData.$location(
        '/uploadUtilityBill',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'f2f38f38aa34e9f72e1f6d9dbc49530dd1671e16';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = Provider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GoRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
