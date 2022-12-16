import 'package:mysql1/mysql1.dart';

class Order {
  final int orderId;
  final int customerId;
  final DateTime orderDate;
  final double invoice;

  Order(this.orderId, this.customerId, this.orderDate, this.invoice);

  factory Order.fromResultRow(ResultRow values) {
    return Order(values["BESTELLNR"], values['KUNDENNR'], DateTime.parse(values['BESTELLDATUM'].toString()), values['RECHNUNGSBETRAG']);
  }
}
