import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';
import 'common/secure_storage_helper.dart';
import 'presentation/pages/home/home_route.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class RootRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegistrasionRoute.page, path: '/regitrasion'),
        AutoRoute(page: PurchesRoute.page, path: '/purches'),
        homeRoutes,
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    // Akses SecureStorageHelper secara langsung tanpa DI
    final String? token = await SecureStorageHelper().readToken();
    if (token != null) {
      resolver.next(true);
    } else {
      router.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
    }
  }
}
