import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseModelOnline.dart';
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
  List<CourseModelOnline> favoriteCourses;
  List<CourseModelOnline> myCourses;

  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    recommendedCourses = await APIServer().fetchTopSellCourses(10, 1);
    favoriteCourses = await APIServer().fetchFavoriteCourse();
    myCourses = await APIServer().fetchMyCourse();

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
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
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
                                    onTap: () {},
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
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                          child: Text(
                            'FAVORITES COURSES',
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                          items: favoriteCourses.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                    onTap: () {},
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
                              fontSize: 25,
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
                                                      child: Image.network(myCourses[index].imageUrl),
                                                    ),
                                                  ),

                                                  Expanded(
                                                      child: Container(
                                                          padding: EdgeInsets.all(5),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(myCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                              Text(myCourses[index].subtitle, style: TextStyle(fontSize: 10)),
                                                              Text('Rated: ' + myCourses[index].ratedNumber.toString(), style: TextStyle(fontSize: 10)),
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
