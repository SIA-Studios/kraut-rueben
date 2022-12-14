import 'package:kraut_rueben/models/ingredient.dart';
import 'package:mysql1/mysql1.dart';

class Recipe {
  final int recipeId;
  final String title;
  final String content;
  //final Map<Ingredient, int> ingredients;

  Recipe(this.recipeId, this.title, this.content);

  factory Recipe.fromResultRow(ResultRow values) {
    return Recipe(values["REZEPTNR"], values['TITEL'], values['INHALT'].toString());
  }
}
