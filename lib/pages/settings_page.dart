import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
                                                                //TODO зробити сторінку налаштувань
                                                                //TODO зробити світчі
class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.black,)),
        backgroundColor: Colors.transparent..withOpacity(0),
        elevation: 0,
      ),
        body: SafeArea(
            child: Text('test test test')
        ),
    );
  }
}
