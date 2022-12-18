import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/pages/page.dart';

class QueryPage extends ContentPage {
  const QueryPage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _QueryPageState();
}

class _QueryPageState extends ContentPageState {
  @override
  String? get title => "Query";

  @override
  Future<Widget?> get content => contentWidget();

  String errorMessage = "";
  List<DataColumn> columns = [];
  List<DataRow> rows = [];
  bool hasResult = false;

  TextEditingController queryFieldController = TextEditingController();

  Future<void> _executeStatement(String statement) async {
    String query = queryFieldController.text;
    setState(() {
      hasResult = false;
      errorMessage = "";
    });
    columns = [];
    rows = [];
    final result = await DatabaseManager.executeSQLStatement(statement);
    if (result is Exception) {
      return setState(() {
        errorMessage = result.toString();
      });
    }
    if (result == null) return;

    result.fields.forEach((field) => {
          columns.add(DataColumn(label: Text(field.orgName!))),
          debugPrint(field.orgName)
        });
    result.forEach((result) {
      List<DataCell> cells = [];
      result.fields.values.forEach((element) {
        cells.add(DataCell(Text(element.toString())));
      });
      rows.add(DataRow(cells: cells));
    });
    setState(() {
      hasResult = true;
    });
    queryFieldController.text = query;
  }

  Future<Widget> contentWidget() async {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: queryFieldController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.none,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Query",
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (queryFieldController.text != "") {
                  _executeStatement(queryFieldController.text);
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        if (hasResult) DataTable(columns: columns, rows: rows),
        if (errorMessage != "")
          Center(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                )),
          ),
      ],
    );
  }
}
