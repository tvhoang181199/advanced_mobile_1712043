import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseModelOnline.dart';
import 'package:DARKEN/Models/CourseWithLessonModel.dart';
import 'package:DARKEN/Models/UserFavoriteCoursesModel.dart';
import 'package:DARKEN/Models/UserProcessCoursesModel.dart';
import 'package:DARKEN/Screens/Home/LessonPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

import "package:http/http.dart" as http;

class UserCourseDetailPage extends StatefulWidget {
  static String tag = '/user-course-detail-page';

  final String courseID;
  UserCourseDetailPage({Key key, @required this.courseID}) : super(key: key);

  @override
  _UserCourseDetailPage createState() => new _UserCourseDetailPage(courseID);
}

class _UserCourseDetailPage extends State<UserCourseDetailPage> {
  String courseID;
  _UserCourseDetailPage(this.courseID);

  bool _isLoading = false;

  CourseWithLessonModel course;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    course = await APIServer().fetchCourseWithLession(courseID);
    setState(() {
      _isLoading = false;
    });
  }

  @override void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator = _isLoading ? new Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
        Align(
          child: Container(
            color: Colors.grey[700],
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new CircularProgressIndicator()
                )
            ),
          ),
          alignment: FractionalOffset.center,
        )
      ],
    ) : new Container();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          course == null ? "" : "${course.title.toUpperCase()}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: Stack(
        children: <Widget>[
          course == null ? Container() : Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(course.imageUrl, fit: BoxFit.fitHeight),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "DESCRIPTION",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(course.description),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text("Rating: " + course.ratedNumber.toString()),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text("Total hours: " + course.totalHours.toString()),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text("Requirement: " + course.requirement.map((e) => e).toString()),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "SESSIONS",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor
                        ),
                      ),
                    ),
                    course == null ? Container() : Container(
                        height: course.section.length.toDouble()*60,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: course.section.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child : GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => LessonPage(section: course.section[index], videoURL: course.promoVidUrl)
                                          )
                                      );
                                    },
                                    child: Card(
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "Session ${index+1}: " + course.section[index].name,
                                                  style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          )
                                      ),
                                    )
                                )
                            );
                          },
                        )
                    )
                  ],
                ),
              )
          ),
          Align(
              child: loadingIndicator,
              alignment: FractionalOffset.center
          )
        ],
      ),
    );
  }
}