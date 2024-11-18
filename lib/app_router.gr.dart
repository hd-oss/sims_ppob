// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i13;
import 'package:sims_ppob/data/models/service_model.dart' as _i12;
import 'package:sims_ppob/presentation/pages/auth/login_page.dart' as _i4;
import 'package:sims_ppob/presentation/pages/dashboard/dashboard_page.dart'
    as _i2;
import 'package:sims_ppob/presentation/pages/home/home_page.dart' as _i3;
import 'package:sims_ppob/presentation/pages/home/home_route.dart' as _i1;
import 'package:sims_ppob/presentation/pages/profile/profile_page.dart' as _i5;
import 'package:sims_ppob/presentation/pages/purches/purches_page.dart' as _i6;
import 'package:sims_ppob/presentation/pages/registrasion/registrasion_page.dart'
    as _i7;
import 'package:sims_ppob/presentation/pages/splash_page.dart' as _i8;
import 'package:sims_ppob/presentation/pages/top_up/topup_page.dart' as _i9;
import 'package:sims_ppob/presentation/pages/transaction/transacion_page.dart'
    as _i10;

abstract class $RootRouter extends _i11.RootStackRouter {
  $RootRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    TransactionTab.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ApprovalHistoryTabPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    DashboardTab.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    TopupTab.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationTabPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ProfilePage(),
      );
    },
    ProfileTab.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ProfileTabPage(),
      );
    },
    PurchesRoute.name: (routeData) {
      final args = routeData.argsAs<PurchesRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PurchesPage(
          args.serviceModel,
          key: args.key,
        ),
      );
    },
    RegistrasionRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegistrasionPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SplashPage(),
      );
    },
    TopupRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.TopupPage(),
      );
    },
    TransactionRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.TransactionPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ApprovalHistoryTabPage]
class TransactionTab extends _i11.PageRouteInfo<void> {
  const TransactionTab({List<_i11.PageRouteInfo>? children})
      : super(
          TransactionTab.name,
          initialChildren: children,
        );

  static const String name = 'TransactionTab';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute({List<_i11.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i1.DashboardTabPage]
class DashboardTab extends _i11.PageRouteInfo<void> {
  const DashboardTab({List<_i11.PageRouteInfo>? children})
      : super(
          DashboardTab.name,
          initialChildren: children,
        );

  static const String name = 'DashboardTab';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i1.NotificationTabPage]
class TopupTab extends _i11.PageRouteInfo<void> {
  const TopupTab({List<_i11.PageRouteInfo>? children})
      : super(
          TopupTab.name,
          initialChildren: children,
        );

  static const String name = 'TopupTab';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i1.ProfileTabPage]
class ProfileTab extends _i11.PageRouteInfo<void> {
  const ProfileTab({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PurchesPage]
class PurchesRoute extends _i11.PageRouteInfo<PurchesRouteArgs> {
  PurchesRoute({
    required _i12.ServiceModel serviceModel,
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          PurchesRoute.name,
          args: PurchesRouteArgs(
            serviceModel: serviceModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PurchesRoute';

  static const _i11.PageInfo<PurchesRouteArgs> page =
      _i11.PageInfo<PurchesRouteArgs>(name);
}

class PurchesRouteArgs {
  const PurchesRouteArgs({
    required this.serviceModel,
    this.key,
  });

  final _i12.ServiceModel serviceModel;

  final _i13.Key? key;

  @override
  String toString() {
    return 'PurchesRouteArgs{serviceModel: $serviceModel, key: $key}';
  }
}

/// generated route for
/// [_i7.RegistrasionPage]
class RegistrasionRoute extends _i11.PageRouteInfo<void> {
  const RegistrasionRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegistrasionRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrasionRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.TopupPage]
class TopupRoute extends _i11.PageRouteInfo<void> {
  const TopupRoute({List<_i11.PageRouteInfo>? children})
      : super(
          TopupRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopupRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.TransactionPage]
class TransactionRoute extends _i11.PageRouteInfo<void> {
  const TransactionRoute({List<_i11.PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
