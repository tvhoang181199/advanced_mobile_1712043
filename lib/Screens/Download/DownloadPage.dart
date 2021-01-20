import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:DARKEN/Styling/AppColors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class DownloadPage extends StatefulWidget {
  static String tag = '/download-page';

  @override
  _DownloadPage createState() => new _DownloadPage();
}

class _DownloadPage extends State<DownloadPage> {

  String appDirectory;
  List<FileSystemEntity> listVideoFiles = [];

  @override
  void initState() {
    super.initState();
    _listofFiles();

  }

  void _listofFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    appDirectory = dir.path;
    setState(() {
      dir.list(recursive: false, followLinks: false)
          .listen((FileSystemEntity entity) {
            if (entity.path.substring(dir.path.length+1, entity.path.length) != ".Trash") {
              listVideoFiles.add(entity);
            }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: listVideoFiles == null || listVideoFiles.length == 0 ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        'There are no downloaded videos!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ): Container(
                        height: listVideoFiles.length.toDouble()*60,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listVideoFiles.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child : GestureDetector(
                                    onTap: () {
                                      OpenFile.open(listVideoFiles[index].path);
                                    },
                                    child: Card(
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  listVideoFiles[index].path.substring(appDirectory.length + 1, listVideoFiles[index].path.length),
                                                  style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          )
                                      ),
                                    )
                                )
                            );
                          },
                        )
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}

// print();