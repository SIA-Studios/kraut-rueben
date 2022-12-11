import 'package:kraut_rueben/models/ingredient.dart';
import 'package:mysql1/mysql1.dart';

class Recipe {
  final int recipeId;
  final String title;
  final String content;
  final Map<Ingredient, int> ingredients;

  Recipe(this.recipeId, this.title, this.content, this.ingredients);

  factory Recipe.fromResultRow(ResultRow values, Map<Ingredient, int> ingredients) {
    return Recipe(values['REZEPTNR'], values['TITLE'], values['TEXT'], ingredients);
  }
}
