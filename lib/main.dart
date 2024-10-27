import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final rootRouter = RootRouter();
  di.init();

  runApp(
    ProviderScope(
        child: MaterialApp.router(
      title: 'SIMS-PPOB',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xffec392e),
          onPrimary: Colors.white,
          background: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Colors.grey ,width: 2),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(4.0)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red,width: 2),
              borderRadius: BorderRadius.circular(4.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(4.0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: const Color(0xffec392e),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
          ),
        ),
        
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            foregroundColor: const Color(0xffec392e),
            side: const BorderSide(color: Color(0xffec392e), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(color: Color(0xffec392e)),
            ),
          ),
        ),
      ),
      routerConfig: rootRouter.config(),
    )),
  );
}
