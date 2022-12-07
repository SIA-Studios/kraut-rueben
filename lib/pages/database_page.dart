import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/models/customer.dart';
import 'package:kraut_rueben/pages/page.dart';

class DatabasePage extends ContentPage {
  const DatabasePage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _DatabasePageState();
}

class _DatabasePageState extends ContentPageState {
  final List<DataRow> rows = [];

  Future<void> _loadCustomers() async {
     final customers = await DatabaseManager.getCustomers();

    setState(() {
        for (final customer in customers) {
              rows.add(DataRow(cells: [
                DataCell(Text(customer.customerId.toString())),
                DataCell(Text(customer.surname)),
                DataCell(Text(customer.name)),
                DataCell(Text(customer.birthday.toIso8601String())),
                DataCell(Text(customer.street)),
                DataCell(Text(customer.streetNumber)),
                DataCell(Text(customer.postcode)),
                DataCell(Text(customer.location)),
                DataCell(Text(customer.phone)),
                DataCell(Text(customer.email)),
              ]));
            }
      });
  }  

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      await _loadCustomers();
    });
  }

  @override
  String? get title => "Database";

  @override
  Widget? get content => Container(
        height: 300,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("KundenNr")),
              DataColumn(label: Text("Nachname")),
              DataColumn(label: Text("Vorname")),
              DataColumn(label: Text("Geburtsdatum")),
              DataColumn(label: Text("Strasse")),
              DataColumn(label: Text("Hausnummer")),
              DataColumn(label: Text("Postleitzahl")),
              DataColumn(label: Text("Ort")),
              DataColumn(label: Text("Telefon")),
              DataColumn(label: Text("Email")),
            ],
            rows: rows,
          ),
        ),
      );
}
