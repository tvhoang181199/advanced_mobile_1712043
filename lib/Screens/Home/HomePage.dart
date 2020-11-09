import 'package:flutter/material.dart';
import 'package:DARKEN/Screens/Download/DownloadPage.dart';
import 'package:DARKEN/Screens/Browse/BrowsePage.dart';
import 'package:DARKEN/Screens/Account/ProfilePage.dart';
import 'package:DARKEN/Screens/Search/SearchPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class HomePage extends StatefulWidget {
  static String tag = '/home-page';

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child:  Text("Home"),
      )

    );
  }
}