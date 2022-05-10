
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final PageController controller = PageController();
    return  Material(
      elevation: 0,
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
                  Text(
                    'App',
                    style: TextStyle(
                      color: Colors.black,
                    ),
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
                      child: ListView(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 120, 0, 5),
                              child: Text('Lviv', style: TextStyle(fontSize: 35,)),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 2, 0, 0),
                              child: Text('22°', style: TextStyle(fontSize: 80,)),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Text('Rainy', style: TextStyle(fontSize: 30,)),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child: Text('Feels like 19°', style: TextStyle(fontSize: 20,)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text('Second Page'),
                    ),
                    Center(
                      child: Text('Third Page'),
                    ),
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/weather_correspondent_images/rainy.png"), fit: BoxFit.contain),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(21.0),
                            child: Text('Forth Page'),
                          )
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
