import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseModelOnline.dart';
import 'package:DARKEN/Models/UserFavoriteCoursesModel.dart';
import 'package:DARKEN/Models/UserProcessCoursesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

import "package:http/http.dart" as http;

class CourseDetailPage extends StatefulWidget {
  static String tag = '/course-detail-page';

  final String courseID;
  CourseDetailPage({Key key, @required this.courseID}) : super(key: key);

  @override
  _CourseDetailPage createState() => new _CourseDetailPage(courseID);
}

class _CourseDetailPage extends State<CourseDetailPage> {
  String courseID;
  _CourseDetailPage(this.courseID);

  bool _isLoading = false;

  bool _isLiked = false;
  bool _isJoined = false;
  CourseModelOnline course;
  List<UserFavoriteCoursesModel> favoriteCourses;
  List<UserProcessCoursesModel> processCourses;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    course = await APIServer().fetchCourseWithID(courseID);
    favoriteCourses = await APIServer().fetchUserFavoriteCourses();
    processCourses = await APIServer().fetchUserProcessCourses();
    _isLiked = favoriteCourses.where((element) => element.id == widget.courseID).toList().length == 0 ? false : true;
    _isJoined = processCourses.where((element) => element.id == widget.courseID).toList().length == 0 ? false : true;
    setState(() {
      _isLoading = false;
    });
  }

  void _likeCourseTapped() async {
    http.Response response = await APIServer().likeCourseWithID(courseID);
    if (response.statusCode == 200) {
      setState(() {
        _isLiked = true;
      });
    }
  }

  void _joinCourseTapped() async {
    http.Response response = await APIServer().joinCourseWithID(courseID);
    if (response.statusCode == 200) {
      setState(() {
        _isJoined = true;
      });
    }
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(course.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "DESCRIPTION",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(course.description),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text("Rating: " + course.ratedNumber.toString()),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text("Total hours: " + course.totalHours.toString()),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isLiked ? Container(
                            padding: EdgeInsets.only(left: 50, top: 15, right:15),
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                              onPressed: (){},
                              color: AppColors.themeColor,
                              child: Text('Liked', style: TextStyle(color: Colors.white)),
                            ),
                          ) : Container(
                            padding: EdgeInsets.only(left: 50, top: 15, right:15),
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3), side: BorderSide(color: AppColors.themeColor)),
                              onPressed: _likeCourseTapped,
                              color: Colors.white,
                              child: Text('Like', style: TextStyle(color: AppColors.themeColor)),
                            ),
                          ),
                          _isJoined ? Container(
                            padding: EdgeInsets.only(left: 15, top: 15, right: 50),
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                              onPressed: (){},
                              color: AppColors.themeColor,
                              child: Text('Joined', style: TextStyle(color: Colors.white)),
                            ),
                          ) : Container(
                            padding: EdgeInsets.only(left: 15, top: 15, right: 50),
                            height: 50,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3), side: BorderSide(color: AppColors.themeColor)),
                              onPressed: _joinCourseTapped,
                              color: Colors.white,
                              child: Text('Join', style: TextStyle(color: AppColors.themeColor)),
                            ),
                          ),
                        ],
                      ),
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