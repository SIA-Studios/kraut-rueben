import 'dart:ui';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kraut_rueben/models/ingredient.dart';

class IngredientsInputArrayPopup extends StatefulWidget {
  final String title;
  final List<Ingredient> allIngredients;
  final List<String> ingredientIds;
  final List<String> ingredientAmounts;
  final ValueChanged<Map<String, String>>? onConfirm;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const IngredientsInputArrayPopup(
      {Key? key,
      required this.ingredientIds,
      required this.ingredientAmounts,
      required this.title,
      required this.allIngredients,
      this.onConfirm,
      this.validator,
      this.inputFormatters})
      : super(key: key);

  @override
  State<IngredientsInputArrayPopup> createState() =>
      _IngredientsInputArrayPopupState();
}

List<String> selectedValues = [];

class _IngredientsInputArrayPopupState
    extends State<IngredientsInputArrayPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<InputArrayFormField> textFields = [];
  List<InputArrayDropdownButton> dropDownButtons = [];
  TextEditingController addItemController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String addSelectedValue = "";
  TextEditingController addTextEditingController =
      TextEditingController(text: "0");

  @override
  void initState() {
    List<String> allIngredientsNames = [];
    widget.allIngredients.forEach((element) {
      allIngredientsNames.add(element.name);
    });
    addSelectedValue = allIngredientsNames[0];

    if (widget.ingredientIds.isNotEmpty) {
      widget.ingredientIds.asMap().forEach((index, ingredientID) {
        selectedValues.add(widget.allIngredients
            .firstWhere((element) =>
                element.ingredientId.toString() ==
                widget.ingredientIds[index].toString())
            .name);
      });
      widget.ingredientAmounts.asMap().forEach((index, text) {
        TextEditingController textFieldController =
            TextEditingController(text: text);
        dropDownButtons.add(InputArrayDropdownButton(
          controller: textFieldController,
          selectedValue: selectedValues[index],
          allIngredientsNames: allIngredientsNames,
          index: index,
          onRemove: (i) {
            setState(() {
              int indexWhere =
                  dropDownButtons.indexWhere((element) => element.index == i);
              selectedValues.removeAt(indexWhere);
              dropDownButtons.removeAt(indexWhere);
              print(selectedValues.toList());
            });
          },
        ));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width * 0.6).clamp(0, 500);
    List<String> allIngredientsNames = [];
    widget.allIngredients.forEach((element) {
      allIngredientsNames.add(element.name);
    });

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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Text(
                                        widget.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 15),
                                      child: Column(
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxHeight: 260),
                                            child: SingleChildScrollView(
                                              controller: scrollController,
                                              child: Column(
                                                children: dropDownButtons,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: TextFormField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp(r'[0-9]'))
                                                    ],
                                                    maxLines: 1,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    controller:
                                                        addTextEditingController,
                                                    textAlign: TextAlign.left,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white
                                                          .withOpacity(0.3),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 12,
                                                              vertical: 7),
                                                    ),
                                                    style: TextStyle(
                                                      height: 1.5,
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    child:
                                                        CustomDropdownButton2(
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    border: Border.all(
                                                        width: 0,
                                                        style:
                                                            BorderStyle.none),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  buttonWidth: 270,
                                                  hint: "Select Item",
                                                  value: addSelectedValue,
                                                  dropdownItems:
                                                      allIngredientsNames,
                                                  onChanged: ((value) => {
                                                        if (!selectedValues
                                                            .contains(value!))
                                                          {
                                                            setState(
                                                              () {
                                                                addSelectedValue =
                                                                    value;
                                                              },
                                                            )
                                                          }
                                                      }),
                                                )),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectedValues.contains(
                                                              addSelectedValue) ||
                                                          addTextEditingController
                                                              .text.isEmpty ||
                                                          double.parse(
                                                                      addTextEditingController
                                                                          .text)
                                                                  .clamp(0,
                                                                      2147483647)
                                                                  .toInt() ==
                                                              0) {
                                                        return;
                                                      }
                                                      TextEditingController
                                                          textFieldController =
                                                          TextEditingController(
                                                              text: double.parse(
                                                                      addTextEditingController
                                                                          .text)
                                                                  .clamp(0,
                                                                      2147483647)
                                                                  .toInt()
                                                                  .toString());
                                                      selectedValues.add(
                                                          addSelectedValue);
                                                      dropDownButtons.add(
                                                          InputArrayDropdownButton(
                                                        controller:
                                                            textFieldController,
                                                        selectedValue:
                                                            addSelectedValue,
                                                        allIngredientsNames:
                                                            allIngredientsNames,
                                                        index: dropDownButtons
                                                            .length,
                                                        onRemove: (i) {
                                                          setState(() {
                                                            int indexWhere =
                                                                dropDownButtons.indexWhere(
                                                                    (element) =>
                                                                        element
                                                                            .index ==
                                                                        i);
                                                            selectedValues
                                                                .removeAt(
                                                                    indexWhere);
                                                            dropDownButtons
                                                                .removeAt(
                                                                    indexWhere);
                                                            print(selectedValues
                                                                .toList());
                                                          });
                                                        },
                                                      ));
                                                      addSelectedValue =
                                                          allIngredientsNames[
                                                              0];
                                                      addTextEditingController
                                                          .text = "0";
                                                    });
                                                    scrollController.animateTo(
                                                      scrollController.position
                                                              .maxScrollExtent +
                                                          50,
                                                      curve: Curves.easeOut,
                                                      duration: const Duration(
                                                          milliseconds: 250),
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(0.4),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              color: Colors.black.withOpacity(0.2),
                              height: 1,
                              width: width,
                            ),
                            SizedBox(
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
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        Map<String, String> outputList = {};
                                        for (InputArrayDropdownButton field
                                            in dropDownButtons) {
                                          Ingredient ingredient = widget
                                              .allIngredients
                                              .firstWhere((element) =>
                                                  element.name.toString() ==
                                                  field.selectedValue
                                                      .toString());
                                          int index =
                                              dropDownButtons.indexOf(field);
                                          outputList[ingredient.ingredientId
                                                  .toString()] =
                                              dropDownButtons[index]
                                                  .controller
                                                  .text;
                                        }
                                        widget.onConfirm?.call(outputList);
                                        selectedValues = [];
                                        Navigator.pop(context);
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

class InputArrayFormField extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final GlobalKey<FormState> formKey;
  final void Function(int) onRemove;

  const InputArrayFormField({
    required this.controller,
    required this.index,
    required this.validator,
    required this.inputFormatters,
    required this.formKey,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              validator: validator,
              inputFormatters: inputFormatters,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              textAlign: TextAlign.left,
              onChanged: (value) => formKey.currentState!.validate(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              ),
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          GestureDetector(
            onTap: () => onRemove.call(index),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white.withOpacity(0.4),
              child: const Icon(
                Icons.remove,
                color: Colors.black,
                size: 14,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}

class InputArrayDropdownButton extends StatefulWidget {
  String selectedValue;
  final List<String> allIngredientsNames;
  final int index;
  final void Function(int) onRemove;
  final TextEditingController controller;

  InputArrayDropdownButton(
      {super.key,
      required this.allIngredientsNames,
      required this.selectedValue,
      required this.index,
      required this.onRemove,
      required this.controller});

  @override
  State<InputArrayDropdownButton> createState() =>
      _InputArrayDropdownButtonState();
}

class _InputArrayDropdownButtonState extends State<InputArrayDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 150,
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              controller: widget.controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              ),
              style: TextStyle(
                height: 1.5,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: CustomDropdownButton2(
            buttonDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              border: Border.all(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(15),
            ),
            buttonWidth: 270,
            hint: "Select Item",
            value: widget.selectedValue,
            dropdownItems: widget.allIngredientsNames,
            onChanged: (value) {
              if (!selectedValues.contains(value!)) {
                selectedValues[widget.index] = value;
                this.widget.selectedValue = value;
              }
              setState(() {});
            },
          )),
          const SizedBox(
            width: 7,
          ),
          GestureDetector(
            onTap: () {
              widget.onRemove.call(widget.index);
            },
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white.withOpacity(0.4),
              child: const Icon(
                Icons.remove,
                color: Colors.black,
                size: 14,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
