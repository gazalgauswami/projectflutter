import 'package:flutter/material.dart';
import 'package:projectflutter/main/profile.dart';
import '../detail/fruit.dart';
import 'cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FruitPage(),
    CartPage(),
    ProfilePage(),
  ];
  void _onitemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home Page",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart Page",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile Page"),
          ],
          elevation: 5,
          iconSize: 30.00,
          currentIndex: _selectedindex,
          onTap: _onitemTapped,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedindex),
        ),
      ),
    );
  }
}
