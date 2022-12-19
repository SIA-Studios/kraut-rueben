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
  Color signoutButtonColor = Colors.white.withOpacity(0.3);
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: MouseRegion(
              onEnter: (event) => setState(() {
                signoutButtonColor = Colors.white.withOpacity(0.6);
              }),
              onExit: (event) => setState(() {
                signoutButtonColor = Colors.white.withOpacity(0.3);
              }),
              child: GestureDetector(
                onTap: (() {
                  DatabaseManager.closeConnection();
                  showLoginPopup();
                  MyApp.currentTab.value = 0;
                  setState(() {});
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: 40,
                  decoration: BoxDecoration(
                      color: signoutButtonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("Sign Out")),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
