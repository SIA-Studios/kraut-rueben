import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ContentPage extends ConsumerStatefulWidget {
  const ContentPage({super.key});
}

abstract class ContentPageState extends ConsumerState<ContentPage> {
  String? get title;
  Widget? get content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          IgnorePointer(
            child: Text(
              title!,
              style: const TextStyle(
                  color: Color.fromARGB(255, 8, 46, 10),
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white.withOpacity(0.15),
              child: DynMouseScroll(
                  builder: (context, controller, physics) =>
                      SingleChildScrollView(
                          padding: EdgeInsets.all(30),
                          physics: physics,
                          controller: controller,
                          child: content != null ? content! : null)),
            ),
          ),
        ),
      ],
    );
  }
}
