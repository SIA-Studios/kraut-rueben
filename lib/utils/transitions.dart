import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/models/ingredient.dart';
import 'package:kraut_rueben/utils/add_ingredient_popup.dart';
import 'package:kraut_rueben/utils/ingredients_input_array_popup.dart';

import '../models/supplier.dart';
import 'input_array_popup.dart';
import 'input_popup.dart';
import 'login_popup.dart';
import 'package:kraut_rueben/main.dart';

void showInputPopup({
  required String title,
  required String initialValue,
  TextInputType? textInputType,
  bool? isInt,
  bool? isDouble,
  ValueChanged<String>? onConfirm,
  Widget? customSymbol,
}) {
  navigatorKey.currentState?.push(PageRouteBuilder(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => InputPopup(
      title: title,
      initialValue: initialValue,
      textInputType: textInputType,
      onConfirm: (value) {
        if (isInt ?? false) {
          onConfirm?.call(
              double.parse(value).clamp(0, 2147483647).toInt().toString());
        } else {
          onConfirm?.call(value);
        }
      },
      inputFormatters: [
        (isInt ?? false)
            ? FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
            : (isDouble ?? false)
                ? FilteringTextInputFormatter.deny(RegExp(r'[0-9,]'))
                : FilteringTextInputFormatter.deny(RegExp(r'[]'))
      ],
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Cubic(0, 1, 0.5, 1);
      const offsetBegin = Offset(0.0, 1);
      const offsetEnd = Offset.zero;
      const fadeBegin = 0.0;
      const fadeEnd = 1.0;
      final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      final fadeTween =
          Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(offsetTween);
      //final fadeAnimation = animation.drive(fadeTween);

      return SlideTransition(
          position: offsetAnimation,
          //child: FadeTransition(opacity: fadeAnimation, child: child),
          child: child);
    },
  ));
}

void showAddIngredientPopup({required List<Supplier> allSuppliers}) {
  navigatorKey.currentState?.push(PageRouteBuilder(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => AddIngredientPopup(
      allSuppliers: allSuppliers,
      onConfirm: (name, unit, price, stock, supplierId, calories, carbohydrates,
              protein) =>
          {
        DatabaseManager.addIngredient(name, unit, price, stock, supplierId,
            calories, carbohydrates, protein)
      },
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Cubic(0, 1, 0.5, 1);
      const offsetBegin = Offset(0.0, 1);
      const offsetEnd = Offset.zero;
      const fadeBegin = 0.0;
      const fadeEnd = 1.0;
      final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      final fadeTween =
          Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(offsetTween);
      //final fadeAnimation = animation.drive(fadeTween);

      return SlideTransition(
          position: offsetAnimation,
          //child: FadeTransition(opacity: fadeAnimation, child: child),
          child: child);
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
  navigatorKey.currentState?.push(PageRouteBuilder(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => InputArrayPopup(
      title: title,
      initialValue: initialValue,
      onConfirm: onConfirm,
      validator: validator,
      inputFormatters: inputFormatters,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Cubic(0, 1, 0.5, 1);
      const offsetBegin = Offset(0.0, 1);
      const offsetEnd = Offset.zero;
      const fadeBegin = 0.0;
      const fadeEnd = 1.0;
      final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      final fadeTween =
          Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(offsetTween);
      //final fadeAnimation = animation.drive(fadeTween);

      return SlideTransition(
          position: offsetAnimation,
          //child: FadeTransition(opacity: fadeAnimation, child: child),
          child: child);
    },
  ));
}

void showIngredientsInputArrayPopup(
    {required String title,
    required List<String> initialValue,
    required List<String> initialValue2,
    required List<Ingredient> allIngredients,
    ValueChanged<Map<String, String>>? onConfirm,
    String? Function(String?)? validator,
    Widget? customSymbol,
    List<TextInputFormatter>? inputFormatters}) {
  navigatorKey.currentState?.push(PageRouteBuilder(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) =>
        IngredientsInputArrayPopup(
      title: title,
      allIngredients: allIngredients,
      ingredientIds: initialValue,
      ingredientAmounts: initialValue2,
      onConfirm: onConfirm,
      validator: validator,
      inputFormatters: inputFormatters,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Cubic(0, 1, 0.5, 1);
      const offsetBegin = Offset(0.0, 1);
      const offsetEnd = Offset.zero;
      const fadeBegin = 0.0;
      const fadeEnd = 1.0;
      final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      final fadeTween =
          Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(offsetTween);
      //final fadeAnimation = animation.drive(fadeTween);

      return SlideTransition(
          position: offsetAnimation,
          //child: FadeTransition(opacity: fadeAnimation, child: child),
          child: child);
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

Future<ConnectionStatus> showLoginPopup() async {
  ConnectionStatus? status;
  print("open login popup");
  await navigatorKey.currentState?.push(PageRouteBuilder(
    barrierDismissible: false,
    opaque: false,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) =>
        LoginPopup(onConfirm: (value) {
      status = value;
    }),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Cubic(0, 1, 0.5, 1);
      const offsetBegin = Offset(0.0, 1);
      const offsetEnd = Offset.zero;
      const fadeBegin = 0.0;
      const fadeEnd = 1.0;
      final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: curve));
      final fadeTween =
          Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(offsetTween);
      //final fadeAnimation = animation.drive(fadeTween);

      return SlideTransition(
          position: offsetAnimation,
          //child: FadeTransition(opacity: fadeAnimation, child: child),
          child: child);
    },
  ));
  return status!;
}
