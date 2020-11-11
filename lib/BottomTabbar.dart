import 'package:flutter/material.dart';
import 'package:DARKEN/Screens/Home/HomePage.dart';
import 'package:DARKEN/Screens/Download/DownloadPage.dart';
import 'package:DARKEN/Screens/Browse/BrowsePage.dart';
import 'package:DARKEN/Screens/Account/ProfilePage.dart';
import 'package:DARKEN/Screens/Search/SearchPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';


class BottomTabbar extends StatefulWidget {
  BottomTabbar({Key key}) : super(key: key);
  static String tag = '/bottom-tabbar';

  @override
  _BottomTabbar createState() => new _BottomTabbar();
}

class _BottomTabbar extends State<BottomTabbar> {
  int _currentIndex = 0;

  List<Widget> _children = <Widget>[
    HomePage(),
    DownloadPage(),
    BrowsePage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.arrow_circle_down),
            title: new Text('Download'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.drive_file_move),
            title: new Text('Browse'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }
}