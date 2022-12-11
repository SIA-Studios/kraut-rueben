import 'package:kraut_rueben/models/intolerance.dart';
import 'package:mysql1/mysql1.dart';

class Ingredient {
  final int ingredientId;
  final String name;
  final String unit;
  final double price;
  final int stock;
  final int supplier;
  final int calories;
  final double carboHydrates;
  final double protein;
  final List<Intolerance> intolerances;

  Ingredient(
      this.ingredientId,
      this.name,
      this.unit,
      this.price,
      this.stock,
      this.supplier,
      this.calories,
      this.carboHydrates,
      this.protein,
      this.intolerances);

  factory Ingredient.fromResultRow(ResultRow values, List<Intolerance> intolerances) {
    return Ingredient(
        values['ZUTATENNR'],
        values['BEZEICHNUNG'],
        values['EINHEIT'],
        values['NETTOPREIS'],
        values['BESTAND'],
        values['LIEFERANT'],
        values['KALORIEN'],
        values['KOHLENHYDRATE'],
        values['PROTEIN'], 
        intolerances);
  }
}
