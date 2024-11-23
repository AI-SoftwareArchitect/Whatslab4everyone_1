import 'package:flutter/material.dart';

class Whatslab4FloatActionButton extends StatelessWidget {
  const Whatslab4FloatActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {

    },
      child: Icon(Icons.message,size: 32,color: Colors.white,),
      backgroundColor: Colors.greenAccent,
    );
  }
}
