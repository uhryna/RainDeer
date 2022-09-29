import 'package:flutter/material.dart';
import 'package:new_test/database/database.dart';
import 'package:new_test/models/get_data.dart';
import 'package:new_test/models/shared_preferences.dart';


class LocationsList with ChangeNotifier{
  List<String> locationsList = <String>[];

  void init() async{
    locationsList = Preferences().getLocations() ?? <String>[];//await DatabaseHelper().getCities();//TODO ?????????
   /* List<City> citiesList = await DatabaseHelper().getCities();
    for(var i = 0; i< citiesList.length; i++) {
      locationsList.elementAt(i) = citiesList[i].cityName!;
    }*/
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