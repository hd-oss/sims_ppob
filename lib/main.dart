import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'injection_container.dart' as di;

void main() {
  
  di.init();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMS-PPOB',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: _appRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
