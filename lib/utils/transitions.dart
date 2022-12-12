import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'input_array_popup.dart';
import 'input_popup.dart';
import 'login_popup.dart';
import 'package:kraut_rueben/main.dart';

void showInputPopup(
    {required String title,
    required String initialValue,
    ValueChanged<String>? onConfirm,
    String? Function(String?)? validator,
    Widget? customSymbol,
    List<TextInputFormatter>? inputFormatters}) {
  navigatorKey.currentState?.push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) => InputPopup(
          title: title,
          initialValue: initialValue,
          onConfirm: onConfirm,
          validator: validator,
          inputFormatters: inputFormatters,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Cubic(0, 1, 0.5, 1);
          const offsetBegin = Offset(0.0, 0.3);
          const offsetEnd = Offset.zero;
          const fadeBegin = 0.0;
          const fadeEnd = 1.0;
          final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
              .chain(CurveTween(curve: curve));
          final fadeTween = Tween(begin: fadeBegin, end: fadeEnd)
              .chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(offsetTween);
          final fadeAnimation = animation.drive(fadeTween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      ));
}

void showInputArrayPopup(
    {required String title,
    required List<String> initialValue,
    ValueChanged<List<String>>? onConfirm,
    String? Function(String?)? validator,
    Widget? customSymbol,
    List<TextInputFormatter>? inputFormatters}) {
  navigatorKey.currentState?.push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) =>
            InputArrayPopup(
          title: title,
          initialValue: initialValue,
          onConfirm: onConfirm,
          validator: validator,
          inputFormatters: inputFormatters,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Cubic(0, 1, 0.5, 1);
          const offsetBegin = Offset(0.0, 0.3);
          const offsetEnd = Offset.zero;
          const fadeBegin = 0.0;
          const fadeEnd = 1.0;
          final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
              .chain(CurveTween(curve: curve));
          final fadeTween = Tween(begin: fadeBegin, end: fadeEnd)
              .chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(offsetTween);
          final fadeAnimation = animation.drive(fadeTween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      ));
}

void Function() showPopupWidget(
    {required Widget widget, required BuildContext context}) {
  return () => showCupertinoModalPopup(
      builder: (context) => widget,
      context: context,
      barrierColor: Colors.black.withOpacity(0.6));
}

void showLoginPopup() {
  print("open login popup");
  navigatorKey.currentState?.push(PageRouteBuilder(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => LoginPopup(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Cubic(0, 1, 0.5, 1);
      const offsetBegin = Offset(0.0, 0.3);
      const offsetEnd = Offset.zero;
      const fadeBegin = 0.0;
      const fadeEnd = 1.0;
      final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      final fadeTween =
          Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(offsetTween);
      final fadeAnimation = animation.drive(fadeTween);

      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(opacity: fadeAnimation, child: child),
      );
    },
  ));
}
