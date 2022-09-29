import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mykola extends StatelessWidget {
  const Mykola({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background_images/download.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
