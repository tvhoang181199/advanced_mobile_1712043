import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CategoryModel.dart';
import 'package:DARKEN/Models/CourseModelOnline.dart';
import 'package:DARKEN/Models/SearchCourseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Styling/AppColors.dart';

import 'package:http/http.dart' as http;

class CoursesFilteredPage extends StatefulWidget {
  static String tag = '/courses-filtered-page';

  final String cateID;
  CoursesFilteredPage({Key key, @required this.cateID}) : super(key: key);

  @override
  _CoursesFilteredPage createState() => new _CoursesFilteredPage(cateID);
}

class _CoursesFilteredPage extends State<CoursesFilteredPage> {

  String cateID;
  _CoursesFilteredPage(this.cateID);

  bool _isLoading = false;
  List<CourseModelOnline> listCourses;
  List<SearchCourseModel> listSearchCourses;
  CategoryModel category;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    if (cateID == "TRENDING COURSES")
      listCourses = await APIServer().fetchTopNewCourses(10, 1);
    else if (cateID == "MADE FOR YOU")
      listCourses = await APIServer().fetchTopRateCourses(10, 1);
    else {
      print(cateID);
      category = await APIServer().fetchCategoryWithID(cateID);
      listSearchCourses = await APIServer().fetchCoursesFromCategoryID(cateID);
      setState(() {
        cateID = category.name;
      });
    }

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
            cateID,
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
                    itemCount: listCourses != null ? listCourses.length : (listSearchCourses != null ? listSearchCourses.length : 0),
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
                                          child: listCourses != null ? Image.network(listCourses[index].imageUrl) : Image.network(listSearchCourses[index].imageUrl),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: listCourses != null ? <Widget>[
                                                  Text(listCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                  listCourses[index].subtitle.length <= 100 ? Text(listCourses[index].subtitle, style: TextStyle(fontSize: 10)) : Text(listCourses[index].subtitle.substring(1,95) + "...", style: TextStyle(fontSize: 10)),
                                                  Text('Rated: ' + listCourses[index].ratedNumber.toString(), style: TextStyle(fontSize: 10)),
                                                  // RatingBox(),
                                                ] : <Widget>[
                                                  Text(listSearchCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                  listSearchCourses[index].description.length <= 100 ? Text(listSearchCourses[index].description, style: TextStyle(fontSize: 10)) : Text(listSearchCourses[index].description.substring(1,95) + "...", style: TextStyle(fontSize: 10)),
                                                  Text('Rated: ' + listSearchCourses[index].ratedNumber.toString(), style: TextStyle(fontSize: 10)),
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