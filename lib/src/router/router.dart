import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/src/features/forms/account_information_page.dart';
import 'package:zxplore_app/src/features/forms/contact_details_page.dart';
import 'package:zxplore_app/src/features/forms/means_of_identification_page.dart';
import 'package:zxplore_app/src/features/forms/personal_information_page.dart';
import 'package:zxplore_app/src/features/forms/signatory_page.dart';
import 'package:zxplore_app/src/features/forms/upload_id_page.dart';
import 'package:zxplore_app/src/features/forms/upload_passport_page.dart';
import 'package:zxplore_app/src/features/forms/upload_utility_bill_page.dart';
import 'package:zxplore_app/src/features/sign_in/signin_page.dart';
import 'package:zxplore_app/src/router/dashboard_page.dart';
import 'package:zxplore_app/src/router/nav_observer.dart';
import 'package:zxplore_app/src/router/not_found_page.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final log = Logger('Router');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) => GoRouter(
      routes: $appRoutes,
      initialLocation: '/',
      navigatorKey: rootNavigatorKey,
      errorBuilder: (context, state) =>
          NotFoundScreen(error: state.error!).build(context),
      observers: <NavigatorObserver>[
        NavObserver(),
      ],
    );

@TypedGoRoute<SignInRoute>(path: '/')
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedStatefulShellRoute<DashboardRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<AccountInformationData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AccountInformationRouteData>(path: '/accountInformation'),
      ],
    ),
    TypedStatefulShellBranch<ContactDetailsData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ContactDetailsRouteData>(path: '/contactDetails'),
      ],
    ),
    TypedStatefulShellBranch<MeansOfIdentificationData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MeansOfIdentificationRouteData>(
            path: '/meansOfIdentification'),
      ],
    ),
    TypedStatefulShellBranch<PersonalInformationData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PersonalInformationRouteData>(
            path: '/personalInformation'),
      ],
    ),
    TypedStatefulShellBranch<SignatoryData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SignatoryRouteData>(path: '/signatory'),
      ],
    ),
    TypedStatefulShellBranch<UploadIdData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<UploadIdRouteData>(path: '/uploadId'),
      ],
    ),
    TypedStatefulShellBranch<UploadPassportData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<UploadPassportRouteData>(path: '/uploadPassport'),
      ],
    ),
    TypedStatefulShellBranch<UploadUtilityBillData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<UploadUtilityBillRouteData>(path: '/uploadUtilityBill'),
      ],
    ),
  ],
)
class DashboardRouteData extends StatefulShellRouteData {
  const DashboardRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static const String $restorationScopeId = 'restorationScopeId';

  static Widget $navigatorContainerBuilder(BuildContext context,
      StatefulNavigationShell navigationShell, List<Widget> children) {
    return DashboardPage(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class AccountInformationData extends StatefulShellBranchData {
  const AccountInformationData();
}

class ContactDetailsData extends StatefulShellBranchData {
  const ContactDetailsData();
}

class MeansOfIdentificationData extends StatefulShellBranchData {
  const MeansOfIdentificationData();
}

class PersonalInformationData extends StatefulShellBranchData {
  const PersonalInformationData();
}

class SignatoryData extends StatefulShellBranchData {
  const SignatoryData();
}

class UploadIdData extends StatefulShellBranchData {
  const UploadIdData();
}

class UploadPassportData extends StatefulShellBranchData {
  const UploadPassportData();
}

class UploadUtilityBillData extends StatefulShellBranchData {
  const UploadUtilityBillData();
}

class AccountInformationRouteData extends GoRouteData {
  const AccountInformationRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountInformationPage();
  }
}

class ContactDetailsRouteData extends GoRouteData {
  const ContactDetailsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ContactDetailsPage();
  }
}

class MeansOfIdentificationRouteData extends GoRouteData {
  const MeansOfIdentificationRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MeansOfIdentificationPage();
  }
}

class PersonalInformationRouteData extends GoRouteData {
  const PersonalInformationRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PersonalInformationPage();
  }
}

class SignatoryRouteData extends GoRouteData {
  const SignatoryRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignatoryPage();
  }
}

class UploadIdRouteData extends GoRouteData {
  const UploadIdRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadIdPage();
  }
}

class UploadPassportRouteData extends GoRouteData {
  const UploadPassportRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadPassportPage();
  }
}

class UploadUtilityBillRouteData extends GoRouteData {
  const UploadUtilityBillRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UploadUtilityBillPage();
  }
}
