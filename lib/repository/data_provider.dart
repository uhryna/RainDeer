import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:new_test/repository/AnotherWeatherData.dart';
import 'package:new_test/repository/DailyData.dart';
import 'package:new_test/repository/WeatherData.dart';
import 'package:new_test/repository/LatLongData.dart';


class GetLatLongData{

  Future<LatLongData> getData(String city) async{
    Response response = await get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$city&appid=3efbf22a4338086042c6068277219092'));
    return compute(_parse, response.body);
  }
  LatLongData _parse (String body){
    final responceMap = json.decode(body);
    return LatLongData.fromJson(responceMap[0]);
  }
}

class GetWeatherData{

  Future<WeatherData> getData(String city) async{
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=3efbf22a4338086042c6068277219092&units=metric'));
    return compute(_parse, response.body);
  }
  WeatherData _parse (String body){
    final responceMap = json.decode(body);
    return WeatherData.fromJson(responceMap);
  }
}

class GetAnotherWeatherData{

  Future<AnotherWeatherData> getData(String city) async{
    Response response = await get(Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=3efbf22a4338086042c6068277219092&units=metric'));
    return compute(_parse, response.body);
  }

  AnotherWeatherData _parse (String body){
    final responceMap = json.decode(body);
    return AnotherWeatherData.fromJson(responceMap);
  }
}

class GetDailyData{

  Future<DailyData> getData(double? lat, double? lon) async{
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,current,minutely,alerts&appid=3efbf22a4338086042c6068277219092&units=metric'));
    return compute(_parse, response.body);
  }
  DailyData _parse (String body){
    final responceMap = json.decode(body);
    return DailyData.fromJson(responceMap);
  }
}