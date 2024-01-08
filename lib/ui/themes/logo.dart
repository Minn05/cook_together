import 'package:flutter/material.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        TextCustom(
          text: 'Cook ',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: ColorsCustom.primary,
          isTitle: true,
        ),
        TextCustom(
          text: 'together ',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: ColorsCustom.background,
          isTitle: true,
        ),
      ],
    );
  }
}
