import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:new_test/models/wardrobe.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "clothes.db");


    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", "clothes.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);
    var db = await openDatabase(path, readOnly: true);

    return db;
  }
  Future<Database> _initCitiesDatabase() async{
    var databasesPath = await getDatabasesPath();
    var pathCities = join(databasesPath, "cities.db");

    /*await deleteDatabase(pathCities);

    try {
      await Directory(dirname(pathCities)).create(recursive: true);//INSERT INTO table (column1,column2 ,..)
                                                                        //VALUES( value1,	value2 ,...);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", "cities.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(pathCities).writeAsBytes(bytes, flush: true);*/
    var db = await openDatabase(pathCities);

    return db;
  }
  Future<List<City>> getCities() async{
    Database db = await _initCitiesDatabase();
    var cities = await db.rawQuery('SELECT city_id, city_name, city_temp, city_min_temp, city_max_temp FROM city_info');//'INSERT INTO city_info(city_name, city_temp, city_min_temp, city_max_temp) VALUES(?)', [value.items[i]]);
    print(cities);
    return List<City>.from(cities.map((model)=> City.fromMap(model)));
  }
  Future<int> addCities(City city) async{
    Database db = await _initCitiesDatabase();
    return await db.insert('city_info', city.toMap());//'INSERT INTO city_info (city_id, city_name, city_temp, city_min_temp, city_max_temp) VALUES ()');
  }

  Future<List<Clothes>> getMaleClothes(int subcategory, String gender) async{
    Database db = await _initDatabase();
    var clothes = await db.rawQuery('SELECT * FROM items WHERE item_gender = "$gender" AND subcategory_id = $subcategory');
    return List<Clothes>.from(clothes.map((model)=> Clothes.fromMap(model)));
  }//TODO tut
  Future<List<Clothes>> getClothes(int subcategory) async{
    Database db = await _initDatabase();
    var clothes = await db.rawQuery('SELECT * FROM items WHERE subcategory_id = $subcategory ');
    return List<Clothes>.from(clothes.map((model)=> Clothes.fromMap(model)));
  }//TODO tut
  Future<int> removeCity(int id) async{
    Database db = await _initCitiesDatabase();
    return await db.delete('city_info', where: 'city_id = ?', whereArgs: [id]);
  }

}

class Clothes{
  final int? itemId;
  final String itemName;
  final int? categoryId;
  final int? subcategoryId;

  Clothes({this.itemId, required this.itemName, required this.categoryId, required this.subcategoryId});

  @override
    String toString (){
      return '$itemName';//$runtimeType :
    }

  factory Clothes.fromMap(Map<String, dynamic> json) => Clothes(
    itemId: json['item_id'],
    itemName: json['item_name'],
    categoryId: json['category_id'],
    subcategoryId: json['subcategory_id'],
  );
  Map<String, dynamic> toMap() {
    return{
      'item_id': itemId,
      'item_name': itemName,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
    };
  }
}
class City{
  final int? cityId;
  final String? cityName;
  final int? cityTemp;
  final int? cityMinTemp;
  final int? cityMaxTemp;

  City({this.cityId, required this.cityName, required this.cityTemp, required this.cityMinTemp, required this.cityMaxTemp});

  /*@override
  String toString (){
    return '$cityName';//$runtimeType :
  }*/

  factory City.fromMap(Map<String, dynamic> json) => City(
    cityId: json['city_id'],
    cityName: json['city_name'],
    cityTemp: json['city_temp'],
    cityMinTemp: json['city_min_temp'],
    cityMaxTemp: json['city_max_temp'],
  );
  Map<String, dynamic> toMap() {
    return{
      'city_id': cityId,
      'city_name': cityName,
      'city_temp': cityTemp,
      'city_min_temp': cityMinTemp,
      'city_max_temp': cityMaxTemp,
    };
  }
}

