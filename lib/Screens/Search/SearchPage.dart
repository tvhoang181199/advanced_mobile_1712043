import 'package:DARKEN/Models/CourseModelOffline.dart';
import 'package:DARKEN/Models/ListCoursesModelOffline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class SearchPage extends StatefulWidget {
  static String tag = '/browse-page';

  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  var _searchPageKey = GlobalKey<NavigatorState>();

  List<CourseModelOffline> _searchList = [];
  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Navigator(
            key: _searchPageKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/course-detail-page') {
                return MaterialPageRoute(builder: (context) => CourseDetailPage());
              } else {
                return MaterialPageRoute(
                    builder: (context) => SafeArea(
                        child: Consumer<ListCoursesModelOffline>(
                            builder: (context, listCourses, _) {
                              return Container(
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
                                          onChanged: (text){
                                            _searchList.clear();
                                            if (text.isEmpty) {
                                              setState(() {});
                                              return;
                                            }
                                            listCourses.listCourses.forEach((course) {
                                              if (course.title.toLowerCase().contains(text.toLowerCase()))
                                                _searchList.add(course);
                                            });
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Search',
                                            suffixIcon: IconButton(
                                                onPressed: (){
                                                  textController.clear();
                                                  _searchList.clear();
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
                                        child: Container(
                                          child: _searchList.length != 0 || textController.text.isNotEmpty ? new ListView.builder(
                                              itemCount: _searchList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                    onTap: (){
                                                      _searchPageKey.currentState.push(
                                                          MaterialPageRoute(
                                                            fullscreenDialog: true,
                                                            builder: (context) => CourseDetailPage(),
                                                            settings: RouteSettings(
                                                              arguments: listCourses.listCourses[int.parse(listCourses.listCourses[int.parse(_searchList[index].id)].id)],
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
                                                                        child: Image.asset(listCourses.listCourses[int.parse(listCourses.listCourses[int.parse(_searchList[index].id)].id)].imageUrl, fit: BoxFit.cover,)
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                      child: Container(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Text(listCourses.listCourses[int.parse(_searchList[index].id)].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text('Teacher: '+ listCourses.listCourses[int.parse(_searchList[index].id)].teacher),
                                                                              Text('Total videos: '+ listCourses.listCourses[int.parse(_searchList[index].id)].videoNumber.toString()),
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
                                                      _searchPageKey.currentState.push(
                                                          MaterialPageRoute(
                                                            fullscreenDialog: true,
                                                            builder: (context) => CourseDetailPage(),
                                                            settings: RouteSettings(
                                                              arguments: listCourses.listCourses[index],
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
                                                                        child: Image.asset(listCourses.listCourses[index].imageUrl, fit: BoxFit.cover,)
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                      child: Container(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Text(listCourses.listCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text('Teacher: '+ listCourses.listCourses[index].teacher),
                                                                              Text('Total videos: '+ listCourses.listCourses[index].videoNumber.toString()),
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