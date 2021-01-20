import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/CourseWithLessonModel.dart';
import 'package:DARKEN/Models/ExerciseModel.dart';
import 'package:DARKEN/Models/LessonVideoModel.dart';
import 'package:DARKEN/Styling/AppColors.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

class VideoPlayerWithExercisesPage extends StatefulWidget {
  static String tag = '/video-player-with-exercise-page';
  String courseID;
  Lesson lesson;
  VideoPlayerWithExercisesPage({Key key, this.courseID, this.lesson}): super(key: key);
  @override
  _VideoPlayerWithExercisesPage createState() => _VideoPlayerWithExercisesPage();
}

class _VideoPlayerWithExercisesPage extends State<VideoPlayerWithExercisesPage> {
  final Dio _dio = Dio();
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String _progressDownload = "";
  bool _isLoading = false;
  bool _isDownloading = false;

  List<ExerciseModel> listExercises;
  LessonVideoModel lessonVideo;

  @override
  void initState() {

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _onSelectNotification);

    _fetchData();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    lessonVideo = await APIServer().fetchLessonVideoWithCourseIDAndLessonID(widget.courseID, widget.lesson.id);
    listExercises = await APIServer().fetchExercisesWithLessonID(widget.lesson.id);
    _controller = VideoPlayerController.network(lessonVideo.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    setState(() {
      _isLoading = false;
    });
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }


  Future<void> _download() async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      setState(() {
        _isDownloading = true;
      });
      final savePath = path.join(dir.path, widget.lesson.name + ".mp4");
      await _startDownload(savePath);
      setState(() {
        _isDownloading = false;
      });
    }
    else {
      print("User declined permission!");
    }
  }


  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(
          lessonVideo.videoUrl,
          savePath,
          onReceiveProgress: _onReceiveProgress
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    }
    catch (ex) {
      result['error'] = ex.toString();
    }
    finally {
      await _showNotification(result);
    }
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progressDownload = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    }
    else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        priority: Priority.High,
        importance: Importance.Max
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android, iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess ? 'Your lesson video has been downloaded successfully!' : 'There was an error while downloading the file.',
        platform,
        payload: json
    );
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

    Widget downloadingIndicator = _isDownloading ? new Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(0, 0, 0, 0.2),
        ),
        Align(
          child: Container(
            color: Colors.grey[700],
            width: 100,
            height: 100,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Center(
                        child: new CircularProgressIndicator()
                    )
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        _progressDownload,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                    )
                )
              ],
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
          lessonVideo == null ? Container() : Container(
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
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        onPressed: _download,
                        color: AppColors.themeColor,
                        child: Text('Download Video', style: TextStyle(color: Colors.white)),
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
                      child: Text("Hours: " + lessonVideo.currentTime.toString()),
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
          ),
          Align(
              child: downloadingIndicator,
              alignment: FractionalOffset.center
          )
        ],
      ),
      floatingActionButton:  lessonVideo == null ? FloatingActionButton() : FloatingActionButton(
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