import 'dart:ui';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/models/supplier.dart';

class AddIngredientPopup extends StatefulWidget {
  List<Supplier> allSuppliers;

  final void Function(
      String name,
      String unit,
      String price,
      String stock,
      String supplierId,
      String calories,
      String carbohydrates,
      String protein)? onConfirm;
  AddIngredientPopup({
    required this.allSuppliers,
    Key? key,
    this.onConfirm,
  }) : super(key: key);

  @override
  State<AddIngredientPopup> createState() => _AddIngredientPopupState();
}

class _AddIngredientPopupState extends State<AddIngredientPopup> {
  List<String> allSuppliersNames = [];
  String? selectedSupplier;

  @override
  void initState() {
    widget.allSuppliers.forEach((element) {
      allSuppliersNames.add(element.supplierName);
    });
    selectedSupplier = allSuppliersNames[0];
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTextController = TextEditingController();
    TextEditingController unitTextController = TextEditingController();
    TextEditingController priceTextController = TextEditingController();
    TextEditingController stockTextController = TextEditingController();
    TextEditingController caloriesTextController = TextEditingController();
    TextEditingController carbohydratesTextController = TextEditingController();
    TextEditingController proteinTextController = TextEditingController();

    double width = 300;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned.fill(
              child: UnconstrainedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                                width: width,
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Add Ingredient",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text("Supplier:"),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomDropdownButton2(
                                      buttonDecoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        border: Border.all(
                                            width: 0, style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      buttonWidth: 270,
                                      hint: "Select Item",
                                      value: selectedSupplier,
                                      dropdownItems: allSuppliersNames,
                                      onChanged: ((value) => {
                                            setState(
                                              () {
                                                selectedSupplier = value;
                                              },
                                            )
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: nameTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: unitTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Unit",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: priceTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Price",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: stockTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Stock",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: caloriesTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Calories",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: carbohydratesTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Carbohydrates",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: proteinTextController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Protein",
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              color: Colors.black.withOpacity(0.2),
                              height: 1,
                              width: width,
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: width / 2,
                                    child: MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      splashColor: Colors.transparent,
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  SizedBox(
                                    width: width / 2,
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (nameTextController.text != "" &&
                                            unitTextController.text != "" &&
                                            unitTextController.text != "" &&
                                            priceTextController.text != "" &&
                                            stockTextController.text != "" &&
                                            caloriesTextController.text != "" &&
                                            carbohydratesTextController.text !=
                                                "" &&
                                            proteinTextController.text != "") {
                                          widget.onConfirm?.call(
                                              nameTextController.text,
                                              unitTextController.text,
                                              priceTextController.text,
                                              stockTextController.text,
                                              "101",
                                              caloriesTextController.text,
                                              carbohydratesTextController.text,
                                              proteinTextController.text);
                                          Navigator.pop(context);
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
