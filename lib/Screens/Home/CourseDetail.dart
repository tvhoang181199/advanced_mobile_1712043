import 'package:DARKEN/Models/CourseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class CourseDetailPage extends StatefulWidget {
  static String tag = '/course-detail-page';

  @override
  _CourseDetailPage createState() => new _CourseDetailPage();
}

class _CourseDetailPage extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final CourseModel _course = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${_course.title.toUpperCase()}',
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
                  child: Image.asset(_course.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(_course.description),
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
                height: _course.videoNumber*100.0,
               child: ListView.builder(
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: _course.videoNumber,
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
                                           child: Image.asset(_course.imageUrl),
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