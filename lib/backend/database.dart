import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kraut_rueben/models/category.dart';
import 'package:kraut_rueben/models/customer.dart';
import 'package:kraut_rueben/models/ingredient.dart';
import 'package:kraut_rueben/models/intolerance.dart';
import 'package:kraut_rueben/models/recipe.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseManager {
  static MySqlConnection? _connection;

  static final Map<int, Ingredient> _ingredientCache = {};
  static final Map<int, Intolerance> _intoleranceCache = {};
  static final Map<int, Category> _categoryCache = {};

  static Future<ConnectionStatus> connectToDatabase(
      String user, String password) async {
    final settings = ConnectionSettings(
        host: '130.162.243.109',
        port: 3306,
        user: user,
        password: password,
        db: 'krautundrueben');

    try {
      _connection = await MySqlConnection.connect(settings);
      return ConnectionStatus.success;
    } on SocketException catch (e) {
      debugPrint(e.message);
    } on Exception catch (_) {
      return ConnectionStatus.loginFailure;
    }
    return ConnectionStatus.error;
  }

  static Future<void> closeConnection() async {
    if (_connection == null) return;
    await _connection!.close();
  }

  static Future<Customer?> getCustomer(int customerId) async {
    if (_connection == null) return null;

    final result = await _connection!
        .query("SELECT * FROM KUNDE WHERE KUNDENNR = ?", [customerId]);
    if (result.isEmpty) return null;

    return Customer.fromResultRow(result.first);
  }

  static Future<List<Customer>> getCustomers([List<int>? customerIds]) async {
    final List<Customer> customers = [];
    if (_connection == null) return customers;

    if (customerIds != null) {
      final results = await _connection!
          .queryMulti("SELECT * FROM KUNDE WHERE KUNDENNR = ?", [customerIds]);
      for (final customerResult in results) {
        customers.add(Customer.fromResultRow(customerResult.first));
      }
      return customers;
    }
    final results = await _connection!.query("SELECT * FROM KUNDE");
    for (final customerRow in results) {
      customers.add(Customer.fromResultRow(customerRow));
    }
    return customers;
  }

  static Future<Intolerance?> getIntolerance(int intoleranceId) async {
    if (_intoleranceCache.containsKey(intoleranceId)) {
      return _intoleranceCache[intoleranceId];
    }
    if (_connection == null) return null;

    final result = await _connection!.query(
        "SELECT * FROM UNVERTRAEGLICHKEIT WHERE UNVERID	= ?", [intoleranceId]);
    if (result.isEmpty) return null;

    final intolerance = Intolerance.fromResultRow(result.first);
    _intoleranceCache[intoleranceId] = intolerance;

    return intolerance;
  }

  static Future<List<Intolerance>> _getIntolerancesByIngeredient(
      int ingredientId) async {
    final List<Intolerance> intolerances = [];
    if (_connection == null) return intolerances;

    final results = await _connection!.query(
        "SELECT UNVERID FROM UNVERTRAEGLICHKEITZUTAT WHERE ZUTATENNR	= ?",
        [ingredientId]);
    for (final result in results) {
      final int intoleranceId = result['UNVERID'];
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

    if (_connection == null) return null;

    final result = await _connection!
        .query("SELECT * FROM ZUTAT WHERE ZUTATENNR = ?", [ingredientId]);
    if (result.isEmpty) return null;

    final intolerances = await _getIntolerancesByIngeredient(ingredientId);
    final ingredient = Ingredient.fromResultRow(result.first, intolerances);
    _ingredientCache[ingredientId] = ingredient;

    return ingredient;
  }

  static Future<Map<Ingredient, int>> _getIngredientsByRecipe(
      int recipeId) async {
    final Map<Ingredient, int> ingredients = {};
    if (_connection == null) return ingredients;

    final results = await _connection!.query(
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
      List<int>? categories]) async {
    final List<Recipe> recipes = [];
    if (_connection == null) return recipes;

    if (recipesIds != null) {
      final results = await _connection!
          .queryMulti("SELECT * FROM REZEPT WHERE REZEPTNR = ?", [recipesIds]);

      for (final result in results) {
        final resultRow = result.first;
      }
      return recipes;
    }

    final results = await _connection!.query("SELECT * FROM REZEPT");
    for (final resultRow in results) {
      if (intolerances != null) {}

      recipes.add(Recipe.fromResultRow(resultRow));
    }

    return recipes;
  }

  static _checkInterlorenace(int interlorenceId, int recipeId) {}
}

enum ConnectionStatus {
  success,

  loginFailure,

  error
}
