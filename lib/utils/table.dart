import 'package:flutter/material.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/utils/transitions.dart';

Widget databaseTableEntry(
    String text,
    BuildContext context,
    String database,
    int recipeId,
    String columnName,
    void Function() setStateOnConfirm,
    bool disableEditing) {
  return GestureDetector(
    onTap: () {
      if (disableEditing) return;
      showInputPopup(
        title: database,
        initialValue: text,
        onConfirm: (value) {
          DatabaseManager.setField(database, "REZEPTNR", recipeId.toString(),
              value.runtimeType == int ? value : "\"$value\"", columnName);
          setStateOnConfirm();
        },
      );
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!disableEditing)
          Icon(
            Icons.edit,
            color: Colors.black.withOpacity(0.6),
            size: 15,
          ),
        if (!disableEditing)
          const SizedBox(
            width: 10,
          ),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ],
    ),
  );
}
