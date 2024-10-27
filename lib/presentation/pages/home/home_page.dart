import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        builder: (context, child) => Scaffold(
              appBar: context.tabsRouter.activeIndex != 0
                  ? AppBar(
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
            ));
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
