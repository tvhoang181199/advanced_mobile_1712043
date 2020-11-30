import 'package:DARKEN/Models/ListCoursesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class HomePage extends StatefulWidget {
  static String tag = '/home-page';

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  var _homePageKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Navigator(
            key: _homePageKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/course-detail-page') {
                return MaterialPageRoute(builder: (context) => CourseDetailPage());
              } else {
                return MaterialPageRoute(
                  builder: (context) => SafeArea(
                      child:  ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              'TRENDING',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Consumer<ListCoursesModel>(
                              builder: (context, listCourses, _) {
                                return CarouselSlider(
                                  options: CarouselOptions(
                                    height: 200,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 4),
                                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    onPageChanged: null,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: listCourses.listCourses.sublist(0, 5).map((item) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                            onTap: (){
                                              _homePageKey.currentState.push(
                                                  MaterialPageRoute(
                                                    fullscreenDialog: true,
                                                    builder: (context) => CourseDetailPage(),
                                                    settings: RouteSettings(
                                                      arguments: item,
                                                    ),
                                                  )
                                              );
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: AppColors.greyColor,
                                                      width: 1,
                                                    )
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(5),
                                                              topRight: Radius.circular(5),
                                                            )
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(5),
                                                              topRight: Radius.circular(5),
                                                            ),
                                                            child: Image.asset(item.imageUrl, fit: BoxFit.cover,)
                                                        ),
                                                      ),
                                                      Container(
                                                          height: 48,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                item.title,
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                )
                                            )
                                        );
                                      },
                                    );
                                  }).toList(),
                                );
                              }
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                            child: Text(
                              'Programming',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Consumer<ListCoursesModel>(
                            builder: (context, listCourses, _) {
                              return CarouselSlider(
                                options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlay: false,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: false,
                                  onPageChanged: null,
                                  scrollDirection: Axis.horizontal,
                                ),
                                items: listCourses.listCourses.sublist(4, 9).map((item) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                          onTap: (){
                                            _homePageKey.currentState.push(
                                                MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) => CourseDetailPage(),
                                                  settings: RouteSettings(
                                                    arguments: item,
                                                  ),
                                                )
                                            );
                                          },
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              margin: EdgeInsets.only(left: 0, right: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: AppColors.greyColor,
                                                    width: 1,
                                                  )
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(5),
                                                            topRight: Radius.circular(5),
                                                          )
                                                      ),
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(5),
                                                            topRight: Radius.circular(5),
                                                          ),
                                                          child: Image.asset(item.imageUrl, fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 38,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              item.title,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    )
                                                  ],
                                                ),
                                              )
                                          )
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                            child: Text(
                              'Bussiness',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Consumer<ListCoursesModel>(
                            builder: (context, listCourses, _) {
                              return CarouselSlider(
                                options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlay: false,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: false,
                                  onPageChanged: null,
                                  scrollDirection: Axis.horizontal,
                                ),
                                items: listCourses.listCourses.sublist(9,12).map((item) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                          onTap: (){
                                            _homePageKey.currentState.push(
                                                MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) => CourseDetailPage(),
                                                  settings: RouteSettings(
                                                    arguments: item,
                                                  ),
                                                )
                                            );
                                          },
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              margin: EdgeInsets.only(left: 0, right: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: AppColors.greyColor,
                                                    width: 1,
                                                  )
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(5),
                                                            topRight: Radius.circular(5),
                                                          )
                                                      ),
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(5),
                                                            topRight: Radius.circular(5),
                                                          ),
                                                          child: Image.asset(item.imageUrl, fit: BoxFit.cover,)
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 38,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              item.title,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    )
                                                  ],
                                                ),
                                              )
                                          )
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      )
                  ),
                );
              }
            }
        )
    );
  }
}
