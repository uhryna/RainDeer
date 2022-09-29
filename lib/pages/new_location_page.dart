import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_test/models/locations_list.dart';
import 'package:new_test/models/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../models/get_data.dart';
import '../models/icons.dart';
import 'home_page.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        LocationsList provider = context.read<LocationsList>();
        provider.init();
      }
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.popAndPushNamed(context, '/home');
              },
            icon: Icon(Icons.home)),
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            backgroundColor: Colors.white,
            expandedHeight: 130,
            flexibleSpace: FlexibleSpaceBar(
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
          SliverAppBar( //TODO зробити нормальне відображення міста через бд
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: Text(
                ''
              ),
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
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7,0,7,0),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: textController,
                            obscureText: false,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter location',
                              hintStyle: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                        Consumer<LocationsList>(
                          builder: (context, locations, child) =>
                            IconButton(
                              onPressed: () async {
                                var value = await collectAllDataCheck('${textController.text}');
                                var city = City(cityName: value?.wData.name, cityTemp: value?.wData.main?.temp?.round(), cityMinTemp: value?.wData.main?.tempMin?.round(), cityMaxTemp: value?.wData.main?.tempMax?.round());
                                if (value == null){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('We cant find this city')));
                                }
                                else{

                                  locations.addLocation('${textController.text}');
                                  print(locations.locationsList);
                                  await Preferences().setLocations(locations.locationsList);
                                  //DatabaseHelper().addCities(city);
                                }
                                textController.clear();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
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
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (context) async {
                              locations.deleteLocation(index);
                              await Preferences().setLocations(locations.locationsList);
                              //DatabaseHelper().removeCity(index);
                              print(locations.locationsList);
                            },
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            isThreeLine: false,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 1
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home(locations.locationsList.indexOf(locations.locationsList[index]))));
                              },
                            tileColor: Colors.white,
                            title: Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                child: Text(
                                '${locations.locationsList[index]}',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black
                                ),
                              ),
                            ),
                            //leading: ImageIcon(CustomIcons().showIcons(variable)),
                            //trailing: Text('${locations.locationsList[index]}°', style: TextStyle(fontSize: 45, color: Colors.black),),
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
      )
    );
  }
}