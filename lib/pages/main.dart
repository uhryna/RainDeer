import 'package:flutter/material.dart';
import 'package:new_test/pages/new_location_page.dart';
import 'package:new_test/pages/settings_page.dart';
import 'home_page.dart';

void main () =>runApp(MaterialApp(
  title: 'RainDeer',
  home: Home(),
  routes: {
    '/home': (context) => Home(),
    '/locations': (context) => LocationsPage(),
    '/settings' : (context) => SettingsPage(),
  },
));


