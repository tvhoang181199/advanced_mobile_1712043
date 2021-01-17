import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseModelOnline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Styling/AppColors.dart';

import 'package:http/http.dart' as http;

class CoursesFilteredPage extends StatefulWidget {
  static String tag = '/courses-filtered-page';

  final String type;
  CoursesFilteredPage({Key key, @required this.type}) : super(key: key);

  @override
  _CoursesFilteredPage createState() => new _CoursesFilteredPage(type);
}

class _CoursesFilteredPage extends State<CoursesFilteredPage> {

  final String type;
  _CoursesFilteredPage(this.type);

  bool _isLoading = false;
  List<CourseModelOnline> listCourses;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    if (type == "TRENDING COURSES")
      listCourses = await APIServer().fetchTopNewCourses(10, 1);
    else if (type == "MADE FOR YOU")
      listCourses = await APIServer().fetchTopRateCourses(10, 1);

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
            type,
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
                        onTap: (){},
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
                                          child: Image.network(listCourses[index].imageUrl),
                                        ),
                                      ),

                                      Expanded(
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(listCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                  Text(listCourses[index].subtitle, style: TextStyle(fontSize: 10)),
                                                  Text('Rated: ' + listCourses[index].ratedNumber.toString(), style: TextStyle(fontSize: 10)),
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