import 'package:DARKEN/Models/CourseWithLessonModel.dart';
import 'package:DARKEN/Screens/Home/VideoPlayerWithExcercisesPage.dart';
import 'package:DARKEN/Styling/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonPage extends StatefulWidget{
  static String tag = '/lesson-page';

  Section section;
  String videoURL;
  LessonPage({Key key, @required this.section, @required this.videoURL}) : super(key: key);

  @override
  _LessonPage createState() => new _LessonPage();
}


class _LessonPage extends State<LessonPage>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.section.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      "LESSONS",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor
                      ),
                    ),
                  ),
                  Container(
                      height: widget.section.lesson.length.toDouble()*60,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.section.lesson.length,
                        itemBuilder: (context, index) {
                          return Container(
                              child : GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => VideoPlayerWithExercisesPage(videoURL: widget.videoURL, lesson: widget.section.lesson[index]))
                                    );
                                  },
                                  child: Card(
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                "Lesson ${index+1}: " + widget.section.lesson[index].name,
                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        )
                                    ),
                                  )
                              )
                          );
                        },
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}

