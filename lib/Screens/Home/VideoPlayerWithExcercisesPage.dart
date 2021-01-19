import 'dart:async';
import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseWithLessonModel.dart';
import 'package:DARKEN/Models/ExerciseModel.dart';
import 'package:DARKEN/Styling/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWithExercisesPage extends StatefulWidget {
  String videoURL;
  Lesson lesson;
  VideoPlayerWithExercisesPage({Key key, this.videoURL, this.lesson}): super(key: key);
  @override
  _VideoPlayerWithExercisesPage createState() => _VideoPlayerWithExercisesPage();
}

class _VideoPlayerWithExercisesPage extends State<VideoPlayerWithExercisesPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  bool _isLoading = false;

  List<ExerciseModel> listExercises;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    print("LessonID: " + widget.lesson.id);
    listExercises = await APIServer().fetchExercisesWithLessonID(widget.lesson.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {

    _fetchData();

    _controller = VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          widget.lesson.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: 16/9,
                              child: Container(
                                child: VideoPlayer(_controller),
                              ),
                            );
                          }
                          else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "DESCRIPTION",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text("Video Name: " + widget.lesson.videoName),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text("Hours: " + widget.lesson.hours.toString()),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "EXERCISES",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor
                        ),
                      ),
                    ),
                    listExercises == null || listExercises.length == 0 ? Container(
                      height: 50,
                      child: Center(
                        child: Text("NO EXERCISES FOUND!", style: TextStyle(color: AppColors.greyColor, fontSize: 15)),
                      ),
                    ) : Container(
                        height: listExercises.length.toDouble()*60,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:listExercises.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child : GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "Exercise ${index+1}: " + listExercises[index].title,
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
          ),
          Align(
              child: loadingIndicator,
              alignment: FractionalOffset.center
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            }
            else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

