import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/SearchCourseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  static String tag = '/browse-page';

  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  List<SearchCourseModel> listSearchCourses;
  TextEditingController textController = new TextEditingController();

  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    listSearchCourses = await APIServer().fetchSearchCoursesWithString(textController.text);
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          child: TextField(
                            controller: textController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (searchString) {
                              listSearchCourses.clear();
                              _fetchData();
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    textController.clear();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: AppColors.themeColor,
                                  )
                              ),
                              contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: AppColors.themeColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: AppColors.themeColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            cursorColor: AppColors.themeColor,
                            style: TextStyle(
                              color: AppColors.themeColor,
                            ),
                          )
                      ),
                      Expanded(
                          child: (listSearchCourses == null || listSearchCourses.length == 0) ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "No courses found!",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ) : Container(
                            child: ListView.builder(
                                itemCount: listSearchCourses.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) => CourseDetailPage(courseID: listSearchCourses[index].id)
                                          )
                                      );
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
                                                      child: Image.network(listSearchCourses[index].imageUrl),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                          padding: EdgeInsets.all(5),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(listSearchCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                              listSearchCourses[index].description.length <= 100 ? Text(listSearchCourses[index].description, style: TextStyle(fontSize: 10)) : Text(listSearchCourses[index].description.substring(0,95) + "...", style: TextStyle(fontSize: 10)),
                                                              Text('Rated: ' + listSearchCourses[index].ratedNumber.toString(), style: TextStyle(fontSize: 10)),
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
                  ),
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