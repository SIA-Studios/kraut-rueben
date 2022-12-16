import 'package:flutter/material.dart';
import 'package:kraut_rueben/main.dart';
import 'package:kraut_rueben/widgets/sidebar.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return SideBar(
      currentIndex: MyApp.currentTab.value,
      onTap: (index) {
        if (MyApp.currentTab.value != index) {
          setState(() {
            MyApp.currentTab.value = index;
          });
        }
      },
      items: [
        SidebarTabItem(icon: Icons.category_outlined, title: "Categories"),
        SidebarTabItem(icon: Icons.description_outlined, title: "Recipes"),
        SidebarTabItem(icon: Icons.inventory_outlined, title: "Stock"),
      ],
    );
  }
}
