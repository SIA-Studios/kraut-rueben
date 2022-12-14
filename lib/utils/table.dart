import 'package:flutter/material.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/models/ingredient.dart';
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
    required String previewText,
    final TextInputType? textInputType,
    List<Ingredient>? allIngredients,
    bool? isInt,
    bool? isDouble,
    List<String>? content2}) {
  return GestureDetector(
    onTap: () {
      if (disableEditing) return;
      if (isArray) {
        if (content2 != null && allIngredients != null) {
          showIngredientsInputArrayPopup(
            title: database,
            allIngredients: allIngredients,
            initialValue: content,
            initialValue2: content2,
            onConfirm: (value) async {
              await DatabaseManager.setIngredientsForRecipe(
                  value, primaryKey.toString());
              setStateOnConfirm();
            },
          );
        } else {
          showInputArrayPopup(
            title: database,
            initialValue: content,
            onConfirm: (value) {},
          );
        }
      } else {
        showInputPopup(
          title: database,
          isDouble: isDouble,
          isInt: isInt,
          textInputType: textInputType,
          initialValue: content[0],
          onConfirm: (value) async {
            await DatabaseManager.setField(
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
            previewText,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ],
    ),
  );
}
