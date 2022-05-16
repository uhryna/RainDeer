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
                padding: const EdgeInsets.fromLTRB(20,20,0,40),
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
                          side: BorderSide(color: Colors.white70, width: 0),
                          borderRadius: BorderRadius.circular(20),),
                        onTap: () {},
                        tileColor: Colors.blueGrey,
                        title: Text('Lviv', style: TextStyle(fontSize: 30, color: Colors.white),),
                        leading: Icon(Icons.wb_sunny_outlined, color: Colors.white,),
                        subtitle: Text('25° / 17°', style: TextStyle(fontSize: 20, color: Colors.white),),
                        trailing: Text('23°', style: TextStyle(fontSize: 45, color: Colors.white),),
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
