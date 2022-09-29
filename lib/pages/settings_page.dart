
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_test/models/gender.dart';
import 'package:new_test/models/shared_preferences.dart';
import 'package:provider/provider.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  int? _valueTheme = Preferences().getValue();
  int? _valueUnit = Preferences().getValue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
          //title: Text('Settings', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Settings', style: TextStyle(color: Colors.black,fontSize: 40, fontWeight: FontWeight.w200),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                child: Text(
                  'Gender',
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
                  title: const Text('Female'),
                  leading: Radio(
                    value: 1,
                    groupValue: _valueTheme,
                    onChanged: (value) {
                      setState(() {
                        _valueTheme = value as int;
                        context.read<GenderCheck>().toFemale();
                        Preferences().setValue(value);
                      });
                    },
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
                  title: const Text('Male'),
                  leading: Radio(
                    value: 2,
                    groupValue: _valueTheme,
                    onChanged: (value) {
                      setState(() {
                        _valueTheme = value as int;
                        context.read<GenderCheck>().toMale();
                        Preferences().setValue(value);
                      });
                    },
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
                  title: const Text('Unspecified'),
                  leading: Radio(
                    value: 3,
                    groupValue: _valueTheme,
                    onChanged: (value) {
                      setState(() {
                        _valueTheme = value as int;
                        context.read<GenderCheck>().toUnspecified();
                        Preferences().setValue(value);
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

