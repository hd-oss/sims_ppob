import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TopupPage extends ConsumerWidget {
  const TopupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text('Topup Page'));
  }
}