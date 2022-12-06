import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseManager {
  static void connectToDatabase(String user, String password) async {
    final settings = ConnectionSettings(
        host: '130.162.243.109',
        port: 3306,
        user: user,
        password: password,
        db: 'krautundrueben');

    final connection;
    try {
      connection = await MySqlConnection.connect(settings);
    } on SocketException catch (e) {
      debugPrint(e.message);
    }
  }
}
