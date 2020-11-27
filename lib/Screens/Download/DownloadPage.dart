import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Screens/Home/CourseDetail.dart';
import 'package:DARKEN/Screens/Home/HomePage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class DownloadPage extends StatefulWidget {
  static String tag = '/download-page';

  @override
  _DownloadPage createState() => new _DownloadPage();
}

class _DownloadPage extends State<DownloadPage> {

  final downloadedList = <Course>[
    Course(Image.asset('assets/Courses/appium-1.png', fit: BoxFit.cover), 'Mobile Testing with Appium', 'phhai', 12),
    Course(Image.asset('assets/Courses/google-ads-1.png', fit: BoxFit.cover), 'Google Ads', 'phhai', 3),
    Course(Image.asset('assets/Courses/digital-marketing-1.jpg', fit: BoxFit.cover), 'Digital Marketing Basic', 'phhai', 2),
    Course(Image.asset('assets/Courses/unity-1.jpg', fit: BoxFit.cover), 'Game development with Unity', 'phhai', 10),
    Course(Image.asset('assets/Courses/swift-1.png', fit: BoxFit.cover), 'Swift Basic', 'phhai', 10),
    Course(Image.asset('assets/Courses/python-1.jpg', fit: BoxFit.cover), 'Python Basic', 'phhai', 15),
    Course(Image.asset('assets/Courses/python-2.jpg', fit: BoxFit.cover), 'Python Advanced', 'phhai', 15),
  ];

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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: downloadedList.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => CourseDetailPage(),
                                      settings: RouteSettings(
                                        arguments: i,
                                      ),
                                    )
                                );
                              },
                              child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              height: 100,
                              child: Card(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        AspectRatio(
                                          aspectRatio: 16/9,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)
                                            ),
                                            child: downloadedList[i].image,
                                          ),
                                        ),

                                        Expanded(
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(downloadedList[i].name, style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('Teacher: '+ downloadedList[i].lecturer),
                                                    Text('Total videos: '+ downloadedList[i].videos.toString()),
                                                    // RatingBox(),
                                                  ],
                                                )
                                            )
                                        )
                                      ]
                                  )
                              )
                          )
                          );
                        }
                    ),
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}