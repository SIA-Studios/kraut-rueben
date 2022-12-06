import 'package:flutter/material.dart';
import 'package:kraut_rueben/widgets/sidebar.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

int currentTab = 0;

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return SideBar(
      currentIndex: currentTab,
      onTap: (index) {
        if (currentTab != index) {
          setState(() {
            currentTab = index;
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
