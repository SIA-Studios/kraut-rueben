import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/home.dart';
import 'package:kraut_rueben/sidemenu.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1000, 650);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.show();
  });

  final status =
      await DatabaseManager.connectToDatabase("finn", "ZUeiTvxqUc8(A3T/");
  print(status);
}

const borderColor = Color.fromARGB(255, 0, 56, 49);

class MyApp extends StatelessWidget {
  static ValueNotifier<int> currentTab = ValueNotifier<int>(0);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "montserrat",
      ),
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child: Row(
            children: const [LeftSide(), RightSide()],
          ),
        ),
      ),
    );
  }
}

const sidebarColor = Color.fromARGB(255, 45, 181, 136);

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [backgroundStartColor, backgroundEndColor],
                stops: [0.0, 1.0]),
          ),
          child: Container(
            color: Colors.white.withOpacity(0.15),
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: SideMenu()),
              ],
            ),
          ),
        ));
  }
}

const backgroundStartColor = Color.fromARGB(255, 53, 216, 115);
const backgroundEndColor = Color.fromARGB(255, 20, 161, 114);

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
        child: Stack(children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          ),
          const Expanded(child: HomePage())
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color.fromARGB(255, 37, 38, 38),
    mouseOver: const Color.fromARGB(255, 4, 96, 48),
    mouseDown: const Color.fromARGB(255, 4, 96, 48),
    iconMouseOver: Colors.white,
    iconMouseDown: Colors.white);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color.fromARGB(255, 37, 38, 38),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
