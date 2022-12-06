import 'package:flutter/material.dart';
import 'package:kraut_rueben/pages/analytics_page.dart';
import 'package:kraut_rueben/pages/database_page.dart';
import 'package:kraut_rueben/pages/history_page.dart';
import 'package:kraut_rueben/pages/orders_page.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white.withOpacity(0.15),
          child: ValueListenableBuilder(
              valueListenable: MyApp.currentTab,
              builder: (context, value, child) {
                return IndexedStack(
                  alignment: Alignment.center,
                  index: value,
                  children: [
                    DatabasePage(),
                    AnalyticsPage(),
                    HistoryPage(),
                    OrdersPage()
                  ],
                );
              }),
        ),
      ),
    );
  }
}
