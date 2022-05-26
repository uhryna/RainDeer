import 'package:intl/intl.dart';

class DateParser{
  static String parseDate (int? date){
    try{
      var value = date == null
          ? 'error'
          : DateTime.fromMillisecondsSinceEpoch(date * 1000).toIso8601String();
      DateTime dt = DateTime.parse(value);
      String trueDT = DateFormat('HH:mm').format(dt);
      return trueDT;
    }on Exception catch (e) {
      print(e);
      throw Exception("ParseDate error");
    }
  }
}
class DayParser{
  static String parseDay (int? date){
    try{
      print('$date fffff');
      var value = date == null
          ? 'error'
          : DateTime.fromMillisecondsSinceEpoch(date * 1000).toIso8601String();
      DateTime dt = DateTime.parse(value);
      String trueDT = DateFormat('dd·MM').format(dt);
      return trueDT;
    }on Exception catch (e) {
      print(e);
      throw Exception("ParseDay error");
    }
  }
}