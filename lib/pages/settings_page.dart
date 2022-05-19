
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  int _valueTheme = 1;
  int _valueUnit = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
          title: Text('Settings', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 1,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                child: Text(
                  'Theme',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,5),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text('White'),
                  leading: Radio(
                    value: 1,
                    groupValue: _valueTheme,
                    onChanged: (value) {
                      setState(() {
                        _valueTheme = value as int;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text('Dark'),
                  leading: Radio(
                    value: 2,
                    groupValue: _valueTheme,
                    onChanged: (value) {
                      setState(() {
                        _valueTheme = value as int;
                      });
                    },
                  ),
                ),
              ),
              /*Card(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('White',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      Icon(Icons.circle)
                    ],
                  ),
                ),*/
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
                child: Text(
                  'Units',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,5),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text('Metric'),
                  leading: Radio(
                    value: 1,
                    groupValue: _valueUnit,
                    onChanged: (value) {
                      setState(() {
                        _valueUnit = value as int;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text('Imperial'),
                  leading: Radio(
                    value: 2,
                    groupValue: _valueUnit,
                    onChanged: (value) {
                      setState(() {
                        _valueUnit = value as int;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

