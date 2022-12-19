import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kraut_rueben/models/category.dart';
import 'package:kraut_rueben/models/customer.dart';
import 'package:kraut_rueben/models/ingredient.dart';
import 'package:kraut_rueben/models/intolerance.dart';
import 'package:kraut_rueben/models/order.dart';
import 'package:kraut_rueben/models/recipe.dart';
import 'package:kraut_rueben/models/supplier.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseManager {
  static MySqlConnection? connection;
  static ValueNotifier<bool> isConnected = ValueNotifier(false);

  static final Map<int, Ingredient> _ingredientCache = {};
  static final Map<int, Intolerance> _intoleranceCache = {};
  static final Map<int, Category> _categoryCache = {};

  static Future<ConnectionStatus> connectToDatabase(
      String user, String password,
      [String? ipAddress]) async {
    final settings = ConnectionSettings(
        host: ipAddress ?? '130.162.243.109',
        port: 3306,
        user: user,
        password: password,
        db: 'krautundrueben');

    try {
      connection = await MySqlConnection.connect(settings);
      isConnected.value = true;
      return ConnectionStatus.success;
    } on SocketException catch (e) {
      debugPrint(e.message);
    } on Exception catch (_) {
      return ConnectionStatus.loginFailure;
    }
    return ConnectionStatus.error;
  }

  static Future<bool> closeConnection() async {
    if (connection == null) return false;
    await connection!.close();
    connection = null;
    isConnected.value = false;
    return true;
  }

  static Future<Customer?> getCustomer(int customerId) async {
    if (connection == null) return null;

    final result = await connection!
        .query("SELECT * FROM KUNDE WHERE KUNDENNR = ?", [customerId]);
    if (result.isEmpty) return null;

    return Customer.fromResultRow(result.first);
  }

  static Future<List<Customer>> getCustomers([List<int>? customerIds]) async {
    final List<Customer> customers = [];
    if (connection == null) return customers;

    if (customerIds != null) {
      final results = await connection!
          .queryMulti("SELECT * FROM KUNDE WHERE KUNDENNR = ?", [customerIds]);
      for (final customerResult in results) {
        customers.add(Customer.fromResultRow(customerResult.first));
      }
      return customers;
    }
    final results = await connection!.query("SELECT * FROM KUNDE");
    for (final customerRow in results) {
      customers.add(Customer.fromResultRow(customerRow));
    }
    return customers;
  }

  static Future<List<Ingredient>> getIngredients() async {
    final List<Ingredient> ingredients = [];
    if (connection == null) return ingredients;

    final results = await connection!.query("SELECT * FROM ZUTAT");
    for (final result in results) {
      ingredients.add(Ingredient.fromResultRow(
          result, await _getIntolerancesByIngredient(result["ZUTATENNR"])));
    }
    return ingredients;
  }

  static Future<List<Supplier>> getSuppliers() async {
    final List<Supplier> suppliers = [];
    if (connection == null) return suppliers;

    final results = await connection!.query("SELECT * FROM LIEFERANT");
    for (final result in results) {
      suppliers.add(Supplier.fromResultRow(result));
    }
    return suppliers;
  }

  static Future<Intolerance?> getIntolerance(int intoleranceId) async {
    if (_intoleranceCache.containsKey(intoleranceId)) {
      return _intoleranceCache[intoleranceId];
    }
    if (connection == null) return null;

    final result = await connection!.query(
        "SELECT * FROM UNVERTRAEGLICHKEIT WHERE UNVERNR	= ?", [intoleranceId]);
    if (result.isEmpty) return null;

    final intolerance = Intolerance.fromResultRow(result.first);
    _intoleranceCache[intoleranceId] = intolerance;

    return intolerance;
  }

  static Future<List<Intolerance>> _getIntolerancesByIngredient(
      int ingredientId) async {
    final List<Intolerance> intolerances = [];
    if (connection == null) return intolerances;

    final results = await connection!.query(
        "SELECT UNVERNR FROM ZUTATUNVERTRAEGLICHKEIT WHERE ZUTATENNR	= ?",
        [ingredientId]);
    for (final result in results) {
      final int intoleranceId = result['UNVERNR'];
      final intolerance = await getIntolerance(intoleranceId);

      if (intolerance == null) continue;
      intolerances.add(intolerance);
    }
    return intolerances;
  }

  static Future<Ingredient?> getIngredient(int ingredientId) async {
    if (_ingredientCache.containsKey(ingredientId)) {
      return _ingredientCache[ingredientId];
    }

    if (connection == null) return null;

    final result = await connection!
        .query("SELECT * FROM ZUTAT WHERE ZUTATENNR = ?", [ingredientId]);
    if (result.isEmpty) return null;

    final intolerances = await _getIntolerancesByIngredient(ingredientId);
    final ingredient = Ingredient.fromResultRow(result.first, intolerances);
    _ingredientCache[ingredientId] = ingredient;

    return ingredient;
  }

  static Future<Map<Ingredient, int>> _getIngredientsByRecipe(
      int recipeId) async {
    final Map<Ingredient, int> ingredients = {};
    if (connection == null) return ingredients;

    final results = await connection!.query(
        "SELECT ZUTATENNR, MENGE FROM REZEPTZUTAT WHERE REZEPTNR	= ?",
        [recipeId]);
    for (final result in results) {
      final ingredientId = result['ZUTATENNR'];
      final amount = result['MENGE'];
      final ingredient = await getIngredient(ingredientId);

      if (ingredient == null) continue;
      ingredients[ingredient] = amount;
    }

    return ingredients;
  }

  static Future<List<Recipe>> getRecipes(
      [List<int>? recipesIds,
      List<int>? intolerances,
      List<int>? categories,
      String? where]) async {
    final List<Recipe> recipes = [];
    if (connection == null) return recipes;

    if (recipesIds != null) {
      final results = await connection!
          .queryMulti("SELECT * FROM REZEPT WHERE REZEPTNR = ?", [recipesIds]);

      for (final result in results) {
        final resultRow = result.first;
        recipes.add(Recipe.fromResultRow(
            resultRow, await _getIngredientsByRecipe(resultRow["REZEPTNR"])));
      }
      return recipes;
    }
    if (intolerances != null && categories != null) {
      final results = await connection!.query(
          "SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT, REZEPTKATEGORIE, KATEGORIE WHERE (REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr AND UNVERTRAEGLICHKEIT.unvernr = ?) AND (REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = ?)",
          [intolerances.first, categories.first]);
      for (final result in results) {
        recipes.add(Recipe.fromResultRow(
            result, await _getIngredientsByRecipe(result["REZEPTNR"])));
      }
      return recipes;
    }
    if (intolerances != null) {
      final results = await connection!.query(
          "SELECT DISTINCT REZEPT.titel, REZEPT.inhalt FROM REZEPT, REZEPTZUTAT, ZUTATUNVERTRAEGLICHKEIT, UNVERTRAEGLICHKEIT WHERE REZEPT.rezeptnr = REZEPTZUTAT.rezeptnr AND REZEPTZUTAT.zutatennr = ZUTATUNVERTRAEGLICHKEIT.zutatennr AND ZUTATUNVERTRAEGLICHKEIT.unvernr != UNVERTRAEGLICHKEIT.unvernr AND UNVERTRAEGLICHKEIT.unvernr = ?",
          [intolerances.first]);
      for (final result in results) {
        recipes.add(Recipe.fromResultRow(
            result, await _getIngredientsByRecipe(result["REZEPTNR"])));
      }
      return recipes;
    }
    if (categories != null) {
      final results = await connection!.query(
          "SELECT DISTINCT REZEPT.titel, REZEPT.inhalt, KATEGORIE.name FROM REZEPT, REZEPTKATEGORIE, KATEGORIE WHERE REZEPT.rezeptnr = REZEPTKATEGORIE.rezeptnr AND REZEPTKATEGORIE.kategorienr = KATEGORIE.kategorienr AND KATEGORIE.kategorienr = ?",
          [categories.first]);
      for (final result in results) {
        recipes.add(Recipe.fromResultRow(
            result, await _getIngredientsByRecipe(result["REZEPTNR"])));
      }
      return recipes;
    }
    final results = await connection!.query("SELECT * FROM REZEPT");
    for (final result in results) {
      recipes.add(Recipe.fromResultRow(
          result, await _getIngredientsByRecipe(result["REZEPTNR"])));
    }
    return recipes;
  }

  static Future<void> setField(String database, String identifier,
      String identifierValue, String newValue, String columnName) async {
    await connection!.query(
        "UPDATE $database SET $columnName = $newValue WHERE $identifier = $identifierValue");
  }

  static Future<void> addIngredient(name, unit, price, stock, supplierId,
      calories, carbohydrates, protein) async {
    int ingredientId = Random().nextInt(100001);
    await connection!.query(
        "INSERT INTO ZUTAT(ZUTATENNR, BEZEICHNUNG, EINHEIT, NETTOPREIS, BESTAND, LIEFERANT, KALORIEN, KOHLENHYDRATE, PROTEIN) VALUES (?,?,?,?,?,?,?,?,?)",
        [
          ingredientId.toString(),
          name,
          unit,
          price,
          stock,
          supplierId,
          calories,
          carbohydrates,
          protein
        ]);
  }

  static Future<void> setIngredientsForRecipe(
      Map<String, String> ingredient, String recipeId) async {
    if (connection == null) return;
    await connection!
        .query("DELETE FROM REZEPTZUTAT WHERE REZEPTNR = ?", [recipeId]);
    ingredient.forEach((ingredientId, amount) async {
      await connection!.query(
          "INSERT INTO REZEPTZUTAT(REZEPTNR, ZUTATENNR, MENGE) VALUES (?,?,?)",
          [recipeId, ingredientId, amount]);
    });
  }

  static Future<dynamic?> executeSQLStatement(String statement) async {
    if (connection == null) return null;

    try {
      return await connection!.query(statement);
    } on Exception catch (error) {
      return Exception(error);
    }
  }

  static Future<void> insertRecipe(Recipe recipe) async {
    if (connection == null) return;

    await connection!.query("INSERT INTO REZEPT(TITEL, INHALT) VALUES (?,?)",
        [recipe.recipeId, recipe.title, recipe.content]);

    for (int i = 0; i < recipe.ingredients.length; i++) {
      final ingredient = recipe.ingredients.keys.toList()[i];
      final amount = recipe.ingredients.values.toList()[i];

      await connection!.query(
          "INSERT INTO REZEPTZUTAT(REZEPTNR, ZUTATENNR, MENGE) VALUES (?,?,?)",
          [recipe.recipeId, ingredient.ingredientId, amount]);
    }
  }

  static Future<Order?> getOrderById(int orderId) async {
    if (connection == null) return null;

    final result = await connection!
        .query("SELECT * FROM BESTELLUNG WHERE BESTELLNR = ? ", [orderId]);
    return Order.fromResultRow(result.first);
  }

  static Future<List<Order>> getOrders() async {
    final List<Order> orders = [];
    if (connection == null) return orders;

    final result = await connection!.query("SELECT * FROM BESTELLUNG");
    for (final resultRow in result) {
      orders.add(Order.fromResultRow(resultRow));
    }

    return orders;
  }

  static Future<void> deleteRecipe(Recipe recipe) async {
    if (connection == null) return;

    await connection!.query(
        "DELETE * FROM REZEPTZUTAT WHERE REZEPTNR = ?", [recipe.recipeId]);

    await connection!.query(
        "DELETE * FROM REZEPTZUTAT WHERE REZEPTNR = ?", [recipe.recipeId]);
  }
}

enum ConnectionStatus {
  success,

  loginFailure,

  error
}
