import 'package:flutter/material.dart';
import 'package:kraut_rueben/pages/privacy_page.dart';
import 'package:kraut_rueben/pages/query_page.dart';
import 'package:kraut_rueben/pages/database_page.dart';
import 'package:kraut_rueben/pages/stock_page.dart';
import 'package:kraut_rueben/pages/recipes_page.dart';

import 'backend/database.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

ConnectionStatus? status;

class HomePageState extends State<HomePage> {
  Future<ConnectionStatus> _login() async {
    status ??=
        await DatabaseManager.connectToDatabase("tim", ")EZ[6euWtXKou2z)");
    return status!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ValueListenableBuilder(
          valueListenable: MyApp.currentTab,
          builder: (context, value, child) {
            return FutureBuilder(
                future: _login(),
                builder: (context, snapshot) {
                  if (snapshot.data != ConnectionStatus.success) {
                    _login();
                    return Container();
                  }
                  return IndexedStack(
                    alignment: Alignment.center,
                    index: value,
                    children: const [
                      QueryPage(),
                      RecipesPage(),
                      StockPage(),
                      PrivacyPage(),
                    ],
                  );
                });
          }),
    );
  }
}
