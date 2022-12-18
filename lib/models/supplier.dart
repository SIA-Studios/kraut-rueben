import 'package:mysql1/mysql1.dart';

class Supplier {
  final int supplierId;
  final String supplierName;
  final String street;
  final String streetNumber;
  final String postcode;
  final String location;
  final String phone;
  final String email;

  Supplier(this.supplierId, this.supplierName, this.street,
      this.streetNumber, this.postcode, this.location, this.phone, this.email);

  factory Supplier.fromResultRow(ResultRow values) {
    return Supplier(
        values['LIEFERANTENNR'],
        values['LIEFERANTENNAME'],
        values['STRASSE'],
        values['HAUSNR'],
        values['PLZ'],
        values['ORT'],
        values['TELEFON'],
        values['EMAIL']);
  }
}
