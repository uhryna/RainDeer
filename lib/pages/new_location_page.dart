import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.black,)),
              backgroundColor: Colors.transparent..withOpacity(0),
              elevation: 0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30,20,0,20),
                child: Text(
                  'Manage cities',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            //TODO: картку, при нажиманні на яку, відкривається нова сторінка серч бар пейдж
            //TODO: listview.builder з картками відповідно до доданих міст / ше треба зробити окремий клас як буде виглядати лісттайл
            //TODO flutter_slidable location package
            //TODO listview+sliverappbar
            Padding(
              padding: const EdgeInsets.fromLTRB(30,0,30,30),
              child: GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/settings");
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return Card(
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
                    );
                  },
                  itemCount: 10,),
              ),
            )
          ],
        ),
      )
    );
  }
}
