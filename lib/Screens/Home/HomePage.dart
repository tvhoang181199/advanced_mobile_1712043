import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


import 'package:DARKEN/Styling/AppColors.dart';

class Course {
  Image image;
  String name;
  Course(this.image, this.name);
}

class HomePage extends StatefulWidget {
  static String tag = '/home-page';

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {

  final trendingList = <Course>[
    Course(Image.asset('assets/HomePage/digital-marketing-1.jpg', fit: BoxFit.cover), 'Digital Marketing Basic'),
    Course(Image.asset('assets/HomePage/java-1.png', fit: BoxFit.cover), 'Java Basic'),
    Course(Image.asset('assets/HomePage/python-1.jpg', fit: BoxFit.cover), 'Python Basic'),
    Course(Image.asset('assets/HomePage/python-2.jpg', fit: BoxFit.cover), 'Python Advanced'),
    Course(Image.asset('assets/HomePage/swift-1.png', fit: BoxFit.cover), 'Swift Basic'),

  ];

  final progammingList = <Course>[
    Course(Image.asset('assets/HomePage/appium-1.png', fit: BoxFit.cover), 'Mobile Testing with Appium'),
    Course(Image.asset('assets/HomePage/golang-1.png', fit: BoxFit.cover), 'Golang Basic'),
    Course(Image.asset('assets/HomePage/java-1.png', fit: BoxFit.cover), 'Java Basic'),
    Course(Image.asset('assets/HomePage/unity-1.jpg', fit: BoxFit.cover), 'Game development with Unity'),
    Course(Image.asset('assets/HomePage/swift-1.png', fit: BoxFit.cover), 'Swift Basic'),
    Course(Image.asset('assets/HomePage/python-1.jpg', fit: BoxFit.cover), 'Python Basic'),
    Course(Image.asset('assets/HomePage/python-2.jpg', fit: BoxFit.cover), 'Python Advanced'),

  ];

  final bussinessList = <Course>[
    Course(Image.asset('assets/HomePage/fb-ads-1.png', fit: BoxFit.cover), 'Facebook Ads'),
    Course(Image.asset('assets/HomePage/google-ads-1.png', fit: BoxFit.cover), 'Google Ads'),
    Course(Image.asset('assets/HomePage/digital-marketing-1.jpg', fit: BoxFit.cover), 'Digital Marketing Basic'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
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
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: null,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: trendingList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
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
                                      child: i.image
                                    ),
                                  ),
                                  Container(
                                      height: 48,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            i.name,
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
                        );
                      },
                    );
                  }).toList(),
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
                CarouselSlider(
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
                  items: progammingList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
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
                                        child: i.image
                                    ),
                                  ),
                                  Container(
                                      height: 38,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            i.name,
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
                        );
                      },
                    );
                  }).toList(),
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
                CarouselSlider(
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
                  items: bussinessList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
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
                                        child: i.image
                                    ),
                                  ),
                                  Container(
                                      height: 38,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            i.name,
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
                        );
                      },
                    );
                  }).toList(),
                ),
                // ListView.builder(
                //     itemBuilder: (context, index) {
                //       return;
                //     }
                // )
              ],
            )
        )

    );
  }
}
