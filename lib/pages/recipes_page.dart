import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/main.dart';
import 'package:kraut_rueben/models/ingredient.dart';
import 'package:kraut_rueben/pages/page.dart';
import 'package:kraut_rueben/utils/recipe_popup.dart';

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

  String selectedValue1 = 'recipeId';
  String selectedValue2 = 'content';

  @override
  String? get title => "Recipes";

  @override
  Future<Widget?> get content => createDataTable();

  void openRecipe(Recipe recipe) {
    navigatorKey.currentState?.push(PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) =>
            RecipePopup(recipe: recipe),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Cubic(0, 1, 0.5, 1);
          const offsetBegin = Offset(0.0, 1);
          const offsetEnd = Offset.zero;
          const fadeBegin = 0.0;
          const fadeEnd = 1.0;
          final offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
              .chain(CurveTween(curve: curve));
          final fadeTween = Tween(begin: fadeBegin, end: fadeEnd)
              .chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(offsetTween);
          //final fadeAnimation = animation.drive(fadeTween);

          return SlideTransition(
            position: offsetAnimation,
            //child: FadeTransition(opacity: fadeAnimation, child: child),
            child: child,
          );
        }));
  }

  Future<DataTable> createDataTable() async {
    List<DataRow> recipeRows = [];
    List<DataCell> titles = [];
    List<DataCell> contents = [];
    List<DataCell> recipeIds = [];
    List<DataCell> ingredients = [];
    List<Ingredient> allIngredients = [];

    await DatabaseManager.getRecipes().then((recipes) async {
      await DatabaseManager.getIngredients().then((ingreds) => allIngredients = ingreds,);
      recipes.asMap().forEach((index, recipe) {
        titles.add(DataCell(databaseTableEntry(
            content: [recipe.title],
            previewText: recipe.title,
            context: context,
            database: "REZEPT",
            primaryKey: recipe.recipeId,
            columnName: "TITEL",
            identifier: "REZEPTNR",
            setStateOnConfirm: () => setState(() {}),
            disableEditing: false,
            isArray: false)));
        contents.add(DataCell(databaseTableEntry(
            content: [recipe.content],
            previewText: recipe.content,
            context: context,
            database: "REZEPT",
            primaryKey: recipe.recipeId,
            columnName: "INHALT",
            identifier: "REZEPTNR",
            setStateOnConfirm: () => setState(() {}),
            disableEditing: false,
            isArray: false)));
        recipeIds.add(DataCell(databaseTableEntry(
            content: [recipe.recipeId.toString()],
            previewText: recipe.recipeId.toString(),
            context: context,
            database: "REZEPT",
            primaryKey: recipe.recipeId,
            columnName: "REZEPTNR",
            identifier: "REZEPTNR",
            setStateOnConfirm: () => setState(() {}),
            disableEditing: true,
            isArray: false,
            isInt: true)));

        List<String> ingrendientNames = [];
        List<String> ingredientAmounts = [];
        List<String> ingredientIds = [];
        recipe.ingredients.keys.forEach((element) {
          ingrendientNames.add(
              "${element.name} (${recipe.ingredients[element]} ${element.unit})");
          ingredientAmounts.add(recipe.ingredients[element].toString());
          ingredientIds.add(element.ingredientId.toString());
        });

        ingredients.add(DataCell(databaseTableEntry(
          allIngredients: allIngredients,
          content: ingredientIds,
          content2: ingredientAmounts,
          previewText: ingrendientNames.join(", "),
          context: context,
          database: "REZEPTZUTAT",
          primaryKey: recipe.recipeId,
          columnName: "ZUTATENNR",
          identifier: "REZEPTNR",
          setStateOnConfirm: () => setState(() {}),
          disableEditing: false,
          isArray: true,
        )));

        DataCell item1 = contents[index];
        DataCell item2 = contents[index];

        switch (selectedValue1) {
          case 'recipeId':
            item1 = recipeIds[index];
            break;
          case 'ingredients':
            item1 = ingredients[index];
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
            item2 = ingredients[index];
            break;
          case 'content':
            item2 = contents[index];
            break;
        }

        recipeRows.add(DataRow(cells: [
          DataCell(GestureDetector(
              onTap: () => openRecipe(recipe),
              child: Icon(
                Icons.open_in_new_outlined,
                size: 20,
              ))),
          titles[index],
          item1,
          item2
        ]));
      });
    });

    return DataTable(
      columns: [
        DataColumn(label: Container()),
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
