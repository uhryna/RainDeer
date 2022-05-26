import 'package:flutter/material.dart';
import 'package:new_test/models/get_data.dart';

class LocationsList with ChangeNotifier{
  List _locationsList = <String>[];
  List get locationsList => _locationsList;

  void addLocation(String city){
    locationsList.add(city);
    collectAllData(city);
    notifyListeners();
  }
  void displayLocations(){
    notifyListeners();
  }
}