import 'package:new_test/repository/AnotherWeatherData.dart';
import 'package:new_test/repository/DailyData.dart';
import 'package:new_test/repository/LatLongData.dart';
import 'package:new_test/repository/WeatherData.dart';

import '../repository/data_provider.dart';

Future<AllData> collectAllData(String city) async{
  WeatherData weatherData = await FinalData().getFinalData(city);
  LatLongData latLongData = await AnotherLatLongData().getLatLongData(city);
  AnotherWeatherData anotherData = await AnotherData().getAnotherData(city);
  DailyData dailyData = await AnotherDailyData().getDailyData(latLongData.lat,latLongData.lon);
  return AllData(weatherData, latLongData, anotherData, dailyData);
  }

Future<AllData?> collectAllDataCheck(String city) async{
  WeatherData weatherData = await FinalData().getFinalData(city);
  if(weatherData.cod != 200){
  return null;
}else{
    return await collectAllData(city);//collectAllData(city);//TODO м?
  }
}

class AllData{
  final WeatherData wData;
  final LatLongData lData;
  final AnotherWeatherData aData;
  final DailyData dData;

  AllData(this.wData, this.lData, this.aData, this.dData);

}

class FinalData{

  Future<WeatherData> getFinalData(String city) async{
    try{
      GetWeatherData instance = GetWeatherData();
      final data = await instance.getData(city);
      //final city = data.
      return data;
    }on Exception catch (e) {
      print(e);
      throw Exception("error 2");
    }
  }
}


class AnotherData{
  Future<AnotherWeatherData> getAnotherData(String city) async{

    GetAnotherWeatherData instance = GetAnotherWeatherData();
    final data = await instance.getData(city);
    return data;
  }
}
class AnotherDailyData{
  Future<DailyData> getDailyData(double? lat, long) async{

    GetDailyData instance = GetDailyData();
    final data = await instance.getData(lat, long);
    return data;

  }


}
class AnotherLatLongData{
  Future<LatLongData> getLatLongData(String city) async{

    GetLatLongData instance = GetLatLongData();
    final data = await instance.getData(city);
    return data;
  }
}
