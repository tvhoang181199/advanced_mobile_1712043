import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:DARKEN/Models/ListCoursesModelOffline.dart';

import 'package:DARKEN/Screens/Home/CourseDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class DownloadPage extends StatefulWidget {
  static String tag = '/download-page';

  @override
  _DownloadPage createState() => new _DownloadPage();
}

class _DownloadPage extends State<DownloadPage> {
  var _downloadPageKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
            key: _downloadPageKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/course-detail-page') {
                return MaterialPageRoute(builder: (context) => CourseDetailPage());
              } else {
                return MaterialPageRoute(
                    builder: (context) => SafeArea(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  'DOWNLOADED',
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColors.themeColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Consumer<ListCoursesModelOffline>(
                                    builder: (context, listCourses, _) {
                                      return (listCourses.downloadedListCourses.length == 0)?Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                            'There are no downloaded courses!',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                        ),
                                      ) : Container(
                                        child: ListView.builder(
                                            itemCount: listCourses.downloadedListCourses.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    _downloadPageKey.currentState.push(
                                                        MaterialPageRoute(
                                                          fullscreenDialog: true,
                                                          builder: (context) => CourseDetailPage(),
                                                          settings: RouteSettings(
                                                            arguments: listCourses.downloadedListCourses[index],
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
                                                                    child: Image.asset(listCourses.downloadedListCourses[index].imageUrl),
                                                                  ),
                                                                ),

                                                                Expanded(
                                                                    child: Container(
                                                                        padding: EdgeInsets.all(5),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: <Widget>[
                                                                            Text(listCourses.downloadedListCourses[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                                            Text('Teacher: '+ listCourses.downloadedListCourses[index].teacher),
                                                                            Text('Downloaded videos: ' + listCourses.downloadedListCourses[index].downloadedVideos.toString() + '/' + listCourses.downloadedListCourses[index].videoNumber.toString()),
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
                                      );
                                    }
                                ),
                              )
                            ],
                          ),
                        )
                    )
                );
              }
            }
        )
    );
  }
}