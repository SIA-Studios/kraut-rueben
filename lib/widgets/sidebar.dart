import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window_platform_interface/bitsdojo_window_platform_interface.dart';
import 'package:kraut_rueben/sidemenu.dart';

import '../main.dart';

class SideBar extends ConsumerStatefulWidget {
  final List<SidebarItem> items;
  final ValueChanged<int>? onTap;
  int? currentIndex;
  Color? defaultSelectedColor = Colors.amber;
  Color? defaultUnselectedColor = Colors.white;

  SideBar({
    super.key,
    required this.items,
    this.onTap,
    this.currentIndex,
    this.defaultSelectedColor,
    this.defaultUnselectedColor,
  });

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar>
    with TickerProviderStateMixin {
  int currentIndexAbs = 0;
  int currentIndexAbsDelayed = 0;
  int lastIndexAbs = 0;

  void setDelayedIndex() {
    var timer = Future.delayed(const Duration(milliseconds: 75));
    timer.whenComplete(() {
      setState(() {
        currentIndexAbsDelayed = currentIndexAbs;
        lastIndexAbs = currentIndexAbs;
      });
    });
  }

  bool getTabDirection() {
    if (currentIndexAbs > lastIndexAbs || currentIndexAbs == lastIndexAbs) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double tileHeight = 40;
    double sidebarHeight = MediaQuery.of(context).size.height -
        BitsdojoWindowPlatform.instance.appWindow.titleBarHeight -
        3;
    var tiles = createTiles(tileHeight);

    return Row(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                AnimatedPositioned(
                  left: 0,
                  right: 0,
                  top: tileHeight *
                      (getTabDirection()
                          ? currentIndexAbsDelayed.toDouble()
                          : currentIndexAbs.toDouble()),
                  bottom: sidebarHeight -
                      (tileHeight *
                              (getTabDirection()
                                  ? currentIndexAbs.toDouble()
                                  : currentIndexAbsDelayed.toDouble()) +
                          tileHeight),
                  duration: const Duration(milliseconds: 300),
                  curve: const Cubic(0, 0, 0, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(tileHeight / 2),
                              color: Colors.white54)),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: tiles,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> createTiles(double height) {
    List<Widget> tabTiles = [];
    int currIndex = 0;
    List<int> indexes = <int>[];
    List<int> indexesAbs = <int>[];

    widget.items.asMap().forEach((i, item) {
      indexesAbs.add(i);
      indexes.add(currIndex);
      switch (item.runtimeType) {
        case SidebarTabItem:
          final tile = _SidebarTabTile(
            index: i,
            icon: item.icon,
            height: height,
            callback: () {
              if (widget.currentIndex == null || widget.onTap == null) return;
              if (indexes[i] != widget.currentIndex) {
                widget.onTap!.call(indexes[i]);
                setDelayedIndex();
                currentIndexAbs = indexesAbs[i];
                HapticFeedback.selectionClick();
              }
            },
            title: (item as SidebarTabItem).title,
            child: (item).child,
          );
          tabTiles.add(tile);
          currIndex++;
          break;
        case SidebarFunctionItem:
          _SidebarFunctionTile tile = _SidebarFunctionTile(
            index: i,
            backgroundColor: (item as SidebarFunctionItem).iconColor!,
            function: item.function,
            icon: item.icon,
            height: height,
            title: item.title,
          );
          tabTiles.add(tile);
          break;
      }
    });
    return tabTiles;
  }
}

abstract class _SidebarTile extends ConsumerWidget {
  final int index;
  final IconData icon;
  final double height;
  Color? selectedColor;
  Color? unselectedColor;

  _SidebarTile({
    super.key,
    required this.index,
    required this.icon,
    required this.height,
    this.selectedColor,
    this.unselectedColor,
  });
}

class _SidebarTabTile extends _SidebarTile {
  final void Function() callback;
  String? title;
  Widget? child;
  _SidebarTabTile(
      {required super.icon,
      required super.height,
      required super.index,
      required this.callback,
      this.title,
      this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (details) {
        callback.call();
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        opacity: index == MyApp.currentTab.value ? 1 : 0.65,
        child: Container(
          height: height,
          width: 200,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                child ??
                    Icon(
                      color: const Color.fromARGB(255, 8, 46, 10),
                      icon,
                    ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      title ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 8, 46, 10),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarFunctionTile extends _SidebarTile {
  final void Function() function;
  final Color backgroundColor;
  String? title;
  _SidebarFunctionTile(
      {required super.icon,
      required super.height,
      required super.index,
      required this.function,
      this.title,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (details) {
        function.call();
      },
      child: Container(
        color: Colors.transparent,
        height: height,
        width: 30,
        child: Row(
          children: [
            Icon(
              icon,
              shadows: const [
                Shadow(
                  color: Colors.green,
                  blurRadius: 150,
                )
              ],
              color: backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

abstract class SidebarItem {
  final IconData icon;
  String? title;

  SidebarItem({required this.icon, this.title});
}

class SidebarTabItem extends SidebarItem {
  Widget? child;

  SidebarTabItem({required super.icon, this.child, super.title});
}

class SidebarFunctionItem extends SidebarItem {
  final void Function() function;
  Color? iconColor = Colors.grey;

  SidebarFunctionItem(
      {required super.icon,
      required this.function,
      this.iconColor,
      super.title});
}
