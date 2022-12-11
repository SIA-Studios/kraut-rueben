import 'package:mysql1/mysql1.dart';

class Intolerance {
  final int intolreanceId;
  final String name;

  Intolerance(this.intolreanceId, this.name);

  factory Intolerance.fromResultRow(ResultRow values) {
    return Intolerance(values['UNVERID'], values['NAME']);
  }
}
