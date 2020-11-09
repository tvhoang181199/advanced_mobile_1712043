import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class ProfilePage extends StatefulWidget {
  static String tag = '/account-page';

  @override
  _ProfilePage createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: AppColors.themeColor,
      ),
    );
  }
}