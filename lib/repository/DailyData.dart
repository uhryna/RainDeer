/// lat : 33.44
/// lon : -94.04
/// timezone : "America/Chicago"
/// timezone_offset : -18000
/// daily : [{"dt":1653415200,"sunrise":1653390638,"sunset":1653441343,"moonrise":1653379680,"moonset":1653422280,"moon_phase":0.82,"temp":{"day":296.16,"min":289.57,"max":297.86,"night":292.81,"eve":295.88,"morn":289.57},"feels_like":{"day":296.84,"night":293.31,"eve":296.32,"morn":289.83},"pressure":1010,"humidity":89,"dew_point":294.25,"wind_speed":6.25,"wind_deg":162,"wind_gust":12.92,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"clouds":100,"pop":1,"rain":11.31,"uvi":6.34},{"dt":1653501600,"sunrise":1653477009,"sunset":1653527783,"moonrise":1653467760,"moonset":1653512280,"moon_phase":0.85,"temp":{"day":293.5,"min":288.53,"max":295.22,"night":288.53,"eve":292.21,"morn":288.75},"feels_like":{"day":293.84,"night":288.4,"eve":292.26,"morn":288.79},"pressure":1010,"humidity":86,"dew_point":291.12,"wind_speed":7.13,"wind_deg":218,"wind_gust":14.75,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"clouds":97,"pop":1,"rain":13.18,"uvi":5.94},{"dt":1653588000,"sunrise":1653563383,"sunset":1653614223,"moonrise":1653555780,"moonset":1653602220,"moon_phase":0.88,"temp":{"day":294.18,"min":284.17,"max":296.64,"night":287.16,"eve":294.06,"morn":284.64},"feels_like":{"day":293.85,"night":286.89,"eve":293.93,"morn":284.27},"pressure":1013,"humidity":58,"dew_point":285.64,"wind_speed":6.19,"wind_deg":297,"wind_gust":11.32,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":44,"pop":0,"uvi":9.04},{"dt":1653674400,"sunrise":1653649757,"sunset":1653700663,"moonrise":1653643800,"moonset":1653692100,"moon_phase":0.91,"temp":{"day":298.36,"min":285,"max":300.66,"night":293.04,"eve":297.94,"morn":286.43},"feels_like":{"day":298.22,"night":292.89,"eve":298.25,"morn":286.14},"pressure":1018,"humidity":49,"dew_point":286.82,"wind_speed":2.02,"wind_deg":155,"wind_gust":2.8,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":10.07},{"dt":1653760800,"sunrise":1653736133,"sunset":1653787102,"moonrise":1653731940,"moonset":1653782040,"moon_phase":0.95,"temp":{"day":302.32,"min":289.57,"max":304.47,"night":295.67,"eve":301.08,"morn":289.57},"feels_like":{"day":302.67,"night":295.83,"eve":302.83,"morn":289.49},"pressure":1014,"humidity":47,"dew_point":289.86,"wind_speed":3.83,"wind_deg":184,"wind_gust":7.51,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":10.27},{"dt":1653847200,"sunrise":1653822511,"sunset":1653873540,"moonrise":1653820260,"moonset":1653871980,"moon_phase":0.98,"temp":{"day":303.62,"min":291.6,"max":305.83,"night":296.94,"eve":301.28,"morn":291.6},"feels_like":{"day":304.1,"night":297.07,"eve":303.03,"morn":291.9},"pressure":1011,"humidity":45,"dew_point":290.45,"wind_speed":5.01,"wind_deg":191,"wind_gust":13.01,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":1,"pop":0,"uvi":0.18},{"dt":1653933600,"sunrise":1653908890,"sunset":1653959977,"moonrise":1653908820,"moonset":1653961860,"moon_phase":0,"temp":{"day":301.83,"min":292.99,"max":303.72,"night":295.37,"eve":300.67,"morn":292.99},"feels_like":{"day":301.89,"night":295.27,"eve":302.1,"morn":293.43},"pressure":1016,"humidity":45,"dew_point":288.68,"wind_speed":4.68,"wind_deg":178,"wind_gust":12.6,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":1},{"dt":1654020000,"sunrise":1653995271,"sunset":1654046413,"moonrise":1653997620,"moonset":1654051620,"moon_phase":0.04,"temp":{"day":302.39,"min":293.54,"max":303.11,"night":297.27,"eve":299.77,"morn":293.54},"feels_like":{"day":304.76,"night":297.77,"eve":299.77,"morn":294.09},"pressure":1018,"humidity":61,"dew_point":294.18,"wind_speed":3.83,"wind_deg":138,"wind_gust":9.78,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":17,"pop":0.69,"rain":1.44,"uvi":1}]

