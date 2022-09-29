import 'package:flutter/material.dart';
import 'package:new_test/models/wardrobe.dart';
import 'package:new_test/pages/locations_page.dart';

class WardrobePage extends StatefulWidget {

  final Wardrobe wardrobe;

  const WardrobePage({Key? key, required this.wardrobe}) : super(key: key);
  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {

  _WardrobePageState();

  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black,)
            ),
            backgroundColor: Color(0xFF827397),
            elevation: 0,
            /*actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => this.widget));
                  },
                  icon: Icon(Icons.update)
              ),
            ],*/
          ),
          body: Container(
            color: Color(0xFF827397),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 20, 20),
                  child: Stack(
                    children: [
                      Text(
                        'Try wearing this:',
                        style: TextStyle(
                          fontSize: 32,
                          //color: Colors.black,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black,
                        ),
                      ),
                      Text(
                        'Try wearing this:',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                         ),
                       ),
                    ]
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.wardrobe.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Color(0xFFE9D5CA),
                            elevation: 7,
                            child:ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              leading: ImageIcon(
                                AssetImage('assets/clothes_images/${widget.wardrobe.items[index]?.itemName}.png'),
                                size: 35,
                              ),
                              title: Text(
                                  '${widget.wardrobe.items[index]?.itemName}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black
                                  ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                 ),
                Container(
                  child: SizedBox(

                    width: 100,
                    height: 100,
                    child: ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, '/mykola');
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

