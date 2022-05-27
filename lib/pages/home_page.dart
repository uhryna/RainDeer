//import 'dart:js';
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
                               //TODO flutterfire_ui з репозиторія в локал сторедж;
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<LocationsList>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, "/locations");
          },
          icon: Icon(Icons.add,),
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
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  /*SmoothPageIndicator(
                    controller: PageController(),
                    count: 4,
                    effect: WormEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      type: WormType.thin,
                    ),
                  ),*/
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
                onSelected: (choice) {
                  switch (choice) {
                    case 0:
                      Navigator.pushNamed(context, "/test"); //TODO ✔розібратися з анімацією, але здається, що вирішення немає
                      break;
                    case 1:
                      Navigator.pushNamed(context, "/settings"); //TODO ✔розібратися з анімацією, але здається, що вирішення немає
                      break;
                  // other cases...
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
                  builder: (context, locations, child) =>PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: PageController(),
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

  late Future<AllData> future;

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
    return FutureBuilder<AllData>(
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
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 50, 0, 5),
                                              child: Text(
                                                  '${snapshot.data?.wData.name}',
                                                  //TODO можна зробити свій future для кожної сторінки
                                                  style: TextStyle(
                                                      fontSize: 35,
                                                      fontWeight: FontWeight
                                                          .w400)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 2, 0, 0),
                                              child: Text(
                                                  '${snapshot.data?.wData.main
                                                      ?.temp
                                                      ?.round()}°',
                                                  style: TextStyle(
                                                      fontSize: 80,
                                                      fontWeight: FontWeight
                                                          .w600)),
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(13, 0, 0, 0),
                                                    child: SizedBox.fromSize(
                                                      size: Size(82, 82),
                                                      child: ClipOval(
                                                        child: Material(
                                                          color: Colors.white,
                                                          child: Ink(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(41),
                                                                border: Border
                                                                    .all(
                                                                  color: const Color(
                                                                      0xFF1B1B1B),
                                                                  width: 1,
                                                                )
                                                            ),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .blueAccent
                                                                  .withOpacity(
                                                                  0.1),
                                                              onTap: () {
                                                                Navigator
                                                                    .pushNamed(
                                                                    context,
                                                                    '/wardrobe');
                                                                print(
                                                                    snapshot.data
                                                                        ?.wData
                                                                        .main
                                                                        ?.temp);
                                                                //print(ParseDate.parseDate(date);
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                children: <
                                                                    Widget>[
                                                                  Icon(Icons
                                                                      .umbrella_outlined),
                                                                  Text(
                                                                      "Wardrobe"),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .fromLTRB(
                                                          0, 20, 0, 0),
                                                      child: Text(
                                                          '${snapshot.data?.wData
                                                              .weather![0].main}',
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight: FontWeight
                                                                  .w400)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .fromLTRB(
                                                          15, 15, 0, 15),
                                                      child: Text(
                                                          'Feels like ${snapshot
                                                              .data
                                                              ?.wData.main
                                                              ?.feelsLike
                                                              ?.round()}°',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight
                                                                  .w400)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          Divider(thickness: 3, height: 25,),
                                          //TODO ClipOval
                                          SizedBox(
                                            height: (MediaQuery
                                                .of(context)
                                                .size
                                                .width) / 5,
                                            child: ListView
                                                .builder( //TODO винести в окремий віджет, зробити ліствью, передати дані з масиву в білдер
                                                scrollDirection: Axis.horizontal,
                                                itemCount: 12,
                                                itemBuilder: (
                                                    BuildContext context,
                                                    int index) {
                                                  return Row(
                                                    children: [
                                                      Container(
                                                        height: (MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width) / 5,
                                                        width: (MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width) / 4,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(DateParser
                                                                .parseDate(
                                                                snapshot.data
                                                                    ?.aData
                                                                    .listb![index]
                                                                    .dt)),
                                                            Icon(Icons.cloud),
                                                            //TODO зробити іконки
                                                            Text('${snapshot.data
                                                                ?.aData
                                                                .listb![index]
                                                                .main?.temp
                                                                ?.round()}°')
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }

                                            ),
                                          ),
                                          Divider(thickness: 3, height: 25,),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 8
                                                , 0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                              ),
                                              color: Colors.white,
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .all(8.0),
                                                          child: Icon(
                                                              Icons
                                                                  .calendar_today),
                                                        ),
                                                        Text(
                                                          '7-day forecast',
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data!
                                                                        .dData
                                                                        .daily![0]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![0]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![0]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data
                                                                        ?.dData
                                                                        .daily![1]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![1]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![1]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data
                                                                        ?.dData
                                                                        .daily![2]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![2]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![2]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data
                                                                        ?.dData
                                                                        .daily![3]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![3]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![3]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data
                                                                        ?.dData
                                                                        .daily![4]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![4]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![4]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data
                                                                        ?.dData
                                                                        .daily![5]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![5]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![5]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 0, height: 25,),
                                                    Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 0, 10, 0),
                                                                child: Icon(Icons
                                                                    .wb_sunny_outlined), //TODO зробити іконки
                                                              ),
                                                              Text(
                                                                '${DayParser
                                                                    .parseDay(
                                                                    snapshot.data
                                                                        ?.dData
                                                                        .daily![6]
                                                                        .dt)}',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(alignment: Alignment
                                                            .centerRight,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 0, 10,
                                                                  0),
                                                              child: Text(
                                                                '${snapshot
                                                                    .data?.dData
                                                                    .daily![6]
                                                                    .temp?.max
                                                                    ?.round()}°/${snapshot
                                                                    .data?.dData
                                                                    .daily![6]
                                                                    .temp?.min
                                                                    ?.round()}°',
                                                                style: TextStyle(
                                                                    fontSize: 20),),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                      child: InkWell(
                                                        child: Text(
                                                          '${DateParser.parseDate(
                                                              snapshot.data?.wData
                                                                  .sys
                                                                  ?.sunrise)} AM',
                                                          // AM',
                                                          style: TextStyle(
                                                            fontSize: 30,
                                                            fontWeight: FontWeight
                                                                .w300,
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
                                                      '${DateParser.parseDate(
                                                          snapshot.data?.wData.sys
                                                              ?.sunset)} PM',
                                                      // PM',     //
                                                      style: TextStyle(
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
                                                    child: Text(
                                                      '${snapshot.data?.wData.wind
                                                          ?.speed} km/h',
                                                      style: TextStyle(
                                                          fontSize: 30,
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
                                                      '${snapshot.data?.wData.main
                                                          ?.humidity}%',
                                                      style: TextStyle(
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
                                                    child: Text('Precipitation',
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
                                                    child: Text(
                                                      '${snapshot.data?.wData.main
                                                          ?.pressure} hPa',
                                                      style: TextStyle(
                                                          fontSize: 30,
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
                                                      '${(snapshot.data?.dData
                                                          .daily![0].pop)! *
                                                          100}%',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight: FontWeight
                                                              .w300),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(thickness: 3, height: 25,),
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
