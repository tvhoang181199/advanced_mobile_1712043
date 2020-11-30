import 'package:DARKEN/Models/ListCoursesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'package:DARKEN/Screens/Home/CoursesFilteredPage.dart';
import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class BrowsePage extends StatefulWidget{
  static String tag = '/browse-page';

  @override _BrowsePage createState() => new _BrowsePage();
}

var browsePageKey = GlobalKey<NavigatorState>();

class _BrowsePage extends State<BrowsePage>{

  final skillList = ['Swift','Python', 'Flutter', 'Marketing', 'Java'];
  final authorList = ['PHHai', 'NLHDung', 'TMTriet', 'KMCanh'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
            key: browsePageKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/course-detail-page') {
                return MaterialPageRoute(builder: (context) => CourseDetailPage());
              }
              else if (settings.name == '/courses-filtered-page') {
                return MaterialPageRoute(builder: (context) => CoursesFilteredPage());
              }
              else {
                return MaterialPageRoute(
                    builder: (context) => Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Consumer<ListCoursesModel>(
                            builder: (context, listCourses, _) {
                              return ListView.builder  (
                                  scrollDirection: Axis.vertical,
                                  itemCount: 8,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Container(
                                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            child: ImageButton(
                                              children: <Widget>[
                                                Text('HOT COURSES', style: TextStyle(
                                                    color: Colors.white, fontSize: 30.0)),
                                              ],
                                              width: double.infinity,
                                              height: 200,
                                              paddingTop: 5,
                                              pressedImage: Image.asset(
                                                "assets/Courses/java-1.png",
                                              ),
                                              unpressedImage: Image.asset(
                                                "assets/Courses/python-2.jpg", ),
                                              onTap: () {
                                                browsePageKey.currentState.push(
                                                    MaterialPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (context) => CoursesFilteredPage(),
                                                      settings: RouteSettings(
                                                        arguments: '0HOT COURSES',
                                                      ),
                                                    )
                                                );
                                              },
                                            ),
                                          )
                                      );
                                    }
                                    else if (index == 1) {
                                      return Container(
                                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            child: ImageButton(
                                              children: <Widget>[
                                                Text('MADE FOR YOU', style: TextStyle(
                                                    color: Colors.white, fontSize: 30.0)),
                                              ],
                                              width: double.infinity,
                                              height: 200,
                                              paddingTop: 5,
                                              pressedImage: Image.asset(
                                                "assets/Courses/digital-marketing-1.jpg",
                                              ),
                                              unpressedImage: Image.asset(
                                                "assets/Courses/python-1.jpg",),
                                              onTap: () {
                                                browsePageKey.currentState.push(
                                                    MaterialPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (context) => CoursesFilteredPage(),
                                                      settings: RouteSettings(
                                                        arguments: '0MADE FOR YOU',
                                                      ),
                                                    )
                                                );
                                              },
                                            ),
                                          )
                                      );
                                    }
                                    else if (index == 2) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                        child: Text('Courses', style: TextStyle(
                                            color: AppColors.themeColor,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold)),
                                      );
                                    }
                                    else if (index == 3) {
                                      return  Container (
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: CarouselSlider(
                                            options: CarouselOptions(
                                              aspectRatio: 2,
                                              enlargeCenterPage: true,
                                              scrollDirection: Axis.horizontal,
                                            ),
                                            items: listCourses.listCourses.sublist(1,7).map((item) =>
                                                GestureDetector(
                                                  onTap: (){
                                                    browsePageKey.currentState.push(
                                                        MaterialPageRoute(
                                                          fullscreenDialog: true,
                                                          builder: (context) => CourseDetailPage(),
                                                          settings: RouteSettings(
                                                            arguments: item,
                                                          ),
                                                        )
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                          alignment: Alignment.bottomCenter,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            child: Image.asset(item.imageUrl, fit: BoxFit.cover),
                                                          )
                                                      ),
                                                      Container(
                                                          alignment: Alignment.center,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                gradient: LinearGradient(
                                                                  colors: [
                                                                    Color.fromRGBO(255, 255, 255, 0),
                                                                    Color.fromRGBO(0, 0, 0, 0.7),
                                                                  ],
                                                                  begin: Alignment.center,
                                                                  end: Alignment.bottomCenter,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                                                        alignment: Alignment.bottomLeft,
                                                        child: Text(
                                                          item.title,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )).toList()
                                        ),
                                      );
                                    }
                                    else if (index == 4) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                        child: Text(
                                            'Skills',
                                            style: TextStyle(
                                                color: AppColors.themeColor,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold)
                                        ),
                                      );
                                    }
                                    else {
                                      if (index == 5) {
                                        return Container(
                                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                          height: MediaQuery.of(context).size.height*0.065,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: skillList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    browsePageKey.currentState.push(
                                                        MaterialPageRoute(
                                                          fullscreenDialog: true,
                                                          builder: (context) => CoursesFilteredPage(),
                                                          settings: RouteSettings(
                                                            arguments: '0${skillList[index]}',
                                                          ),
                                                        )
                                                    );
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*0.5,
                                                    child: Card(
                                                      color: AppColors.buttonColor,
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            skillList[index],
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.0
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                        );
                                      }
                                      else {
                                        if (index == 6) {
                                          return Container(
                                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                            child: Text(
                                                'Top Author',
                                                style: TextStyle(
                                                    color: AppColors.themeColor,
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold)),
                                          );
                                        }
                                        else {
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: authorList.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      browsePageKey.currentState.push(
                                                          MaterialPageRoute(
                                                            fullscreenDialog: true,
                                                            builder: (context) => CoursesFilteredPage(),
                                                            settings: RouteSettings(
                                                              arguments: '1${authorList[index]}',
                                                            ),
                                                          )
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(right: 15.0),
                                                      child: Card(
                                                          child: Container(
                                                            child: Center(
                                                                child: Column(
                                                                    children: <Widget>[
                                                                      CircleAvatar(
                                                                        radius: 50,
                                                                        backgroundImage: AssetImage('assets/Icons/default-avatar.png'),
                                                                      ),
                                                                      Expanded(
                                                                          child: Container(
                                                                            alignment: Alignment.center,
                                                                            child: Text(
                                                                                authorList[index],
                                                                                style: TextStyle(
                                                                                  fontSize: 10.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                )
                                                                            ),
                                                                          )
                                                                      ),
                                                                    ]
                                                                )
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  }
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