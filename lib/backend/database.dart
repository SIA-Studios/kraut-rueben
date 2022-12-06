import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseManager {
  static MySqlConnection? _connection;

  static void connectToDatabase(String user, String password) async {
    final settings = ConnectionSettings(
        host: '130.162.243.109',
        port: 3306,
        user: user,
        password: password,
        db: 'krautundrueben');

    try {
      _connection = await MySqlConnection.connect(settings);
      debugPrint("Erfolgreich eingeloggt!");
    } on SocketException catch (e) {
      debugPrint(e.message);
    } on Exception catch (_) {
      debugPrint("wrong login data");
    }
  }

  static Future<void> closeConnection() async {
    if (_connection == null) return;
    await _connection!.close();
  }

  static Future<void> test() async {
    if (_connection == null) return;

    _connection!.query("QUERY");
  }
}
