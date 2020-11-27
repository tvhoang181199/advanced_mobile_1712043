import 'package:DARKEN/Models/CourseModel.dart';
import 'package:DARKEN/Models/ListCoursesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Screens/Home/CourseDetail.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class CoursesFiltered extends StatefulWidget {
  static String tag = '/courses-filtered-page';

  @override
  _CoursesFiltered createState() => new _CoursesFiltered();
}

class _CoursesFiltered extends State<CoursesFiltered> {
  List<CourseModel> _listCourses = ListCoursesModel().listCourses;

  List<CourseModel> getCoursesListWithAuthor(String author) {
    List<CourseModel> tempList = [];

    if (author == 'HOT COURSES')
      tempList = _listCourses.sublist(3,8);
    else if (author == 'MADE FOR YOU')
      tempList = _listCourses.sublist(5,10);
    else {
      if (author[0] == '0')
        _listCourses.forEach((course) {
          if (course.title.toLowerCase().contains(author.substring(1).toLowerCase()))
            tempList.add(course);
        });
      else
        _listCourses.forEach((course) {
          if (course.teacher.toLowerCase() == author.toLowerCase())
            tempList.add(course);
        });
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {

    final String _title = ModalRoute.of(context).settings.arguments;
    final List<CourseModel> _filteredList = getCoursesListWithAuthor(_title);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '${_title.substring(1)}',
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
              itemCount: _filteredList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => CourseDetailPage(),
                          settings: RouteSettings(
                            arguments: _filteredList[index],
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
                                    child: Image.asset(_filteredList[index].imageUrl),
                                  ),
                                ),

                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(_filteredList[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text('Teacher: '+ _filteredList[index].teacher),
                                            Text('Total videos: '+ _filteredList[index].videoNumber.toString()),
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
          ),
        )
    );
  }
}