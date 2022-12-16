import 'package:flutter/material.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/utils/transitions.dart';

Widget databaseTableEntry(
    List<String> content,
    BuildContext context,
    String database,
    int primaryKey,
    String columnName,
    void Function() setStateOnConfirm,
    bool disableEditing,
    bool isArray) {
  return GestureDetector(
    onTap: () {
      if (disableEditing) return;
      if (isArray) {
        showInputArrayPopup(
          title: database,
          initialValue: content,
          onConfirm: (value) {
            /*DatabaseManager.setField(database, "REZEPTNR", primaryKey.toString(),
              value.runtimeType == int ? value : "\"$value\"", columnName);
          setStateOnConfirm();*/
          },
        );
      } else {
        showInputPopup(
          title: database,
          initialValue: content[0],
          onConfirm: (value) {
            DatabaseManager.setField(
                database,
                "REZEPTNR",
                primaryKey.toString(),
                value.runtimeType == int ? value : "\"$value\"",
                columnName);
            setStateOnConfirm();
          },
        );
      }
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
            content.join(", "),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ],
    ),
  );
}
