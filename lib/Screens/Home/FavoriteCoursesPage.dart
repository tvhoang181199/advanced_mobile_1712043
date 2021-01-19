import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/UserFavoriteCoursesModel.dart';
import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Styling/AppColors.dart';

import 'package:http/http.dart' as http;

class FavoriteCoursesPage extends StatefulWidget {
  static String tag = '/favorite-courses-page';

  final String cateID;
  FavoriteCoursesPage({Key key, @required this.cateID}) : super(key: key);

  @override
  _FavoriteCoursesPage createState() => new _FavoriteCoursesPage(cateID);
}

class _FavoriteCoursesPage extends State<FavoriteCoursesPage> {

  String cateID;
  _FavoriteCoursesPage(this.cateID);

  bool _isLoading = false;
  List<UserFavoriteCoursesModel> listCourses;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    listCourses = await APIServer().fetchUserFavoriteCourses();

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
            cateID,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: listCourses != null ? listCourses.length : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => CourseDetailPage(courseID: listCourses[index].id)
                              )
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: 120,
                            child: Card(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 13/9,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)
                                          ),
                                          child: Image.network(listCourses[index].courseImage),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(listCourses[index].courseTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                                                  Text('Instructor: ' + listCourses[index].instructorName.toString(), style: TextStyle(fontSize: 10)),
                                                  // RatingBox(),
                                                ],
                                              )
                                          )
                                      )
                                    ]
                                )
                            )
                        ),
                      );
                    }
                )
            ),
            Align(
                child: loadingIndicator,
                alignment: FractionalOffset.center
            )
          ],
        )
    );
  }
}