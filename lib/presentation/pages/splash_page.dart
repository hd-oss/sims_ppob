import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob/app_router.gr.dart';

import '../../common/secure_storage_helper.dart';
import '../../injection_container.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    await Future.delayed(const Duration(seconds: 2));

    String? token = await sl<SecureStorageHelper>().readToken();

    if (!mounted) return;
    token != null && token.isNotEmpty
        ? context.router.pushAndPopUntil(HomeRoute(), predicate: (_) => false)
        : context.router.pushAndPopUntil(LoginRoute(), predicate: (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/Logo.png'),
            const SizedBox(height: 8),
            const Text(
              'SIMS PPOB',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const SizedBox(height: 8),
            const Text('Hafizh Dharmawan', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