class DailyData {
  DailyData({
      this.lat, 
      this.lon, 
      this.timezone, 
      this.timezoneOffset, 
      this.daily,});

  DailyData.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily?.add(Daily.fromJson(v));
      });
    }
  }
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  late List<Daily>? daily;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    map['timezone'] = timezone;
    map['timezone_offset'] = timezoneOffset;
    if (daily != null) {
      map['daily'] = daily?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// dt : 1653415200
/// sunrise : 1653390638
/// sunset : 1653441343
/// moonrise : 1653379680
/// moonset : 1653422280
/// moon_phase : 0.82
/// temp : {"day":296.16,"min":289.57,"max":297.86,"night":292.81,"eve":295.88,"morn":289.57}
/// feels_like : {"day":296.84,"night":293.31,"eve":296.32,"morn":289.83}
/// pressure : 1010
/// humidity : 89
/// dew_point : 294.25
/// wind_speed : 6.25
/// wind_deg : 162
/// wind_gust : 12.92
/// weather : [{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}]
/// clouds : 100
/// pop : 1
/// rain : 11.31
/// uvi : 6.34

class Daily {
  Daily({
      this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.rain,
      this.uvi,});

  Daily.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? FeelsLike.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    rain = json['rain'];
    uvi = json['uvi'];
  }
  int? dt;
  int? sunrise;
  num? sunset;
  num? moonrise;
  num? moonset;
  num? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<Weather>? weather;
  num? clouds;
  num? pop;
  num? rain;
  num? uvi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = dt;
    map['sunrise'] = sunrise;
    map['sunset'] = sunset;
    map['moonrise'] = moonrise;
    map['moonset'] = moonset;
    map['moon_phase'] = moonPhase;
    if (temp != null) {
      map['temp'] = temp?.toJson();
    }
    if (feelsLike != null) {
      map['feels_like'] = feelsLike?.toJson();
    }
    map['pressure'] = pressure;
    map['humidity'] = humidity;
    map['dew_point'] = dewPoint;
    map['wind_speed'] = windSpeed;
    map['wind_deg'] = windDeg;
    map['wind_gust'] = windGust;
    if (weather != null) {
      map['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    map['clouds'] = clouds;
    map['pop'] = pop;
    map['rain'] = rain;
    map['uvi'] = uvi;
    return map;
  }

}

/// id : 501
/// main : "Rain"
/// description : "moderate rain"
/// icon : "10d"

class Weather {
  Weather({
      this.id, 
      this.main, 
      this.description, 
      this.icon,});

  Weather.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
  int? id;
  String? main;
  String? description;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['main'] = main;
    map['description'] = description;
    map['icon'] = icon;
    return map;
  }

}

/// day : 296.84
/// night : 293.31
/// eve : 296.32
/// morn : 289.83

class FeelsLike {
  FeelsLike({
      this.day, 
      this.night, 
      this.eve, 
      this.morn,});

  FeelsLike.fromJson(dynamic json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
  num? day;
  num? night;
  num? eve;
  num? morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['night'] = night;
    map['eve'] = eve;
    map['morn'] = morn;
    return map;
  }

}

/// day : 296.16
/// min : 289.57
/// max : 297.86
/// night : 292.81
/// eve : 295.88
/// morn : 289.57

class Temp {
  Temp({
      this.day, 
      this.min, 
      this.max, 
      this.night, 
      this.eve, 
      this.morn,});

  Temp.fromJson(dynamic json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
  num? day;
  num? min;
  num? max;
  num? night;
  num? eve;
  num? morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['min'] = min;
    map['max'] = max;
    map['night'] = night;
    map['eve'] = eve;
    map['morn'] = morn;
    return map;
  }

}