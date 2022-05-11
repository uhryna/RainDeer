
//import 'dart:html';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> _refresh(){
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController();
    return  Material(
      elevation: 0,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/weather_correspondent_images/rainy.png"),
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
                opacity: 0.1),

          ),
          child: Column(
            children: [
              AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: null, icon: Icon(Icons.add)),
                    Column(
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
                            // strokeWidth: 5,
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.transparent.withOpacity(0),
              ),
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
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 120, 0, 5),
                                  child: Text('Lviv', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400)),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 2, 0, 0),
                                  child: Text('22°', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w600)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
 /*Container(
  color: Colors.white,
  child: (Row(
    children: <Widget>[
      // ...
      Expanded(
        child: Column(
          children: <Widget>[
            Text("Book Name"),
            Text("Author name"),
            Divider(
              color: Colors.black
            )
          ],
        ),
      )
    ],
  )),
);*/
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.umbrella),
                                    onPressed: () { },
                                    label: Text('bruh'),
                                  ),
                                  Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                        child: Text('Rainy', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                                  child: Text('Feels like 19°', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
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
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
