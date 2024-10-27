// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:sims_ppob/presentation/pages/auth/login_page.dart' as _i4;
import 'package:sims_ppob/presentation/pages/dashboard/dashboard_page.dart'
    as _i2;
import 'package:sims_ppob/presentation/pages/home/home_page.dart' as _i3;
import 'package:sims_ppob/presentation/pages/home/home_route.dart' as _i1;
import 'package:sims_ppob/presentation/pages/profile/profile_page.dart' as _i5;
import 'package:sims_ppob/presentation/pages/registrasion/registrasion_page.dart'
    as _i6;
import 'package:sims_ppob/presentation/pages/splash_page.dart' as _i7;
import 'package:sims_ppob/presentation/pages/top_up/top_up.dart' as _i8;
import 'package:sims_ppob/presentation/pages/transaction/transacion_page.dart'
    as _i9;

abstract class $RootRouter extends _i10.RootStackRouter {
  $RootRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    TransactionTab.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ApprovalHistoryTabPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    DashboardTab.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    TopupTab.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationTabPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ProfilePage(),
      );
    },
    ProfileTab.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ProfileTabPage(),
      );
    },
    RegistrasionRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegistrasionPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SplashPage(),
      );
    },
    TopupRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.TopupPage(),
      );
    },
    TransactionRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.TransactionPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ApprovalHistoryTabPage]
class TransactionTab extends _i10.PageRouteInfo<void> {
  const TransactionTab({List<_i10.PageRouteInfo>? children})
      : super(
          TransactionTab.name,
          initialChildren: children,
        );

  static const String name = 'TransactionTab';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute({List<_i10.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i1.DashboardTabPage]
class DashboardTab extends _i10.PageRouteInfo<void> {
  const DashboardTab({List<_i10.PageRouteInfo>? children})
      : super(
          DashboardTab.name,
          initialChildren: children,
        );

  static const String name = 'DashboardTab';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i1.NotificationTabPage]
class TopupTab extends _i10.PageRouteInfo<void> {
  const TopupTab({List<_i10.PageRouteInfo>? children})
      : super(
          TopupTab.name,
          initialChildren: children,
        );

  static const String name = 'TopupTab';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ProfilePage]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i1.ProfileTabPage]
class ProfileTab extends _i10.PageRouteInfo<void> {
  const ProfileTab({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegistrasionPage]
class RegistrasionRoute extends _i10.PageRouteInfo<void> {
  const RegistrasionRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RegistrasionRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrasionRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.TopupPage]
class TopupRoute extends _i10.PageRouteInfo<void> {
  const TopupRoute({List<_i10.PageRouteInfo>? children})
      : super(
          TopupRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopupRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.TransactionPage]
class TransactionRoute extends _i10.PageRouteInfo<void> {
  const TransactionRoute({List<_i10.PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
