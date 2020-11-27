import 'package:DARKEN/Models/CourseModel.dart';
import 'package:DARKEN/Models/ListCoursesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:DARKEN/Screens/Home/CourseDetail.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class SearchPage extends StatefulWidget {
  static String tag = '/browse-page';

  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  TextEditingController textController = new TextEditingController();

  List<CourseModel> _listCourses = ListCoursesModel().listCourses;
  List<CourseModel> _searchList = [];

  @override
  Widget build(BuildContext context) {

    onSearchTextChanged(String text) async {
      _searchList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      _listCourses.forEach((course) {
        if (course.title.toLowerCase().contains(text.toLowerCase()))
          _searchList.add(course);
      });

      setState(() {});
    }

    return Scaffold(
      body: SafeArea(
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
                      textInputAction: TextInputAction.done,
                      onChanged: onSearchTextChanged,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: IconButton(
                            onPressed: (){
                              textController.clear();
                              onSearchTextChanged('');
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
                    child: Container(
                      child: _searchList.length != 0 || textController.text.isNotEmpty ? new ListView.builder(
                          itemCount: _searchList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => CourseDetailPage(),
                                        settings: RouteSettings(
                                          arguments: _listCourses[index],
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
                                                    child: Image.asset(_searchList[index].imageUrl, fit: BoxFit.cover,)
                                                ),
                                              ),

                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(_searchList[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                          Text('Teacher: '+ _searchList[index].teacher),
                                                          Text('Total videos: '+ _searchList[index].videoNumber.toString()),
                                                          // RatingBox(),
                                                        ],
                                                      )
                                                  )
                                              )
                                            ]
                                        )
                                    )
                                )
                            );
                          }
                      ): ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(
                                      CupertinoPageRoute(
                                          fullscreenDialog: true,
                                        builder: (context) => CourseDetailPage(),
                                        settings: RouteSettings(
                                          arguments: _listCourses[index],
                                        ),
                                      )
                                  );
                                },
                                child: (index == 0) ? Container(
                                  padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                                  child: Text(
                                    'Suggestion',
                                    style: TextStyle(
                                        color: AppColors.themeColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ) : Container(
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
                                                    child: Image.asset(_listCourses[index].imageUrl, fit: BoxFit.cover,)
                                                ),
                                              ),

                                              Expanded(
                                                  child: Container(
                                                      padding: EdgeInsets.all(5),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(_listCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                          Text('Teacher: '+ _listCourses[index].teacher),
                                                          Text('Total videos: '+ _listCourses[index].videoNumber.toString()),
                                                          // RatingBox(),
                                                        ],
                                                      )
                                                  )
                                              )
                                            ]
                                        )
                                    )
                                )
                            );
                          }
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}