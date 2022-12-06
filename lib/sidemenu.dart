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
        SidebarTabItem(icon: Icons.show_chart, title: "Analytics"),
        SidebarTabItem(icon: Icons.account_tree_outlined, title: "Database"),
        SidebarTabItem(icon: Icons.history, title: "History"),
        SidebarTabItem(icon: Icons.shopping_cart_outlined, title: "Orders"),
      ],
    );
  }
}
