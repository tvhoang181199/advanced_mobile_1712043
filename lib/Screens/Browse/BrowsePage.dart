import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:DARKEN/Screens/Home/HomePage.dart';
import 'package:DARKEN/Screens/Home/CoursesFiltered.dart';
import 'package:DARKEN/Screens/Home/CourseDetail.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class Author {
  String image;
  String name;
  Author(this.image, this.name);
}

class BrowsePage extends StatefulWidget{
  static String tag = '/browse-page';

  @override _BrowsePage createState() => new _BrowsePage();
}

class _BrowsePage extends State<BrowsePage>{

  final suggestionList = <Course>[
    Course(Image.asset('assets/Courses/appium-1.png', fit: BoxFit.cover), 'Mobile Testing with Appium', null, 0),
    Course(Image.asset('assets/Courses/golang-1.png', fit: BoxFit.cover), 'Golang Basic', null, 0),
    Course(Image.asset('assets/Courses/java-1.png', fit: BoxFit.cover), 'Java Basic', null, 0),
    Course(Image.asset('assets/Courses/unity-1.jpg', fit: BoxFit.cover), 'Game development with Unity', null, 0),
    Course(Image.asset('assets/Courses/swift-1.png', fit: BoxFit.cover), 'Swift Basic', null, 0),
    Course(Image.asset('assets/Courses/python-1.jpg', fit: BoxFit.cover), 'Python Basic', null, 0),
    Course(Image.asset('assets/Courses/python-2.jpg', fit: BoxFit.cover), 'Python Advanced', null, 0),
  ];
  final skillList = ['C++','Swift','Python', 'Flutter', 'ASP.NET Core','Machine Learning','JavaScript'];
  final authorList = <Author>[
    Author('assets/Icons/default-avatar.png', 'PHHAI'),
    Author('assets/Icons/default-avatar.png', 'PHHAI'),
    Author('assets/Icons/default-avatar.png', 'PHHAI'),
    Author('assets/Icons/default-avatar.png', 'PHHAI'),
    Author('assets/Icons/default-avatar.png', 'PHHAI'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: ListView.builder  (
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
                          "assets/HomePage/java-1.png",
                        ),
                        unpressedImage: Image.asset(
                          "assets/HomePage/python-2.jpg", ),
                        onTap: () {
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => CoursesFiltered()
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
                          "assets/HomePage/digital-marketing-1.jpg",
                        ),
                        unpressedImage: Image.asset(
                          "assets/HomePage/python-1.jpg",),
                        onTap: () {
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => CoursesFiltered()
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
                      items: suggestionList.map((item) =>
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => CourseDetailPage()
                                  )
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: item.image,
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
                                    item.name,
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
                              Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => CoursesFiltered()
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
                                Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => CoursesFiltered()
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
                                                  backgroundImage: AssetImage(authorList[index].image),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                          authorList[index].name,
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
        ),
      ),
    );
  }
}