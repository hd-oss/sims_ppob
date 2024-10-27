import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';
import 'common/secure_storage_helper.dart';
import 'injection_container.dart';
import 'presentation/pages/home/home_route.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class RootRouter extends $RootRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SplashRoute.page,
      path: '/',
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: RegistrasionRoute.page, path: '/regitrasion'),
    homeRoutes,
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final String? token = await sl<SecureStorageHelper>().readToken();
    if (token != null) {
      resolver.next(true);
    } else {
      router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
    }
  }
}
