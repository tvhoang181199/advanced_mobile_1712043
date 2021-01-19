import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseModelOnline.dart';
import 'package:DARKEN/Models/UserFavoriteCoursesModel.dart';
import 'package:DARKEN/Models/UserProcessCoursesModel.dart';
import 'package:DARKEN/Screens/Home/FavoriteCoursesPage.dart';
import 'package:DARKEN/Screens/Home/UserCourseDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class HomePage extends StatefulWidget {
  static String tag = '/home-page';

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  List<CourseModelOnline> recommendedCourses;
  List<UserFavoriteCoursesModel> favoriteCourses;
  List<UserProcessCoursesModel> myCourses;

  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    recommendedCourses = await APIServer().fetchTopSellCourses(15, 1);
    favoriteCourses = await APIServer().fetchUserFavoriteCourses();
    myCourses = await APIServer().fetchUserProcessCourses();

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
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              'RECOMMENDED',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          (recommendedCourses == null) ? Container(height: 230) : CarouselSlider(
                            options: CarouselOptions(
                              height: 230,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration: Duration(milliseconds: 1500),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              onPageChanged: null,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: recommendedCourses.map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) => CourseDetailPage(courseID: item.id)
                                            )
                                        ).then((value) => _fetchData());
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
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Container(
                                                  height: 170,
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
                                                      child: Image.network(item.imageUrl, fit: BoxFit.cover)
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
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
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      )
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                                child: Text(
                                  'FAVORITES COURSES',
                                  style: TextStyle(
                                    color: AppColors.themeColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: OutlineButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => FavoriteCoursesPage(cateID: "FAVORITES COURSES")
                                        )
                                    );
                                  },
                                  disabledBorderColor: Colors.transparent,
                                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  borderSide: BorderSide.none,
                                  child: Text(
                                      'See all',
                                      style: TextStyle(
                                          color: AppColors.themeColor,
                                          decoration:TextDecoration.underline,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                          (favoriteCourses == null || favoriteCourses.length == 0) ? Container(
                            height: 50,
                            child: Center(
                              child: Text("NO FAVORITE COURSES FOUND!", style: TextStyle(color: AppColors.greyColor, fontSize: 15)),
                            ),
                          ) : CarouselSlider(
                            options: CarouselOptions(
                              height: 190,
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
                            items: favoriteCourses.length <= 5 ? favoriteCourses.map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) => CourseDetailPage(courseID: item.id)
                                            )
                                        ).then((value) => _fetchData());
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
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Container(
                                                  height: 140,
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
                                                      child: Image.network(item.courseImage, fit: BoxFit.cover)
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              item.courseTitle,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    )
                                                )
                                              ],
                                            ),
                                          )
                                      )
                                  );
                                },
                              );
                            }).toList() : favoriteCourses.sublist(0,5).map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) => CourseDetailPage(courseID: item.id)
                                            )
                                        ).then((value) => _fetchData());
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
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Container(
                                                  height: 140,
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
                                                      child: Image.network(item.courseImage, fit: BoxFit.cover)
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              item.courseTitle,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        )
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
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                            child: Text(
                              'MY COURSES',
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          (myCourses == null || myCourses.length == 0) ? Container(
                            height: 50,
                            child: Center(
                              child: Text("NO COURSES FOUND!", style: TextStyle(color: AppColors.greyColor, fontSize: 15)),
                            ),
                          ) : Container(
                              height: myCourses.length*120.0,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: myCourses.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) => UserCourseDetailPage(courseID: myCourses[index].id)
                                            )
                                        ).then((value) => _fetchData());
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
                                                        child: Image.network(myCourses[index].courseImage),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                            padding: EdgeInsets.all(5),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text(myCourses[index].courseTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                Text("Instructor: " + myCourses[index].instructorName, style: TextStyle(fontSize: 10)),
                                                                Text("Process: " + myCourses[index].process.toString(), style: TextStyle(fontSize: 10)),
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
                        ],
                      ),
                    ),
                  )
              ),
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
