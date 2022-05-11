import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Manage cities'),
          //TODO: картку, при нажиманні на яку, відкривається нова сторінка серч бар пейдж
          //TODO: listview.builder з картками відповідно до доданих міст
        ],
      )
    );
  }
}
