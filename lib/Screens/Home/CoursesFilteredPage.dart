import 'package:DARKEN/Models/CourseModel.dart';
import 'package:DARKEN/Models/ListCoursesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';
import 'package:DARKEN/Screens/Browse/BrowsePage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class CoursesFilteredPage extends StatefulWidget {
  static String tag = '/courses-filtered-page';

  @override
  _CoursesFilteredPage createState() => new _CoursesFilteredPage();
}

class _CoursesFilteredPage extends State<CoursesFilteredPage> {

  @override
  Widget build(BuildContext context) {
    var _coursesFilteredPageKey = GlobalKey<NavigatorState>();

    final String _title = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Navigator(
            key: _coursesFilteredPageKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/course-detail-page') {
                return MaterialPageRoute(builder: (context) => CourseDetailPage());
              }
              else {
                return MaterialPageRoute(
                    builder: (context) => SafeArea(
                        child: Consumer<ListCoursesModel>(
                            builder: (context, listCourses, _) {
                              List<CourseModel> filteredList = [];

                              if (_title == '0HOT COURSES')
                                filteredList =
                                    listCourses.listCourses.sublist(3, 8);
                              else if (_title == '0MADE FOR YOU')
                                filteredList =
                                    listCourses.listCourses.sublist(5, 10);
                              else {
                                if (_title[0] == '0')
                                  listCourses.listCourses.forEach((course) {
                                    if (course.title.toLowerCase().contains(
                                        _title.substring(1).toLowerCase()))
                                      filteredList.add(course);
                                  });
                                else
                                  listCourses.listCourses.forEach((course) {
                                    if (course.teacher.toLowerCase() ==
                                        _title.substring(1).toLowerCase())
                                      filteredList.add(course);
                                  });
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    height: 60,
                                    padding: EdgeInsets.only(left: 10, right: 10,bottom: 0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              color: AppColors.themeColor,
                                              size: 25,
                                            ),
                                            onPressed: () {
                                              browsePageKey.currentState.pop();
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${_title.substring(1)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.themeColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.only(top: 20, bottom: 20),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height,
                                          child: ListView.builder(
                                              itemCount: filteredList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: (){
                                                    _coursesFilteredPageKey.currentState.push(
                                                        MaterialPageRoute(
                                                          fullscreenDialog: true,
                                                          builder: (context) => CourseDetailPage(),
                                                          settings: RouteSettings(
                                                            arguments: listCourses.listCourses[int.parse(listCourses.listCourses[int.parse(filteredList[index].id)].id)],
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
                                                                    child: Image.asset(listCourses.listCourses[int.parse(filteredList[index].id)].imageUrl),
                                                                  ),
                                                                ),

                                                                Expanded(
                                                                    child: Container(
                                                                        padding: EdgeInsets.all(5),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: <Widget>[
                                                                            Text(listCourses.listCourses[int.parse(filteredList[index].id)].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                            Text('Teacher: '+ listCourses.listCourses[int.parse(filteredList[index].id)].teacher),
                                                                            Text('Total videos: '+ listCourses.listCourses[int.parse(filteredList[index].id)].videoNumber.toString()),
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
                                      )
                                  )
                                ],
                              );
                            }
                        )
                    )
                );
              }
            }
        )
    );
  }
}