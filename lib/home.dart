import 'package:flutter/material.dart';
import 'package:kraut_rueben/pages/categories_page.dart';
import 'package:kraut_rueben/pages/database_page.dart';
import 'package:kraut_rueben/pages/ingredients_page.dart';
import 'package:kraut_rueben/pages/recipes_page.dart';

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
      padding: const EdgeInsets.all(30.0),
      child: ValueListenableBuilder(
          valueListenable: MyApp.currentTab,
          builder: (context, value, child) {
            return IndexedStack(
              alignment: Alignment.center,
              index: value,
              children: const [
                DatabasePage(),
                CategoriesPage(),
                RecipesPage(),
                IngredientsPage(),
              ],
            );
          }),
    );
  }
}
