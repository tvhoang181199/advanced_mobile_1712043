import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/UserMeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class ProfileDetailPage extends StatefulWidget {
  static String tag = '/profile-detail-page';

  @override
  _ProfileDetailPage createState() => new _ProfileDetailPage();
}

class _ProfileDetailPage extends State<ProfileDetailPage> {

  UserMeModel currentUser;
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    currentUser = await APIServer().fetchUserInfo();
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

    final avatarImage = AspectRatio(
      aspectRatio: 1/1,
      child: ClipOval(
        child: Container(
          color: AppColors.greyColor,
          child: Image.asset(
            'assets/Icons/default-avatar.png',
          ),
        )
      ),
    );

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
            'PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: avatarImage,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      (currentUser != null) ? currentUser.payload.phone : 'null',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    (currentUser != null) ? currentUser.payload.type : 'null',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkGreyColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    height: 110,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          width: MediaQuery.of(context).size.width*0.3333,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'TOTAL HOURS',
                                style: TextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('46')
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          width: MediaQuery.of(context).size.width*0.3333,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'VIDEOS',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('25')
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: AppColors.greyColor,
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: AppColors.greyColor,
                                  width: 1,
                                ),
                              )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          width: MediaQuery.of(context).size.width*0.3333,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'COURSES',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('3')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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