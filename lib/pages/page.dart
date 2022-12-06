import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ContentPage extends ConsumerStatefulWidget {
  const ContentPage({super.key});
}

abstract class ContentPageState extends ConsumerState<ContentPage> {
  String get title;
  Widget? get content;

  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(
        builder: (context, controller, physics) => ListView(
                physics: physics,
                padding: const EdgeInsets.all(30),
                controller: controller,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 8, 46, 10),
                            fontWeight: FontWeight.w700,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (content != null) content!
                    ],
                  ),
                ]));
  }
}
