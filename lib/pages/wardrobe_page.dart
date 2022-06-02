import 'package:flutter/material.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({Key? key}) : super(key: key);

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  @override
  int selectedIndex = 0;
  final screens = [
    SizedBox(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_images/wardrobe.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
            child: Text('wardrobe'),
          ),
      ),
    ),
    SizedBox(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_images/wardrobe.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text('wardrobe'),
        ),
      ),
    ),

  ];
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        ),                 //TODO зробити сторінku
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.accessible),
            label: 'Outfits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Wardrobe',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        ),
      ),
    );
  }
}
