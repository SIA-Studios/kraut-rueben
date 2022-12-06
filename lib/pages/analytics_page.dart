import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kraut_rueben/pages/page.dart';

class AnalyticsPage extends ContentPage {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<ContentPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ContentPageState {
  @override
  String get title => "Analytics";

  @override
  Widget get content => const Text(
        "donec massa sapien faucibus et molestie ac feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor eu augue ut lectus arcu bibendum at varius vel pharetra vel turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque convallis a cras semper auctor neque vitae tempus quam pellentesque nec nam aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget velit aliquet sagittis id consectetur purus ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt",
        style: TextStyle(fontSize: 15, color: Colors.black87),
      );
}
