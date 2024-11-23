import 'package:flutter/material.dart';

enum Whatslab4TextfieldType {
  NORMAL,
  PASSWORD
}

class Whatslab4Textfield extends StatelessWidget {
  TextEditingController editingController;
  String placeHolder;
  String title;
  Whatslab4TextfieldType type;
  FormFieldValidator<String> validation;

  Whatslab4Textfield({super.key,
    required this.editingController,
    required this.placeHolder,
    required this.title,
    required this.type,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
        child: TextFormField(
          maxLines: 1,
      expands: false,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.50),
          fontStyle: FontStyle.italic
        ),
        errorMaxLines: 0,
        focusColor: Colors.lightGreenAccent,
        labelText: title,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.75),
          fontSize: 12,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
            decorationColor: Colors.white,
        ),
        hintText: placeHolder,
      ),
      style: TextStyle(
          color: Colors.white.withOpacity(0.90),
          fontWeight: FontWeight.bold,
      ),
      controller: editingController,
      obscureText: type == Whatslab4TextfieldType.NORMAL ? false : true,
      autocorrect: type == Whatslab4TextfieldType.NORMAL ? true : false,
      enableSuggestions: type == Whatslab4TextfieldType.NORMAL ? true : false,
          validator: validation,
    )
    );
  }
}
