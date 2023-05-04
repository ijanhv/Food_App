import 'package:food_app/pages/bag_page.dart';
import 'package:food_app/pages/home_page.dart';
import 'package:food_app/pages/profile_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';


class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
   int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HomePage(),
    // BagPage(),
    HomePage(),
    ProfilePage(),
  ];

    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(context, MaterialPageRoute(builder: (context) => _widgetOptions[index]));

    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: Color.fromARGB(255, 95, 93, 93)),
                label: 'Home',
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.near_me,
                    color: Color.fromARGB(255, 173, 170, 170)),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 173, 170, 170),
                ),
                label: 'Events'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 173, 170, 170),
                ),
                label: 'Blog'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 247, 64, 64),
          onTap: _onItemTapped,
        ),
      );
  }
}