import 'package:flutter/material.dart';
import 'package:new_test/models/gender.dart';
import 'package:new_test/models/locations_list.dart';
import 'package:new_test/models/shared_preferences.dart';
import 'package:new_test/pages/locations_page.dart';
import 'package:new_test/pages/new_location_page.dart';
import 'package:new_test/pages/settings_page.dart';
import 'package:new_test/pages/test_page.dart';
import 'package:new_test/pages/wardrobe_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

Future main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => LocationsList()..init(),),
        ChangeNotifierProvider(create: (_) => GenderCheck(),),
      ],
      child: MaterialApp(
        routes: {
          '/home': (context) => Home(0),
          '/locations': (context) => LocationsPage(),
          '/settings': (context) => SettingsPage(),
          //'/wardrobe': (context) => WardrobePage(wardrobe: ,),
          '/test': (context) => Test(),
          '/mykola': (context) =>Mykola(),
        },
        title: 'RainDeer',
        theme: ThemeData(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
        ),
        home: Home(0)
      ),
    );
  }
}


