//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_test/models/locations_list.dart';
import 'package:new_test/models/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/get_data.dart';
import '../models/icons.dart';
import '../repository/data_provider.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => LocationsPageState();
}

class LocationsPageState extends State<LocationsPage> {

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LocationsList provider = context.read<LocationsList>();
      provider.init();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(onPressed: (){
                Navigator.popAndPushNamed(context, '/home');
              }, icon: Icon(Icons.home)),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              expandedHeight: 130,
              flexibleSpace:
              FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.fadeTitle
                ],
                background: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                    child: Text(
                      'Manage cities',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverAppBar( //TODO зробити нормальне відображення міста
              backgroundColor: Colors.white,
              bottom: PreferredSize( // Add this code
                preferredSize: Size.fromHeight(70.0), // Add this code
                child: Text(''), // Add this code
              ),
              pinned: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              floating: true,
              expandedHeight: 75,
              flexibleSpace: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7,0,7,0),
                            child: Icon(Icons.search, color: Colors.grey,),
                          ),
                          Expanded(
                            child: TextField(
                              controller: textController,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter location',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Consumer<LocationsList>(
                            builder: (context, locations, child) =>
                                IconButton(onPressed: () async {

                                  var value = await collectAllDataCheck('${textController.text}');
                                  if (value == null){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('We cant find the city')));
                                  }
                                  else{
                                    locations.addLocation('${textController.text}');
                                    print(locations.locationsList);
                                    await Preferences().setLocations(locations.locationsList);
                                    print(Preferences().getLocations());

                                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('We can find the city')));
                                  }
                                  textController.clear();
                                },
                                    icon: Icon(Icons.add, color: Colors.grey,)
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<LocationsList>(
              builder: (context, locations, child) =>
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Slidable(
                          enabled: index != 0,
                          endActionPane: ActionPane(
                              motion: DrawerMotion(), children: [
                            SlidableAction(
                              onPressed: (context) async {
                                locations.deleteLocation(index);
                                await Preferences().setLocations(locations.locationsList);
                                print(locations.locationsList);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ]),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                isThreeLine: false,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(20),),
                                onTap: () {},
                                tileColor: Colors.white,
                                title: Text(
                                  '${locations.locationsList[index]}',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black),),
                                //leading: ImageIcon(CustomIcons().showIcons(locations.locationsList[index]),
                                //subtitle: Text('${instance}° / $minTemp°', style: TextStyle(fontSize: 20, color: Colors.black),),
                                //trailing: Text('$temperature°', style: TextStyle(fontSize: 45, color: Colors.black),),
                              ),

                            ),
                          ),
                        );
                      },
                      childCount: locations.locationsList.length, //locations.locationsList.length,
                    ),
                  ),
            ),
          ],
          /*);
          }//
          else {//
            return SizedBox(//
              width: 60,//
              height: 60,//
              child: CircularProgressIndicator(),//
            );//
          }//
        }//
      ),*/ //tut
        ));
      }
    }

void doNothing(BuildContext context) {}
/*body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 2,
                    child: Text('$index'),
                  );
                },
              ),
            ),
          ],
        ),*/