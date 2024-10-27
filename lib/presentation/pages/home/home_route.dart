import 'package:auto_route/auto_route.dart';

import '../../../app_router.dart';
import '../../../app_router.gr.dart';

final homeRoutes = CustomRoute(
  page: HomeRoute.page,
  path: '/home',
  guards: [AuthGuard()],
  children: [
    CustomRoute(
      path: 'dashboard',
      page: DashboardTab.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      children: [
        AutoRoute(path: '', page: DashboardRoute.page, guards: [AuthGuard()]),
      ],
    ),
    CustomRoute(
      path: 'top-up',
      page: TopupTab.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      children: [
        AutoRoute(path: '', page: TopupRoute.page, guards: [AuthGuard()]),
      ],
    ),
    CustomRoute(
      path: 'transaction',
      page: TransactionTab.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      children: [
        AutoRoute(path: '', page: TransactionRoute.page, guards: [AuthGuard()]),
      ],
    ),
    CustomRoute(
      path: 'profile',
      page: ProfileTab.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      children: [
        AutoRoute(path: '', page: ProfileRoute.page, guards: [AuthGuard()]),
      ],
    ),
  ],
);

@RoutePage(name: 'DashboardTab')
class DashboardTabPage extends AutoRouter {
  const DashboardTabPage({super.key});
}

@RoutePage(name: 'TopupTab')
class NotificationTabPage extends AutoRouter {
  const NotificationTabPage({super.key});
}

@RoutePage(name: 'TransactionTab')
class ApprovalHistoryTabPage extends AutoRouter {
  const ApprovalHistoryTabPage({super.key});
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}
