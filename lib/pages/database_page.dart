import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/pages/page.dart';
import 'package:kraut_rueben/utils/transitions.dart';

import '../utils/table.dart';

class DatabasePage extends ContentPage {
  const DatabasePage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _DatabasePageState();
}

class _DatabasePageState extends ContentPageState {
  final List<String> dropdownItems = [
    'id',
    'ingredients',
    'allergens',
    'price',
    'weight',
  ];

  String selectedValue1 = 'id';
  String selectedValue2 = 'ingredients';

  @override
  String? get title => "Database";

  @override
  Widget? get content => DataTable(
        columns: [
          DataColumn(label: GestureDetector(
            onTap: () => showLoginPopup(),
            child: Text("title")
            )),
          DataColumn(
              label: CustomDropdownButton2(
            key: const Key("dropdownButton1"),
            buttonDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: Colors.black,
            ),
            dropdownHeight: 5000,
            hint: 'Select Item',
            dropdownItems: dropdownItems,
            value: selectedValue1,
            onChanged: (value) {
              setState(() {
                selectedValue1 = value!;
              });
            },
          )),
          DataColumn(
              label: CustomDropdownButton2(
            key: const Key("dropdownButton2"),
            buttonDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: Colors.black,
            ),
            dropdownHeight: 5000,
            hint: 'Select Item',
            dropdownItems: dropdownItems,
            value: selectedValue2,
            onChanged: (value) {
              setState(() {
                selectedValue2 = value!;
              });
            },
          )),
        ],
        rows: [
          DataRow(cells: [
            DataCell(databaseTableEntry("test1", context)),
            DataCell(databaseTableEntry("2354752895723895", context)),
            DataCell(databaseTableEntry(
                "Milk, Eggs, Pork, Whatever, dkjhfgsd fsd, sdlkfjghsdf, sdlfjkhgsdfkjhsdf, sdkljfhgsdkjfhgsdf,sdfgsdjkhds, sdljhfgdsfjhgsdf, sdljfhgsdf",
                context)),
          ]),
          DataRow(cells: [
            DataCell(databaseTableEntry("test2", context)),
            DataCell(databaseTableEntry("2375627523", context)),
            DataCell(databaseTableEntry(
                "Cream, Eggs, Strawberries, Whatever", context)),
          ])
        ],
      );
}