
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
        title: Text('Settings', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,20,0,10),
                  child: Text(
                    'Theme',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Dark',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Dark',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,15,0,10),
                  child: Text(
                    'Unit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Dark',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Dark',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
        ),
    );
  }
}
