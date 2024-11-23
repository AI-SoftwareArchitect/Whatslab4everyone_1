import 'package:flutter/material.dart';

class Whatslab4Text extends StatelessWidget {
  String content;
  double fontSize;
  Color? color;
  Whatslab4Text({super.key,
    required this.content,
    required this.fontSize,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.bold
      ),
      content,
    );
  }
}
