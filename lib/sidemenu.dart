import 'package:flutter/material.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/home.dart';
import 'package:kraut_rueben/main.dart';
import 'package:kraut_rueben/utils/transitions.dart';
import 'package:kraut_rueben/widgets/sidebar.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SideBar(
          currentIndex: MyApp.currentTab.value,
          onTap: (index) {
            if (MyApp.currentTab.value != index) {
              setState(() {
                MyApp.currentTab.value = index;
              });
            }
          },
          items: [
            SidebarTabItem(icon: Icons.terminal_outlined, title: "Query"),
            SidebarTabItem(icon: Icons.description_outlined, title: "Recipes"),
            SidebarTabItem(icon: Icons.inventory_outlined, title: "Stock"),
            SidebarTabItem(icon: Icons.lock_outlined, title: "Privacy"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: GestureDetector(
            onTap: (() {
              DatabaseManager.closeConnection();
              showLoginPopup();
              MyApp.currentTab.value = 0;
            }),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Text("Sign Out")),
            ),
          ),
        )
      ],
    );
  }
}
