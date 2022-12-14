import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputArrayPopup extends StatefulWidget {
  final String title;
  final List<String> initialValue;
  final ValueChanged<List<String>>? onConfirm;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const InputArrayPopup(
      {Key? key,
      required this.initialValue,
      required this.title,
      this.onConfirm,
      this.validator,
      this.inputFormatters})
      : super(key: key);

  @override
  State<InputArrayPopup> createState() => _InputArrayPopupState();
}

class _InputArrayPopupState extends State<InputArrayPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<InputArrayFormField> textFields = [];
  TextEditingController addItemController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    widget.initialValue.asMap().forEach((index, text) {
      TextEditingController textFieldController =
          TextEditingController(text: text);
      textFields.add(InputArrayFormField(
        controller: textFieldController,
        formKey: _formKey,
        index: index,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        onRemove: ((i) {
          setState(() {
            textFields.removeWhere((element) => element.index == i);
          });
        }),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                                children: textFields,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    validator: widget.validator,
                                                    inputFormatters:
                                                        widget.inputFormatters,
                                                    maxLines: 1,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    controller:
                                                        addItemController,
                                                    textAlign: TextAlign.left,
                                                    onChanged: (value) =>
                                                        _formKey.currentState!
                                                            .validate(),
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
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      textFields.add(
                                                          InputArrayFormField(
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    addItemController
                                                                        .value
                                                                        .text),
                                                        index:
                                                            textFields.length,
                                                        validator:
                                                            widget.validator,
                                                        inputFormatters: widget
                                                            .inputFormatters,
                                                        formKey: _formKey,
                                                        onRemove: ((index) {
                                                          setState(() {
                                                            textFields.removeWhere(
                                                                (element) =>
                                                                    element
                                                                        .index ==
                                                                    index);
                                                          });
                                                        }),
                                                      ));
                                                      addItemController.clear();
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
                                        List<String> outputList = [];
                                        for (var fields in textFields) {
                                          outputList.add(
                                              fields.controller.value.text);
                                        }
                                        widget.onConfirm?.call(outputList);
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
