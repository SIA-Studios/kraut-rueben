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
  Widget? get content => const Text(
        "aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper eget duis at tellus at urna condimentum mattis pellentesque id nibh tortor id aliquet lectus proin nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque habitant morbi tristique senectus et netus et malesuada fames",
        style: TextStyle(fontSize: 15, color: Colors.black87),
      );
}
