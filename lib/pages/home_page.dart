//import 'dart:js';
import 'package:new_test/models/icons.dart';
import 'package:new_test/models/shared_preferences.dart';
import 'package:new_test/pages/settings_page.dart';
import 'package:new_test/repository/WeatherData.dart';
import 'package:new_test/repository/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_test/models/parse_data.dart';
import 'package:new_test/models/get_data.dart';

import '../models/locations_list.dart';
import 'new_location_page.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    //LocationsList().displayLocations();
    // НФБК
  }

                               //TODO flutterfire_ui з репозиторія в локал сторедж;
  @override
  Widget build(BuildContext context) {

    final locations = Provider.of<LocationsList>(context, listen: false);

    return  Container(
        decoration: BoxDecoration(
            image: DecorationImage(
           image: AssetImage("assets/background_images/background1.jpg"),
          fit: BoxFit.fill,
         ),
         ),
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0),
        appBar: AppBar(
          //iconTheme: IconThemeData(color: Colors.black),
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
                        //color: Colors.black,
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
                          //TODO попробувати 2 різних контролера
                          count: locations.locationsList.length,
                          //TODO зробити початкову сторінку
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                  itemBuilder:(context) =>[
                    PopupMenuItem(
                      value: 1,
                      child: Text('Settings')
                    ),
                    PopupMenuItem(
                      value: 0,
                        child: Text('Share')
                    )
                  ],
                ),
              ),]
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

  final String city;

  const CityWidget({Key? key, required this.city}) : super(key: key);

  @override
  State<CityWidget> createState() => _CityWidgetState();
}


class _CityWidgetState extends State<CityWidget> {

  late Future<dynamic> future;

  Future<void> _refresh() async {
    Future.delayed(Duration(seconds: 2));
    collectAllData(widget.city);

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
                                          //TODO додати theme data
                                          Container(
                                            height: 520,
                                          //  decoration: BoxDecoration(
                                            //    image: DecorationImage(
                                             //   image: AssetImage("assets/background_images/IMG_1.png"),
                                              //  fit: BoxFit.fill,
                                             // ),
                                           // ),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 160, 0, 5),
                                                    child: Text('${snapshot.data?.wData.name}',
                                                        style: TextStyle(
                                                            fontSize: 35,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.white,
                                                        )),
                                                  ),
                                                ),//misto
                                                Center(
                                                  child: Padding(
                                                  padding: EdgeInsets.fromLTRB(25, 0, 0, 5),
                                                  child: Text('${snapshot.data?.wData.main?.temp?.round()}°',
                                                    style: TextStyle(
                                                      fontSize: 80,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    )
                                                  ),
                                                ),
                                              ),//temperatura
                                                Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 65),
                                                      child: Text('${snapshot.data?.wData.weather![0].main}',
                                                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white,)),
                                                    ),
                                                    /*Padding(
                                                      padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                                                      child: Text(
                                                          'Feels like ${snapshot.data?.wData.main?.feelsLike?.round()}°',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w400,
                                                            color: Colors.white,
                                                          )
                                                      ),
                                                    ),*/
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
                                                                        )
                                                                    ),
                                                                    child: InkWell(
                                                                      splashColor: Colors.blueAccent.withOpacity(0.1),
                                                                      onTap: () {
                                                                        Navigator.pushNamed(context, '/wardrobe');
                                                                        print(snapshot.data?.wData.main?.temp);
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
                                          //TODO ClipOval
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
                                                              Text(DateParser.parseDate(snapshot.data?.aData.listb![index].dt), style: TextStyle(color: Colors.white),),
                                                              ImageIcon(CustomIcons().showIcons(snapshot.data?.aData.listb![index].weather![0].icon), size: 45,),//Icon(Icons.cloud),
                                                              Text('${snapshot.data?.aData.listb![index].main?.temp?.round()}°', style: TextStyle(color: Colors.white),)
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
                                                           Icons.calendar_today),
                                                      ),
                                                      Text('7-day forecast', style: TextStyle(color: Colors.white),),
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
                                                            child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![0].weather![0].icon)),
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
                                                    Align(alignment: Alignment.centerRight,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                          child: Text(
                                                            '${snapshot.data?.dData.daily![0].temp?.max?.round()}° / ${snapshot.data?.dData.daily![0].temp?.min?.round()}°',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                            color: Colors.white),),
                                                        )),
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
                                                            child: ImageIcon(CustomIcons().showIcons(snapshot.data?.dData.daily![1].weather![0].icon)),
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
                                                                color: Colors.white),),
                                                        )),
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
                                                                color: Colors.white),),
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
                                                                color: Colors.white),),
                                                        )),
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
                                                                color: Colors.white),),
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
                                                                color: Colors.white),),
                                                        )),
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
                                                                color: Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(alignment: Alignment.centerRight,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                          child: Text(
                                                            '${snapshot.data?.dData.daily![4].temp?.max?.round()}° / ${snapshot.data?.dData.daily![4].temp?.min?.round()}°',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.white),),
                                                        )),
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
                                                                color: Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(alignment: Alignment.centerRight,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                          child: Text(
                                                            '${snapshot.data?.dData.daily![5].temp?.max?.round()}° / ${snapshot.data?.dData.daily![5].temp?.min?.round()}°',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.white),),
                                                        )),
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
                                                                color: Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(alignment: Alignment
                                                        .centerRight,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                          child: Text(
                                                            '${snapshot.data?.dData.daily![6].temp?.max?.round()}° / ${snapshot.data?.dData.daily![6].temp?.min?.round()}°',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.white),),
                                                        )),
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
                                                    Radius.circular(16.0)),
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
                                                                  color: Colors.white),),
                                                          ),
                                                        ),
                                                      ),

                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        flex: 2,
                                                        child: Center(
                                                          child: Container(
                                                            padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                                            child: Text('Sunset ',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors.white),),
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
                                                              // AM',
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight: FontWeight.w300,
                                                                  color: Colors.white
                                                              ),
                                                            ),)
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
                                                          // PM',     //
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.white),),
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
                                                        child: Text('Wind',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),

                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 2,
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                                        child: Text('Humidity',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white),),
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
                                                              color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),

                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 2,
                                                    child: Center(
                                                      child: Container(
                                                        child: Text('${snapshot.data?.wData.main?.humidity}%',
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.white),),
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
                                                        child: Text('Pressure',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),

                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 2,
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                                                        child: Text('Precipitation',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white),),
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
                                                        child: Text('${snapshot.data?.wData.main?.pressure} hPa',
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),

                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 2,
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                                        child: Text('${(snapshot.data?.dData.daily![0].pop)! * 100}%',
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.white),),
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
                                  )

                          ),

                  ],
                ),
              );
            }
            else {
              return Center(child: CircularProgressIndicator(
                  backgroundColor: Colors.amber, strokeWidth: 1),);
            }
          }
         );

  }
}
