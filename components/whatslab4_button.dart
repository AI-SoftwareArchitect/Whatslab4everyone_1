import 'package:flutter/material.dart';
import 'package:whatslab4everyone_1/components/whatslab4_text.dart';

enum Whatslab4ButtonSize {
  small,
  medium,
  big,
}

class Whatslab4Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double fontSize;
  final Color? color;
  final Whatslab4ButtonSize w4bSize;

  const Whatslab4Button({
    super.key,
    required this.onPressed,
    required this.title,
    required this.fontSize,
    this.color,
    this.w4bSize = Whatslab4ButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize(w4bSize);
    return RawMaterialButton(
      padding: const EdgeInsets.all(2),
      hoverColor: Colors.green.withOpacity(0.70),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48),
      ),
      splashColor: Colors.greenAccent.withOpacity(0.80),
      fillColor: color ?? Theme.of(context).colorScheme.primary,
      constraints: BoxConstraints.tight(buttonSize),
      child: Whatslab4Text(
        content: title,
        fontSize: fontSize,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }

  Size _getButtonSize(Whatslab4ButtonSize size) {
    switch (size) {
      case Whatslab4ButtonSize.small:
        return const Size(220, 45);
      case Whatslab4ButtonSize.medium:
        return const Size(350, 60);
      case Whatslab4ButtonSize.big:
        return const Size(500, 80);
    }
  }
}
