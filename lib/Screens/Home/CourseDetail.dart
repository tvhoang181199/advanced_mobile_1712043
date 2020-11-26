import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Screens/Home/HomePage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class CourseDetailPage extends StatefulWidget {
  static String tag = '/course-detail-page';

  @override
  _CourseDetailPage createState() => new _CourseDetailPage();
}

class _CourseDetailPage extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {

    final videoList = <Course>[
      Course(Image.asset('assets/Courses/appium-1.png', fit: BoxFit.cover), 'Mobile Testing with Appium', 'phhai', 12),
      Course(Image.asset('assets/Courses/google-ads-1.png', fit: BoxFit.cover), 'Google Ads', 'phhai', 3),
      Course(Image.asset('assets/Courses/digital-marketing-1.jpg', fit: BoxFit.cover), 'Digital Marketing Basic', 'phhai', 2),
      Course(Image.asset('assets/Courses/unity-1.jpg', fit: BoxFit.cover), 'Game development with Unity', 'phhai', 10),
      Course(Image.asset('assets/Courses/swift-1.png', fit: BoxFit.cover), 'Swift Basic', 'phhai', 10),
      Course(Image.asset('assets/Courses/python-1.jpg', fit: BoxFit.cover), 'Python Basic', 'phhai', 15),
      Course(Image.asset('assets/Courses/python-2.jpg', fit: BoxFit.cover), 'Python Advanced', 'phhai', 15),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'COURSE DETAIL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.asset('assets/HomePage/python-2.jpg', fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. '
                    'Aenean commodo ligula eget dolor. Aenean massa. '
                    'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. '),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'VIDEOS',
                    style: TextStyle(
                      color: AppColors.themeColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              Container(
                height: videoList.length*100.0,
               child: ListView.builder(
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: videoList.length,
                   itemBuilder: (context, index) {
                     return Container(
                             padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                           child: videoList[index].image,
                                         ),
                                       ),
                                       Container(
                                         padding: EdgeInsets.all(10),
                                         alignment: Alignment.centerLeft,
                                         child: Text(
                                           'Video ${index}',
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontSize: 15
                                           ),
                                         ),
                                       ),
                                       Expanded(
                                           child: Container(
                                             alignment: Alignment.centerRight,
                                             child: IconButton(
                                               icon: Icon(Icons.arrow_circle_down),
                                             ),
                                           )
                                       )
                                     ]
                                 )
                             )
                     );
                   }
               ),
              )
            ],
          ),
        )
      ),
    );
  }
}