// Smoke test untuk root aplikasi SIMS-PPOB.
//
// Test ini merender root widget yang sebenarnya (ProviderScope +
// MaterialApp.router dengan RootRouter) dan memastikan widget terbangun
// tanpa melempar error.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sims_ppob/app_router.dart';

void main() {
  testWidgets('App root builds without throwing', (WidgetTester tester) async {
    final rootRouter = RootRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          title: 'SIMS-PPOB',
          routerConfig: rootRouter.config(),
        ),
      ),
    );

    // Render frame pertama: pastikan root MaterialApp terbangun.
    await tester.pump();
    expect(find.byType(MaterialApp), findsWidgets);

    // SplashPage memulai Timer 2 detik pada initState lalu bernavigasi.
    // Majukan waktu agar timer terselesaikan sehingga tidak ada timer
    // yang tertunda saat widget tree dibuang.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Setelah navigasi, root MaterialApp tetap terbangun tanpa error.
    expect(find.byType(MaterialApp), findsWidgets);
  });
}
