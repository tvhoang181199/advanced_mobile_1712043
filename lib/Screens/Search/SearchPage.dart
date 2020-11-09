import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class SearchPage extends StatefulWidget {
  static String tag = '/browse-page';

  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('search'),
        backgroundColor: AppColors.themeColor,
      ),
    );
  }
}