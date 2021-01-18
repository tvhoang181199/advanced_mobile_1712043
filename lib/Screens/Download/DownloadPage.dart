import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class DownloadPage extends StatefulWidget {
  static String tag = '/download-page';

  @override
  _DownloadPage createState() => new _DownloadPage();
}

class _DownloadPage extends State<DownloadPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'DOWNLOADED',
                      // textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'There are no downloaded courses!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}