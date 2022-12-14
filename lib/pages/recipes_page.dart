import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/models/ingredient.dart';
import 'package:kraut_rueben/pages/page.dart';

import '../models/recipe.dart';
import '../utils/table.dart';

class RecipesPage extends ContentPage {
  const RecipesPage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends ContentPageState {
  final List<String> dropdownItems = [
    'recipeId',
    'ingredients',
    'content',
  ];

  String selectedValue1 = 'ingredients';
  String selectedValue2 = 'content';

  @override
  String? get title => "Recipes";

  @override
  Future<Widget?> get content => createDataTable();

  Future<DataTable> createDataTable() async {
    List<DataRow> recipeRows = [];
    List<DataCell> titles = [];
    List<DataCell> contents = [];
    List<DataCell> recipeIds = [];

    var x = await DatabaseManager.getRecipes().then((recipes) {
      recipes.asMap().forEach((index, recipe) {
        titles.add(DataCell(databaseTableEntry(
            recipe.title, context, "REZEPT", recipe.recipeId, "TITEL", () => setState(() {}), false)));
        contents.add(DataCell(databaseTableEntry(
            recipe.content, context, "REZEPT", recipe.recipeId, "INHALT", () => setState(() {}), false)));
        recipeIds.add(DataCell(databaseTableEntry(recipe.recipeId.toString(),
            context, "REZEPT", recipe.recipeId, "REZEPTNR", () => setState(() {}), true)));

        DataCell item1 = contents[index];
        DataCell item2 = contents[index];

        switch (selectedValue1) {
          case 'recipeId':
            item1 = recipeIds[index];
            break;
          case 'ingredients':
            item1 = contents[index];
            break;
          case 'content':
            item1 = contents[index];
            break;
        }

        switch (selectedValue2) {
          case 'recipeId':
            item2 = recipeIds[index];
            break;
          case 'ingredients':
            item2 = contents[index];
            break;
          case 'content':
            item2 = contents[index];
            break;
        }

        recipeRows.add(DataRow(cells: [titles[index], item1, item2]));
      });
    });

    return DataTable(
      columns: [
        const DataColumn(label: Text("title")),
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
      rows: recipeRows,
    );
  }
}
