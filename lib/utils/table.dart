import 'package:flutter/material.dart';
import 'package:kraut_rueben/utils/transitions.dart';

Widget databaseTableEntry(String text, BuildContext context) {
  return GestureDetector(
    onTap: () {
      showInputPopup(title: "test", initialValue: text);
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          Icons.edit,
          color: Colors.black.withOpacity(0.6),
          size: 15,
        ),
      ],
    ),
  );
}