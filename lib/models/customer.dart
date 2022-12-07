import 'package:mysql1/mysql1.dart';

class Customer {
  final int customerId;
  final String surname;
  final String name;
  final DateTime birthday;
  final String street;
  final String streetNumber;
  final String postcode;
  final String location;
  final String phone;
  final String email;

  Customer(this.customerId, this.surname, this.name, this.birthday, this.street,
      this.streetNumber, this.postcode, this.location, this.phone, this.email);

  factory Customer.fromResultRow(ResultRow values) {
    return Customer(
        values['KUNDENNR'],
        values['NACHNAME'],
        values['VORNAME'],
        DateTime.parse(values['GEBURTSDATUM'].toString()),
        values['STRASSE'],
        values['HAUSNR'],
        values['PLZ'],
        values['ORT'],
        values['TELEFON'],
        values['EMAIL']);
  }
}
