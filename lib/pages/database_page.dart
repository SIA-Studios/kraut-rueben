import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/pages/page.dart';

class DatabasePage extends ContentPage {
  const DatabasePage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _DatabasePageState();
}

class _DatabasePageState extends ContentPageState {
  @override
  String? get title => "Database";

  @override
  Widget? get content => Container(
        height: 300,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("title")),
              DataColumn(label: Text("id")),
              DataColumn(label: Text("ingredients")),
              DataColumn(label: Text("price")),
              DataColumn(label: Text("info")),
              DataColumn(label: Text("category")),
              DataColumn(label: Text("allergens")),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("test1")),
                DataCell(Text("2354752895723895")),
                DataCell(Text("Milk, Eggs, Pork, Whatever")),
                DataCell(Text("10.99")),
                DataCell(Text("A very delicious recipe for a sunday evening")),
                DataCell(Text("Dinner")),
                DataCell(Text("Lactose, Eggs, Meat")),
              ]),
              DataRow(cells: [
                DataCell(Text("test2")),
                DataCell(Text("2375627523")),
                DataCell(Text("Cream, Eggs, Strawberries, Whatever")),
                DataCell(Text("5.99")),
                DataCell(Text("The perfect dessert for every occasion")),
                DataCell(Text("Dessert")),
                DataCell(Text("Lactose, Eggs, fructose")),
              ])
            ],
          ),
        ),
      );
}
