
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:new_test/models/locations_list.dart';
import 'package:new_test/pages/new_location_page.dart';
import 'package:new_test/pages/search_page.dart';
import 'package:new_test/pages/settings_page.dart';
import 'package:new_test/pages/test_page.dart';
import 'package:new_test/pages/wardrobe_page.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main () =>runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_) => LocationsList(),),
          //ChangeNotifierProvider(create: (_) =>)
        ],
      
      child: MaterialApp(
          routes: {
            '/home': (context) => Home(),
            '/locations': (context) => LocationsPage(),
            '/settings': (context) => SettingsPage(),
            '/search': (context) => SearchBar(),
            '/wardrobe': (context) => WardrobePage(),
            '/test': (context) => Test(),
          },
          title: 'RainDeer',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Home()),
    );
  }
}


