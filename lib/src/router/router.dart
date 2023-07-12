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

// part 'router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final log = Logger('Router');

/// gorouter provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    // routes: $appRoutes,
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    errorBuilder: (context, state) => NotFoundScreen(
      error: state.error!,
    ).build(context),
    // debugLogDiagnostics: kDebugMode,
    observers: <NavigatorObserver>[NavObserver()],
    routes: <RouteBase>[
      GoRoute(
        // parentNavigatorKey: _rootNavigatorKey,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInPage();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return DashboardPage(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/accountInformation',
                builder: (BuildContext context, GoRouterState state) {
                  return const AccountInformationPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/contactDetails',
                builder: (BuildContext context, GoRouterState state) {
                  return const ContactDetailsPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/meansOfIdentification',
                builder: (BuildContext context, GoRouterState state) {
                  return const MeansOfIdentificationPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/personalInformation',
                builder: (BuildContext context, GoRouterState state) {
                  return const PersonalInformationPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/signatory',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignatoryPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/uploadId',
                builder: (BuildContext context, GoRouterState state) {
                  return const UploadIdPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/uploadPassport',
                builder: (BuildContext context, GoRouterState state) {
                  return const UploadPassportPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/uploadUtilityBill',
                builder: (BuildContext context, GoRouterState state) {
                  return const UploadUtilityBillPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

// @TypedGoRoute<SignInRoute>(path: '/')
// class SignInRoute extends GoRouteData {
//   const SignInRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const SignInPage();
// }

// @TypedStatefulShellRoute<DashboardRoute>(
//   branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
//     TypedStatefulShellBranch<AccountInformationBranch>(
//       routes: [
//         TypedGoRoute<AccountInformationRoute>(path: '/accountInformation'),
//       ],
//     ),
//     TypedStatefulShellBranch<ContactDetailsBranch>(
//       routes: [
//         TypedGoRoute<ContactDetailsRoute>(path: '/contactDetails'),
//       ],
//     ),
//     TypedStatefulShellBranch<MeansOfIdentificationBranch>(
//       routes: [
//         TypedGoRoute<MeansOfIdentificationRoute>(
//             path: '/meansOfIdentification'),
//       ],
//     ),
//     TypedStatefulShellBranch<PersonalInformationBranch>(
//       routes: [
//         TypedGoRoute<PersonalInformationRoute>(path: '/personalInformation'),
//       ],
//     ),
//     TypedStatefulShellBranch<SignatoryBranch>(
//       routes: [
//         TypedGoRoute<SignatoryRoute>(path: '/signatory'),
//       ],
//     ),
//     TypedStatefulShellBranch<UploadIdBranch>(
//       routes: [
//         TypedGoRoute<UploadIdRoute>(path: '/uploadId'),
//       ],
//     ),
//     TypedStatefulShellBranch<UploadPassportBranch>(
//       routes: [
//         TypedGoRoute<UploadPassportRoute>(path: '/uploadPassport'),
//       ],
//     ),
//     TypedStatefulShellBranch<UploadUtilityBillBranch>(
//       routes: [
//         TypedGoRoute<UploadUtilityBillRoute>(path: '/uploadUtilityBill'),
//       ],
//     ),
//   ],
// )
// class DashboardRoute extends StatefulShellRouteData {
//   const DashboardRoute();

//   static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

//   @override
//   Widget builder(
//     BuildContext context,
//     GoRouterState state,
//     StatefulNavigationShell navigationShell,
//   ) {
//     return DashboardPage(navigationShell: navigationShell);
//   }
// }

// class AccountInformationBranch extends StatefulShellBranchData {
//   const AccountInformationBranch();
// }

class AccountInformationRoute extends GoRouteData {
  const AccountInformationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountInformationPage();
  }
}

// class ContactDetailsBranch extends StatefulShellBranchData {
//   const ContactDetailsBranch();
// }

class ContactDetailsRoute extends GoRouteData {
  const ContactDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ContactDetailsPage();
  }
}

// class MeansOfIdentificationBranch extends StatefulShellBranchData {
//   const MeansOfIdentificationBranch();
// }

class MeansOfIdentificationRoute extends GoRouteData {
  const MeansOfIdentificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MeansOfIdentificationPage();
  }
}

// class PersonalInformationBranch extends StatefulShellBranchData {
//   const PersonalInformationBranch();
// }

class PersonalInformationRoute extends GoRouteData {
  const PersonalInformationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PersonalInformationPage();
  }
}

// class SignatoryBranch extends StatefulShellBranchData {
//   const SignatoryBranch();
// }

class SignatoryRoute extends GoRouteData {
  const SignatoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignatoryPage();
  }
}

// class UploadIdBranch extends StatefulShellBranchData {
//   const UploadIdBranch();
// }

class UploadIdRoute extends GoRouteData {
  const UploadIdRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadIdPage();
  }
}

// class UploadPassportBranch extends StatefulShellBranchData {
//   const UploadPassportBranch();
// }

class UploadPassportRoute extends GoRouteData {
  const UploadPassportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadPassportPage();
  }
}

// class UploadUtilityBillBranch extends StatefulShellBranchData {
//   const UploadUtilityBillBranch();
// }

class UploadUtilityBillRoute extends GoRouteData {
  const UploadUtilityBillRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadUtilityBillPage();
  }
}
