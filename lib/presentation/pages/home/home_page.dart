import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sims_ppob/presentation/controllers/dashboard_controller.dart';
import 'package:sims_ppob/presentation/controllers/profile_controller.dart';
import 'package:sims_ppob/presentation/controllers/topup_controller.dart';
import 'package:sims_ppob/presentation/controllers/transaction_controller.dart';
import 'package:sims_ppob/presentation/providers/dashboard_provider.dart';
import 'package:sims_ppob/presentation/providers/profile_provider.dart';
import 'package:sims_ppob/presentation/providers/topup_provider.dart';
import 'package:sims_ppob/presentation/providers/transaction_provider.dart';

import '../../../app_router.gr.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int? currentPage;
  @override
  Widget build(BuildContext context) {
    final itemNavBar = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.money_rounded, 'label': 'Top Up'},
      {'icon': Icons.credit_card_rounded, 'label': 'Transaction'},
      {'icon': Icons.person_rounded, 'label': 'akun'},
    ];

    return AutoTabsRouter(
        routes: const [
          DashboardTab(),
          TopupTab(),
          TransactionTab(),
          ProfileTab(),
        ],
        builder: (context, child) {
          final activeIndex = context.tabsRouter.activeIndex;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final provider = [
              ref.read(dashboardProvider.notifier),
              ref.read(topupProvider.notifier),
              ref.read(transactionProvider.notifier),
              ref.read(profileProvider.notifier)
            ][activeIndex];
            if (currentPage == activeIndex) return;
            switch (context.tabsRouter.activeIndex) {
              case 0:
                provider as DashboardController;
                provider.initState();
                break;
              case 1:
                provider as TopupController;
                provider.initState();
                break;
              case 2:
                provider as TransactionController;
                provider.initState();
                provider.getHistory();
                break;
              case 3:
                provider as ProfileController;
                provider.initState();
                break;
              default:
            }
            currentPage = activeIndex;
          });

          return Scaffold(
            appBar: context.tabsRouter.activeIndex != 0
                ? AppBar(
                  surfaceTintColor: Colors.white,
                    centerTitle: true,
                    title: Text(
                        [
                          '',
                          'Top Up',
                          'Transaksi',
                          'Akun'
                        ][context.tabsRouter.activeIndex],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                  )
                : null,
            body: child,
            resizeToAvoidBottomInset: !(activeIndex == 1),
            bottomNavigationBar: NavigationBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                shadowColor: Colors.black,
                elevation: 10,
                selectedIndex: context.tabsRouter.activeIndex,
                destinations: itemNavBar.asMap().entries.map((entry) {
                  int index = entry.key;
                  var data = entry.value;
                  return _buildNavButton(
                      icon: data['icon'] as IconData,
                      lebel: data['label'] as String,
                      index: index,
                      context: context);
                }).toList()),
          );
        });
  }

  Widget _buildNavButton(
      {required IconData icon,
      required String lebel,
      required int index,
      required BuildContext context}) {
    final isSelected = index == context.tabsRouter.activeIndex;

    return IconButton(
        onPressed: () => context.tabsRouter.setActiveIndex(index),
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.black : Colors.grey),
            Text(
              lebel,
              style: TextStyle(color: isSelected ? Colors.black : Colors.grey),
            )
          ],
        ));
  }
}
