import 'package:flutter/material.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/utils/transitions.dart';

Widget databaseTableEntry(
    {required List<String> content,
    required BuildContext context,
    required String database,
    required int primaryKey,
    required String columnName,
    required String identifier,
    required void Function() setStateOnConfirm,
    required bool disableEditing,
    required bool isArray,
    bool? isInt,
    bool? isDouble
    }) {
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
          isDouble: isDouble,
          isInt: isInt,
          initialValue: content[0],
          onConfirm: (value) {
            DatabaseManager.setField(
                database,
                identifier,
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
