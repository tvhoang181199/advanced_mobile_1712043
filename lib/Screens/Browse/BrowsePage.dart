import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CategoryModel.dart';
import 'package:DARKEN/Models/InstructorModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:DARKEN/Screens/Home/CoursesFilteredPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class BrowsePage extends StatefulWidget{
  static String tag = '/browse-page';

  @override _BrowsePage createState() => new _BrowsePage();
}

class _BrowsePage extends State<BrowsePage>{
  final skillList = ['Swift','Python', 'Flutter', 'Marketing', 'Java'];

  List<CategoryModel> listCategories;
  List<InstructorModel> listInstructors;
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    listInstructors = await APIServer().fetchInstructors();
    listCategories = await APIServer().fetchAllCategories();
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
            Container(
                child: ListView.builder  (
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              child: ImageButton(
                                children: <Widget>[
                                  Text('TRENDING COURSES', style: TextStyle(
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
                                  Navigator.of(context).push(
                                      CupertinoPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => CoursesFilteredPage(cateID: "TRENDING COURSES")
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
                                  Navigator.of(context).push(
                                      CupertinoPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => CoursesFilteredPage(cateID: "MADE FOR YOU")
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
                          child: Text('TOPIC', style: TextStyle(
                              color: AppColors.themeColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold)),
                        );
                      }
                      else if (index == 3) {
                        return Container (
                          padding: EdgeInsets.only(bottom: 10),
                          child: CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 2,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: listCategories == null ? <Widget>[Container(height: 0)] : listCategories.map((item) =>
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => CoursesFilteredPage(cateID: item.id)
                                          )
                                      );
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.bottomCenter,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              child: Image.asset("assets/Courses/java-1.png", fit: BoxFit.cover),
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
                                    onTap: () {},
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
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listInstructors.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(right: 15.0),
                                        child: Card(
                                            child: Container(
                                              child: Center(
                                                  child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                            radius: 50,
                                                            child: AspectRatio(
                                                              aspectRatio: 1/1,
                                                              child: ClipOval(
                                                                child: Image.network(listInstructors[index].userAvatar, fit: BoxFit.cover),
                                                              ),
                                                            )
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              child: Text(
                                                                  listInstructors[index].userName,
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