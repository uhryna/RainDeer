import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:new_test/repository/WeatherData.dart';

class GetRawWeatherData{
  Future<WeatherData> getData() async{
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=lviv&appid=3efbf22a4338086042c6068277219092'));
    return compute(_parse, response.body);
  }
    WeatherData _parse (String body){
    final responceMap = json.decode(body);
    return WeatherData.fromJson(responceMap);
  }
}