import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
              SliverAppBar(
                expandedHeight: 130,
                flexibleSpace:
                FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.fadeTitle
                  ],
                  background: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(30,10,0,10),
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
               bottom: PreferredSize(                       // Add this code
                 preferredSize: Size.fromHeight(70.0),      // Add this code
                 child: Text(''),                           // Add this code
               ),
               pinned: true,
               automaticallyImplyLeading: false,
               elevation: 0,
               floating: true,
               expandedHeight: 75,
               flexibleSpace: Align(
                 alignment: Alignment.centerLeft,
                 child: Padding(
                 padding: const EdgeInsets.fromLTRB(30,0,30,0),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.pushNamed(context, "/search");

                   },
                   child: Card(
                     elevation: 0,
                     shape: RoundedRectangleBorder(
                       side: BorderSide(color: Colors.black, width: 1),
                       borderRadius: BorderRadius.circular(15.0),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.fromLTRB(12,12,12,12),
                       child: Row(
                         children: [
                           Icon(Icons.search),
                           Text(
                               'Enter Location'
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 ),
               ),
              // Make the initial height of the SliverAppBar larger than normal.

            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
               return Padding(
                 padding:  EdgeInsets.fromLTRB(10,0,10,0),
                 child: Card(
                   elevation: 0,
                   child: ListTile(
                     isThreeLine: true,
                     shape: RoundedRectangleBorder(
                       side: BorderSide(color: Colors.black, width: 1),
                       borderRadius: BorderRadius.circular(20),),
                     onTap: () {},
                     tileColor: Colors.white,
                     title: Text('Lviv', style: TextStyle(fontSize: 30, color: Colors.black),),
                     leading: Icon(Icons.wb_sunny_outlined, color: Colors.black,),
                     subtitle: Text('25° / 17°', style: TextStyle(fontSize: 20, color: Colors.black),),
                     trailing: Text('23°', style: TextStyle(fontSize: 45, color: Colors.black),),
                   ),
                 ),
               );
              },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
