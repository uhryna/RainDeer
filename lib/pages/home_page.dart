import 'dart:math';
import 'package:new_test/database/database.dart';
import 'package:new_test/models/gender.dart';
import 'package:new_test/models/icons.dart';
import 'package:new_test/models/wardrobe.dart';
import 'package:new_test/pages/wardrobe_page.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:new_test/models/parse_data.dart';
import 'package:new_test/models/get_data.dart';
import '../models/locations_list.dart';

class Home extends StatefulWidget {
  int selectedIndex;
   Home(this.selectedIndex, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = PageController();

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {

    final locations = Provider.of<LocationsList>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background_images/background1.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0),
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/locations");
            },
            icon: Icon(Icons.add),
            iconSize: 40,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'RainDeer',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Consumer<LocationsList>(
                      builder: (context, locations, child) {
                        if(locations.locationsList.isEmpty){
                          return SizedBox();
                        }else {
                          return SmoothPageIndicator(
                            controller: controller,
                            count: locations.locationsList.length,
                            effect: WormEffect(
                              dotHeight: 16,
                              dotWidth: 16,
                              type: WormType.thin,
                            ),
                          );
                        }
                      }
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
                color: Colors.white.withOpacity(1),
                onSelected: (choice) {
                  switch (choice) {
                    case 0:
                      Navigator.pushNamed(context, "/test");
                      break;
                    case 1:
                      Navigator.pushNamed(context, "/settings");
                      break;
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15.0)
                  ),
                ),
                itemBuilder:(context) =>[
                  PopupMenuItem(
                    value: 1,
                    child: Text('Settings')
                  ),
                ],
              ),
            ),
          ]
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Consumer<LocationsList>(
                    builder: (context, locations, child) =>
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        itemCount: locations.locationsList.length,
                        itemBuilder: (context, index) {
                          return CityWidget(city: locations.locationsList[index]);
                        }
                      ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class CityWidget extends StatefulWidget {
  final String? city;
  const CityWidget({Key? key, required this.city}) : super(key: key);

  @override
  State<CityWidget> createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {

  late Future<dynamic> future;

  Future<void> _refresh() async {
    //Future.delayed(Duration(seconds: 2));
    await collectAllData(widget.city);

  }
  @override
  void initState() {
    super.initState();
    future = collectAllData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('done');
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        children: [
                          Container(
                            height: 520,
                            child: Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 160, 0, 5),
                                    child: Text(
                                      '${snapshot.data?.wData.name}',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),//misto
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(25, 0, 0, 5),
                                    child: Text(
                                      '${snapshot.data?.wData.main?.temp?.round()}°',
                                      style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),//temperatura
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 20, 0, 65),
                                        child: Text(
                                          '${snapshot.data?.wData.weather![0].main}',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),//clouds
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(13, 0, 20, 0),
                                          child: SizedBox.fromSize(
                                            size: Size(82, 82),
                                            child: ClipOval(
                                              child: Material(
                                                color: Colors.white.withOpacity(0.1),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(41),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Consumer<GenderCheck>(
                                                    builder: (context, gendercheck, child) {
                                                      print('${gendercheck.gender} check');
                                                      return InkWell(
                                                      splashColor: Colors.blueAccent.withOpacity(0.1),
                                                      onTap: () async{
                                                        final random = Random();
                                                        if(gendercheck.gender == 'Female' || gendercheck.gender == 'Unspecified'){
                                                          var overTop = await DatabaseHelper().getClothes(1);
                                                          var overTopRandom = overTop[random.nextInt(overTop.length)];
                                                          var middleTop = await DatabaseHelper().getClothes(2);
                                                          var middleTopRandom = middleTop[random.nextInt(middleTop.length)];
                                                          var underTop = await DatabaseHelper().getClothes(3);
                                                          var underTopRandom = underTop[random.nextInt(underTop.length)];
                                                          var shortBottom = await DatabaseHelper().getClothes(4);
                                                          var shortBottomRandom = shortBottom[random.nextInt(shortBottom.length)];
                                                          var longBottom = await DatabaseHelper().getClothes(5);
                                                          var longBottomRandom = longBottom[random.nextInt(longBottom.length)];
                                                          var warmFootwear = await DatabaseHelper().getClothes(7);
                                                          var warmFootwearRandom = warmFootwear[random.nextInt(warmFootwear.length)];
                                                          var lightFootwear = await DatabaseHelper().getClothes(8);
                                                          var lightFootwearRandom = lightFootwear[random.nextInt(lightFootwear.length)];
                                                          var warmAccessories = await DatabaseHelper().getClothes(9);
                                                          var warmAccessoriesRandom = warmAccessories[random.nextInt(warmAccessories.length)];
                                                          var defaultAccessories = await DatabaseHelper().getClothes(10);
                                                          var defaultAccessoriesRandom = defaultAccessories[random.nextInt(defaultAccessories.length)];
                                                          var umbrellaAccessories = await DatabaseHelper().getClothes(11);
                                                          var umbrellaAccessoriesRandom = umbrellaAccessories[random.nextInt(umbrellaAccessories.length)];
                                                          var bags = await DatabaseHelper().getClothes(12);
                                                          var bagsRandom = bags[random.nextInt(bags.length)];
                                                          print('the user is female');
                                                          if(snapshot.data?.wData.main?.temp?.round() < -20){
                                                            //await DatabaseHelper().getClothes(1);
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }

                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < -10 && snapshot.data?.wData.main?.temp?.round() > -20){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 0 && snapshot.data?.wData.main?.temp?.round() >= -10){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 5 && snapshot.data?.wData.main?.temp?.round() >= 0){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 10 && snapshot.data?.wData.main?.temp?.round() >= 5){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 15 && snapshot.data?.wData.main?.temp?.round() >= 10){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 22 && snapshot.data?.wData.main?.temp?.round() >= 15){
                                                            var instance = Wardrobe(
                                                                [
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 25 && snapshot.data?.wData.main?.temp?.round() >= 22){
                                                            var instance = Wardrobe(
                                                                [
                                                                  underTopRandom,
                                                                  shortBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  umbrellaAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 30 && snapshot.data?.wData.main?.temp?.round() >= 25){
                                                            var instance = Wardrobe(
                                                                [
                                                                  underTopRandom,
                                                                  shortBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 60 && snapshot.data?.wData.main?.temp?.round() >= 30){
                                                            var instance = Wardrobe(
                                                                [
                                                                  underTopRandom,
                                                                  shortBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                        }
                                                        else{
                                                          var overTop = await DatabaseHelper().getMaleClothes(1, 'both');
                                                          var overTopRandom = overTop[random.nextInt(overTop.length)];
                                                          var middleTop = await DatabaseHelper().getMaleClothes(2, 'both');
                                                          var middleTopRandom = middleTop[random.nextInt(middleTop.length)];
                                                          var underTop = await DatabaseHelper().getMaleClothes(3, 'both');
                                                          var underTopRandom = underTop[random.nextInt(underTop.length)];
                                                          var shortBottom = await DatabaseHelper().getMaleClothes(4, 'both');
                                                          var shortBottomRandom = shortBottom[random.nextInt(shortBottom.length)];
                                                          var longBottom = await DatabaseHelper().getMaleClothes(5, 'both');
                                                          var longBottomRandom = longBottom[random.nextInt(longBottom.length)];
                                                          var warmFootwear = await DatabaseHelper().getMaleClothes(7, 'both');
                                                          var warmFootwearRandom = warmFootwear[random.nextInt(warmFootwear.length)];
                                                          var lightFootwear = await DatabaseHelper().getMaleClothes(8, 'both');
                                                          var lightFootwearRandom = lightFootwear[random.nextInt(lightFootwear.length)];
                                                          var warmAccessories = await DatabaseHelper().getMaleClothes(9, 'both');
                                                          var warmAccessoriesRandom = warmAccessories[random.nextInt(warmAccessories.length)];
                                                          var defaultAccessories = await DatabaseHelper().getMaleClothes(10, 'both');
                                                          var defaultAccessoriesRandom = defaultAccessories[random.nextInt(defaultAccessories.length)];
                                                          var umbrellaAccessories = await DatabaseHelper().getMaleClothes(11, 'both');
                                                          var umbrellaAccessoriesRandom = umbrellaAccessories[random.nextInt(umbrellaAccessories.length)];
                                                          var bags = await DatabaseHelper().getMaleClothes(12, 'both');
                                                          var bagsRandom = bags[random.nextInt(bags.length)];
                                                          print('the user is male');
                                                          if(snapshot.data?.wData.main?.temp?.round() < -20){
                                                            //await DatabaseHelper().getClothes(1);
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }

                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < -10 && snapshot.data?.wData.main?.temp?.round() > -20){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 0 && snapshot.data?.wData.main?.temp?.round() >= -10){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 5 && snapshot.data?.wData.main?.temp?.round() >= 0){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 10 && snapshot.data?.wData.main?.temp?.round() >= 5){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  warmFootwearRandom,
                                                                  warmAccessoriesRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 15 && snapshot.data?.wData.main?.temp?.round() >= 10){
                                                            var instance = Wardrobe(
                                                                [
                                                                  overTopRandom,
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 22 && snapshot.data?.wData.main?.temp?.round() >= 15){
                                                            var instance = Wardrobe(
                                                                [
                                                                  middleTopRandom,
                                                                  underTopRandom,
                                                                  longBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 25 && snapshot.data?.wData.main?.temp?.round() >= 22){
                                                            var instance = Wardrobe(
                                                                [
                                                                  underTopRandom,
                                                                  shortBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  umbrellaAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 30 && snapshot.data?.wData.main?.temp?.round() >= 25){
                                                            var instance = Wardrobe(
                                                                [
                                                                  underTopRandom,
                                                                  shortBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                          if(snapshot.data?.wData.main?.temp?.round() < 60 && snapshot.data?.wData.main?.temp?.round() >= 30){
                                                            var instance = Wardrobe(
                                                                [
                                                                  underTopRandom,
                                                                  shortBottomRandom,
                                                                  lightFootwearRandom,
                                                                  defaultAccessoriesRandom,
                                                                  bagsRandom,
                                                                ]
                                                            );
                                                            if(snapshot.data.wData.weather[0].main == 'Rain' || snapshot.data.wData.weather[0].main == 'Thunderstorm' || snapshot.data.wData.weather[0].main == 'Drizzle'){
                                                              instance.items.add(umbrellaAccessoriesRandom);
                                                            }
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => WardrobePage(wardrobe : instance),
                                                                )
                                                            );
                                                          }
                                                        }


                                                      },
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Icon(Icons.umbrella_outlined, color: Colors.white,),
                                                          Text("Wardrobe",
                                                            style:TextStyle(
                                                              color: Colors.white,
                                                            ) ,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ),//knopka
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,20,0,0),
                            child: SizedBox(
                              height: (MediaQuery.of(context).size.width) / 5,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 12,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Container(
                                        height: (MediaQuery.of(context).size.width) / 5,
                                        width: (MediaQuery.of(context).size.width) / 4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateParser.parseDate(snapshot.data?.aData.listb![index].dt),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            ImageIcon(
                                              CustomIcons().showIcons(snapshot.data?.aData.listb![index].weather![0].icon),
                                              size: 45,
                                            ),//Icon(Icons.cloud),
                                            Text('${snapshot.data?.aData.listb![index].main?.temp?.round()}°',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 25, 8, 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: (BoxShape.rectangle),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0)),
                                ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                           Icons.calendar_today
                                        ),
                                      ),
                                      Text(
                                        '7-day forecast',
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(
                                                CustomIcons().showIcons(snapshot.data?.dData.daily![0].weather![0].icon)
                                              ),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data!.dData.daily![0].dt)}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![0].temp?.max?.round()}° / ${snapshot.data?.dData.daily![0].temp?.min?.round()}°',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                            ),
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(
                                                CustomIcons().showIcons(snapshot.data?.dData.daily![1].weather![0].icon),
                                              ),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data?.dData.daily![1].dt)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),),
                                          ],
                                        ),
                                      ),
                                      Align(alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![1].temp?.max?.round()}° / ${snapshot.data?.dData.daily![1].temp?.min?.round()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![2].weather![0].icon)),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data?.dData.daily![2].dt)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![2].temp?.max?.round()}° / ${snapshot.data?.dData.daily![2].temp?.min?.round()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![3].weather![0].icon)),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data?.dData.daily![3].dt)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![3].temp?.max?.round()}° / ${snapshot.data?.dData.daily![3].temp?.min?.round()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![4].weather![0].icon)),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data?.dData.daily![4].dt)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![4].temp?.max?.round()}° / ${snapshot.data?.dData.daily![4].temp?.min?.round()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![5].weather![0].icon)),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data?.dData.daily![5].dt)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![5].temp?.max?.round()}° / ${snapshot.data?.dData.daily![5].temp?.min?.round()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 0, height: 25,),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
                                              child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![6].weather![0].icon)),
                                            ),
                                            Text(
                                              '${DayParser.parseDay(snapshot.data?.dData.daily![6].dt)}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Text(
                                            '${snapshot.data?.dData.daily![6].temp?.max?.round()}° / ${snapshot.data?.dData.daily![6].temp?.min?.round()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: (BoxShape.rectangle),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(16.0)
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 2,
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                            child: Text('Sunrise ',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white
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
                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                            child: Text(
                                              'Sunset ',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white
                                              ),
                                            ),
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
                                            child: InkWell(
                                              child: Text(
                                                '${DateParser.parseDate(snapshot.data?.wData.sys?.sunrise)} AM',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white
                                                ),
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
                                            child: Text(
                                              '${DateParser.parseDate(snapshot.data?.wData.sys?.sunset)} PM',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white
                                              ),
                                            ),
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
                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                            child: Text(
                                              'Wind',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white
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
                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                            child: Text(
                                              'Humidity',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white
                                              ),
                                            ),
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
                                            child: Text(
                                              '${snapshot.data?.wData.wind?.speed} km/h',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white
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
                                            child: Text(
                                              '${snapshot.data?.wData.main?.humidity}%',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white
                                              ),
                                            ),
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
                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                            child: Text(
                                              'Pressure',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white
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
                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                            child: Text(
                                              'Precipitation',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white
                                              ),
                                            ),
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
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                            child: Text(
                                              '${snapshot.data?.wData.main?.pressure} hPa',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white
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
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                            child: Text(
                                              '${(snapshot.data?.dData.daily![0].pop)! * 100}%',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
              strokeWidth: 1,
            ),
          );
        }
      }
    );
  }
}
