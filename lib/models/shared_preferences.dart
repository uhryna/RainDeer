import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _preferences;

  static Future init() async{
    return _preferences = await SharedPreferences.getInstance();
  }
  Future setLocations(List<String> list) {
    return _preferences.setStringList('list', list);
  }
  List<String>? getLocations(){
    return _preferences.getStringList('list');
  }
}