import 'package:flutter/material.dart';

void main () =>runApp(MaterialApp(
  title: 'app',
  home: Home(),
));
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController();
    return  PageView(
      controller: PageController(),
        children: const <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        )

    );
  }
}
