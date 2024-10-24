import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'injection_container.dart' as di;
import 'presentation/pages/auth/login_page.dart';

void main() {
  di.init();
  ProviderScope(
    child: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Penggunaan routes untuk navigasi yang lebih kompleks
      routes: {
        '/': (context) => LoginPage(),
        // '/home': (context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}

