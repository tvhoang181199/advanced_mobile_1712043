import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:DARKEN/Screens/Home/HomePage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class CoursesFiltered extends StatefulWidget {
  static String tag = '/courses-filtered-page';

  @override
  _CoursesFiltered createState() => new _CoursesFiltered();
}

class _CoursesFiltered extends State<CoursesFiltered> {
  @override
  Widget build(BuildContext context) {

    final searchList = <Course>[
      Course(Image.asset('assets/HomePage/appium-1.png', fit: BoxFit.cover), 'Mobile Testing with Appium', 'phhai', 12),
      Course(Image.asset('assets/HomePage/google-ads-1.png', fit: BoxFit.cover), 'Google Ads', 'phhai', 3),
      Course(Image.asset('assets/HomePage/digital-marketing-1.jpg', fit: BoxFit.cover), 'Digital Marketing Basic', 'phhai', 2),
      Course(Image.asset('assets/HomePage/unity-1.jpg', fit: BoxFit.cover), 'Game development with Unity', 'phhai', 10),
      Course(Image.asset('assets/HomePage/swift-1.png', fit: BoxFit.cover), 'Swift Basic', 'phhai', 10),
      Course(Image.asset('assets/HomePage/python-1.jpg', fit: BoxFit.cover), 'Python Basic', 'phhai', 15),
      Course(Image.asset('assets/HomePage/python-2.jpg', fit: BoxFit.cover), 'Python Advanced', 'phhai', 15),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'COURSES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (context, index) {
                return Container(
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
                                  child: searchList[index].image,
                                ),
                              ),

                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(searchList[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text('Teacher: '+ searchList[index].lecturer),
                                          Text('Total videos: '+ searchList[index].videos.toString()),
                                          // RatingBox(),
                                        ],
                                      )
                                  )
                              )
                            ]
                        )
                    )
                );
              }
          ),
        )
    );
  }
}