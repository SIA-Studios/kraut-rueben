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
  String? get title => "Categories";

  @override
  Future<Widget?> get content => contentWidget();

  Future<Widget> contentWidget() async {
    TextEditingController queryFieldController = TextEditingController();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: queryFieldController,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
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
                  DatabaseManager.executeSQLStatement(
                      queryFieldController.text);
                  queryFieldController.text = "";
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
        )
      ],
    );
  }
}
