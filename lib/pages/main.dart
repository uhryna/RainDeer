
import 'package:flutter/material.dart';
import 'package:new_test/pages/new_location_page.dart';
import 'package:new_test/pages/search_page.dart';
import 'package:new_test/pages/settings_page.dart';
import 'package:new_test/pages/wardrobe_page.dart';
import 'home_page.dart';

void main () =>runApp(MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
  ),
  title: 'RainDeer',
  home: Home(),
  routes: {
    '/home': (context) => Home(),
    '/locations': (context) => LocationsPage(),
    '/settings' : (context) => SettingsPage(),
    '/search' : (context)  => SearchBar(),
    '/wardrobe': (context) => WardrobePage(),
  },
));


