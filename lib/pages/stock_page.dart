import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/models/ingredient.dart';
import 'package:kraut_rueben/pages/page.dart';

import '../utils/table.dart';
import '../utils/transitions.dart';

class StockPage extends ContentPage {
  const StockPage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _StockPageState();
}

class _StockPageState extends ContentPageState {
  @override
  String? get title => "Stock";

  @override
  Future<Widget?> get content => contentWidget();

  Future<Widget> contentWidget() async {
    List<DataRow> ingredientRows = [];
    List<DataCell> names = [];
    List<DataCell> ids = [];
    List<DataCell> stocks = [];

    await DatabaseManager.getIngredients().then(
      (ingredients) {
        ingredients.asMap().forEach((index, ingredient) {
          ids.add(DataCell(databaseTableEntry(
              content: [ingredient.ingredientId.toString()],
              context: context,
              database: "ZUTAT",
              primaryKey: ingredient.ingredientId,
              columnName: "ZUTATENNR",
              identifier: "ZUTATENNR",
              setStateOnConfirm: () => setState(() {}),
              disableEditing: true,
              isArray: false,
              isInt: true)));
          stocks.add(DataCell(databaseTableEntry(
              content: [ingredient.stock.toString()],
              context: context,
              database: "ZUTAT",
              primaryKey: ingredient.ingredientId,
              columnName: "BESTAND",
              identifier: "ZUTATENNR",
              setStateOnConfirm: () => setState(() {}),
              disableEditing: false,
              isArray: false,
              isInt: true)));
          names.add(DataCell(databaseTableEntry(
              content: [ingredient.name],
              context: context,
              database: "ZUTAT",
              primaryKey: ingredient.ingredientId,
              columnName: "BEZEICHNUNG",
              identifier: "ZUTATENNR",
              setStateOnConfirm: () => setState(() {}),
              disableEditing: false,
              isArray: false)));

          ingredientRows
              .add(DataRow(cells: [names[index], ids[index], stocks[index]]));
        });
      },
    );

    return DataTable(
      columns: [
        const DataColumn(label: Text("title")),
        const DataColumn(label: Text("id")),
        DataColumn(label: Text("stock")),
      ],
      rows: ingredientRows,
    );
  }
}
