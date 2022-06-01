import 'package:flutter/material.dart';
import 'package:new_test/models/get_data.dart';
import 'package:new_test/models/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocationsList with ChangeNotifier{
  List<String> locationsList = <String>[];

  void init(){
    locationsList = Preferences().getLocations() ?? <String>[];
    notifyListeners();
  }

  void addLocation(String city){
    locationsList.add(city);
    collectAllData(city);
    notifyListeners();
  }
  void deleteLocation(int index){
    locationsList.removeAt(index);
     notifyListeners();
  }
  void displayLocations(){

  }
}