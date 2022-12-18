import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/backend/database.dart';
import 'package:kraut_rueben/pages/page.dart';

class PrivacyPage extends ContentPage {
  const PrivacyPage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends ContentPageState {
  @override
  String? get title => "Query";

  @override
  Future<Widget?> get content => contentWidget();

  Future<Widget> contentWidget() async {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: Text(
                  "Verantwortlicher für die Datenverarbeitung ist:\nFinn-Ole Kahl\nHalstenbeker Straße 24C\n22457 Hamburg",
                  textAlign: TextAlign.left),
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              child: Text(
                "Datenschutzbeauftragter:\nTim Urbutt\nFriedensalle 37\n22926 Ahrensburg\nt.urbutt@bhh.de",
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
            "Wir freuen uns über Ihr Interesse an unserem Online-Shop. Der Schutz Ihrer Privatsphäre ist für uns sehr wichtig. Nachstehend informieren wir Sie ausführlich über den Umgang mit Ihren Daten.",
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        const Text("1. Personenbezogene Daten", textAlign: TextAlign.left),
        const Text(
          "Wir erheben personenbezogene Daten (nach Art. 4, Nr. 1 DSGVO), wenn Sie uns diese im Rahmen einer Bestellung oder Registierung mitteilen. Pflichtfelder werden als solche gekennzeichnet, da wir in diesen Fällen die Daten zwingend zur Vertragsabwicklung benötigen und Sie ohne deren Angabe die Bestellung nicht abschließen, bzw. die Kontaktaufnahme nicht versenden können. Welche Daten erhoben werden, ist aus den jeweiligen Eingabeformularen ersichtlich. Wir verwenden die von ihnen mitgeteilten Daten gemäß Art. 6 Abs. 1 (...)",
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "2. Datenweitergabe",
          textAlign: TextAlign.left,
        ),
        const Text(
          "Zur Vertragserfüllung gemäß Art. 6 Abs. 1 S. 1 lit. b DSGVO geben wir Ihre Daten an das mit der Lieferung beauftragte Versandunternehmen weiter, soweit dies zur Lieferung bestellter Waren erforderlich ist. Je nach dem, welchen Zahlungsdienstleister Sie im Bestellprozess auswählen, geben wir zur Abwicklung von Zahlungen die hierfür erhobenen Zahlungsdaten an das mit der Zahlung beauftragte Kreditinstitut und ggf. von uns beauftragte Zahlungsdienstleister weiter (...)",
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "3. Kontaktmöglichkeiten und Ihre Rechte Als Betroffener haben Sie folgende Rechte:",
          textAlign: TextAlign.left,
        ),
        const Text(
          "gemäß Art. 15 DSGVO das Recht, in dem dort bezeichneten Umfang Auskunft über Ihre von uns verarbeiteten personenbezogenen Daten zu verlangen; gemäß Art. 16 DSGVO das Recht, unverzüglich die Berichtigung unrichtiger oder Vervollständigung Ihrer bei uns gespeicherten personenbezogenen Daten zu verlangen; gemäß Art. 17 DSGVO das Recht, die Löschung Ihrer bei uns gespeicherten personenbezogenen Daten zu verlangen, soweit nicht die weitere Verarbeitung",
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Haben sie Einwilligungen oder Widersprüche gegen eine bestimmte Datenverwendung? Wenden Sie sich bitte direkt an uns über die unten angegebenen Kontaktdaten.",
          textAlign: TextAlign.justify,
        )
      ],
    );
  }
}
