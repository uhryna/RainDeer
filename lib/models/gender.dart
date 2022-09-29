import 'package:flutter/material.dart';

class GenderCheck with ChangeNotifier{//TODO зробити в шерд преференсес
  String gender = '';
  void toFemale(){
    gender = 'Female';
    notifyListeners();
    print(gender);
  }
  void toMale(){
    gender = 'Male';
    notifyListeners();
    print(gender);
  }
  void toUnspecified(){
    gender = 'Unspecified';
    notifyListeners();
    print(gender);
  }
}