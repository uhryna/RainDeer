import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_test/models/locations_list.dart';
import 'package:provider/provider.dart';
import '../models/get_data.dart';
import '../repository/data_provider.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => LocationsPageState();
}

class LocationsPageState extends State<LocationsPage> {

  TextEditingController textController = new TextEditingController();
  late Future<AllData> future;

  @override
  void initState() {
    super.initState();
    //future = collectAllData('Kharkiv');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: /*FutureBuilder<AllData>(
        future: future,
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return Center(child: CircularProgressIndicator(
                backgroundColor: Colors.blue, strokeWidth: 1),);
          }
          else if (snapshot.connectionState == ConnectionState.active) {
            print('active');
            return Center(child: CircularProgressIndicator(
                backgroundColor: Colors.blue, strokeWidth: 1),);
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            print('done');
            return */CustomScrollView( //TODO додати, шоб зверху писало, коли звужується//ше треба зробити окремий клас як буде виглядати лісттай
              slivers: [ //TODO ✔flutter_slidable location package
                SliverAppBar( //TODO ✔listview+sliverappbar
                  expandedHeight: 130,
                  flexibleSpace:
                  FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.fadeTitle
                    ],
                    background: Align(
                      alignment: Alignment.bottomLeft,      //TODO ✔як зробити запити для всіх міст/першу сторінку для вибору початкового міста/забирати дані для другої+ сторінок
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
                SliverAppBar(
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
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              Expanded(
                                child: TextField(
                                  controller: textController,
                                  obscureText: false,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'enter a new city',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                //var instance = FinalData().getFinalData(textController.text);
                                return context.read<LocationsList>().addLocation('${textController.text}');
                              },
                                icon: Icon(Icons.add)
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
                                  onPressed: (context){
                                    locations.locationsList.removeAt(index);
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
                                          fontSize: 30, color: Colors.black),),       //TODO як зробити шоб
                                    leading: Icon(Icons.wb_sunny_outlined, color: Colors.black,),
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
    )
    );
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