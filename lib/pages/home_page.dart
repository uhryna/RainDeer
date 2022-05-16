import 'package:new_test/pages/settings_page.dart';
import 'package:new_test/repository/WeatherData.dart';
import 'package:new_test/repository/data_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = 'Lviv';         //TODO ✔️заімість лоадінг future builder

  bool temperatureType = true;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  String? weatherType = null;
  int? sunrise = null, sunset = null, humidity = null, pressure = null, temperature, feelsLike = null;
  double? windSpeed = null;//TODO intl package дейт формат завтра зроблю
  late Future future;

  Future<void> getFinalData() async{
    GetWeatherData instance = GetWeatherData();
    final data = await instance.getData(city);
    //print(instance.getData());
    setState(() {
      city = data.name!;
      sunrise = data.sys?.sunrise;
      sunset = data.sys?.sunset;
      humidity = data.main?.humidity;
      pressure = data.main?.pressure;
      windSpeed = data.wind?.speed;
      feelsLike = data.main?.feelsLike?.round();
      temperature = data.main?.temp?.round();
      //weatherType = data.weather['main'] as String?; ??????????????????????????????????????????????????
      //var date = DateTime.fromMillisecondsSinceEpoch(sunriseValue * 1000);
      //print(date);
    });
    //print(sunrise);

  }



  Future<void> _refresh(){
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    future = getFinalData();                    //чи це треба(зайвим не буде)
  }

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController();
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, "/locations");
          },
          icon: Icon(Icons.add,),
          iconSize: 40,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'RainDeer',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: PageController(),
                    count: 4,
                    effect: WormEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      type: WormType.thin,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent.withOpacity(0),
          actions: <Widget>[
            SafeArea(
              child: PopupMenuButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                itemBuilder:(context) =>[
                  PopupMenuItem(
                      child: InkWell(
                        child: Text('Settings'),
                        onTap: (){
                          Navigator.popAndPushNamed(context, "/settings"); //TODO розібратися з анімацією, але здається, що вирішення немає
                        },
                      )
                  ),
                  PopupMenuItem(
                      child: InkWell(
                        child: Text('Share'),
                      )
                  )
                ],
              ),
            ),]
      ),
      body: SafeArea(
        child: FutureBuilder<void>(
          future: future,
          builder:(context, snapshot) {
            if (!snapshot.hasError) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/weather_correspondent_images/rainy.png"),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain,
                      opacity: 0.1),

                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                          controller: PageController(),
                          children: <Widget>[
                            Center(
                              child: RefreshIndicator(
                                onRefresh: _refresh,
                                child: ListView(
                                  children: [
                                    Center(
                                      child: Padding(                 //TODO зробити кращий юай, а саме "паралакс" зверху
                                        padding: EdgeInsets.fromLTRB(
                                            0, 100, 0, 5),
                                        child: Text('$city', style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(20, 2, 0, 0),
                                        child: Text('$temperature°', style: TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ElevatedButton.icon(           //TODO зробити нормальну кнопку
                                            icon: Icon(Icons.umbrella),
                                            onPressed: () {
                                              getFinalData();
                                            },
                                            label: Text(
                                                'weather'), //TODO:  ✔️стек замутити і по бокам від рейні падінг розміром з кнопку
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            child: Text(
                                                'Rainy', style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400)),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 15, 0, 15),
                                        child: Text('Feels like $feelsLike°',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    Divider(thickness: 3, height: 25,),       //TODO ClipOval
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.black,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.blue,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.orange,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Sunrise ',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Sunset ',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('${sunrise}',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w300,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$sunset',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight.w300),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Wind',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$windSpeed km/h',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w300),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text(
                                                '$humidity%', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight
                                                      .w300),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Pressure',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$pressure hPa',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w300),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text(
                                                '$humidity%', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight
                                                      .w300),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),       //TODO ClipOval
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.black,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.blue,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.orange,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Sunrise ',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Sunset ',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('${sunrise}',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$sunset',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Wind',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$windSpeed km/h',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text(
                                                '$humidity%', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight
                                                      .w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Pressure',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$pressure hPa',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text(
                                                '$humidity%', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight
                                                      .w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),       //TODO ClipOval
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.black,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.blue,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.orange,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Sunrise ',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Sunset ',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('${sunrise}',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$sunset',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Wind',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$windSpeed km/h',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text(
                                                '$humidity%', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight
                                                      .w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Pressure',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: Text('Humidity',
                                                style: TextStyle(
                                                    fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text('$pressure hPa',
                                                style: TextStyle(fontSize: 30,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              child: Text(
                                                '$humidity%', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight
                                                      .w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                  ],
                                ),
                              ),
                            ),
                            /*Center(
                              child: RefreshIndicator(
                                onRefresh: _refresh,
                                child: ListView(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 120, 0, 5),
                                        child: Text('Kyiv', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 2, 0, 0),
                                        child: Text('18°', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                        child: Text('Clear', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                                        child: Text('Feels like 18°', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.black,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.blue,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.orange,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.red,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.lightGreenAccent,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.green,
                                            height: 75,
                                            width: 65,
                                          ),
                                          Container(
                                            color: Colors.pink,
                                            height: 75,
                                            width: 65,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0,0,0,10),
                                              child: Text('Sunrise ', style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0,0,0,10),
                                              child: Text('Sunset ', style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              child: Text('07:38', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              child: Text('19:23 ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0,0,0,10),
                                              child: Text('Wind', style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0,0,0,10),
                                              child: Text('Humidity', style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              child: Text('34 km/h', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              child: Text('72%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0,0,0,10),
                                              child: Text('Pressure', style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0,0,0,10),
                                              child: Text('Humidity', style: TextStyle(fontSize: 15),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              child: Text('1041 hPa', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                            ),
                                          ),
                                        ),

                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 2,
                                          child:Center(
                                            child: Container(
                                              child: Text('72%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 3, height: 25,),
                                  ],
                                ),
                              ),
                        ),
                        Center(
                          child: RefreshIndicator(
                            onRefresh: _refresh,
                            child: ListView(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 120, 0, 5),
                                    child: Text('Zhytomyr', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 2, 0, 0),
                                    child: Text('17°', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: Text('Clouds', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                                    child: Text('Feels like 16°', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                Divider(thickness: 3, height: 25,),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.red,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.lightGreenAccent,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.green,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.pink,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.black,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.blue,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.orange,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.red,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.lightGreenAccent,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.green,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.pink,
                                        height: 75,
                                        width: 65,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 3, height: 25,),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Sunrise ', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Sunset ', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('07:38', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('19:23 ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, height: 25,),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Wind', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Humidity', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('34 km/h', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('72%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, height: 25,),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Pressure', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Humidity', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('1041 hPa', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('72%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, height: 25,),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: RefreshIndicator(
                            onRefresh: _refresh,
                            child: ListView(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 120, 0, 5),
                                    child: Text('Uzhgorod', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 2, 0, 0),
                                    child: Text('24°', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: Text('Clear', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                                    child: Text('Feels like 25°', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                Divider(thickness: 3, height: 25,),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.red,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.lightGreenAccent,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.green,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.pink,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.black,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.blue,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.orange,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.red,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.lightGreenAccent,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.green,
                                        height: 75,
                                        width: 65,
                                      ),
                                      Container(
                                        color: Colors.pink,
                                        height: 75,
                                        width: 65,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 3, height: 25,),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Sunrise ', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Sunset ', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('07:38', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('19:23 ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, height: 25,),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Wind', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Humidity', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('34 km/h', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('72%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, height: 25,),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Pressure', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(0,0,0,10),
                                          child: Text('Humidity', style: TextStyle(fontSize: 15),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('1041 hPa', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child:Center(
                                        child: Container(
                                          child: Text('72%', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, height: 25,),
                              ],
                            ),
                          ),
                        )*/
                          ]),
                    ),
                  ],
                ),
              );
            }
            else{
              return SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}
