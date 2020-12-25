import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/InstructorModel.dart';
import 'package:DARKEN/Models/UserMeModel.dart';
import 'package:DARKEN/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:DARKEN/Screens/Account/ProfileDetailPage.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class ProfilePage extends StatefulWidget {
  static String tag = '/account-page';

  @override
  _ProfilePage createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  List<InstructorModel> list;
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
    final headerBox = Container(
      height: 120,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: AppColors.greyColor,
                width: 3,
              )
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
              aspectRatio: 1/1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1
                  )
                ),
                child: ClipOval(
                  child: (currentUser != null) ? Image.network(currentUser.payload.avatar) : Image.asset('assets/Icons/default-avatar.png'),
                ),
              )
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              (currentUser != null) ? currentUser.payload.email : 'null',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    final profileRow = GestureDetector(
        onTap: (){
          Navigator.of(context).push(
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ProfileDetailPage()
              )
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1,
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: AppColors.themeColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top:20),
                  child: Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )
        )
    );

    final settingsRow = GestureDetector(
        onTap: (){
          print('Clicked on Settings');
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1,
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.settings,
                    size: 30,
                    color: AppColors.themeColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top:20),
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )
        )
    );

    final analyticsRow = GestureDetector(
        onTap: (){
          print('Clicked on Analytics');
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1,
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.bar_chart,
                    size: 30,
                    color: AppColors.themeColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top:20),
                  child: Text(
                    'Analytics',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )
        )
    );

    final supportRow = GestureDetector(
        onTap: (){
          print('Clicked on Support');
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 3,
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.support,
                    size: 30,
                    color: AppColors.themeColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top:20),
                  child: Text(
                    'Support',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )
        )
    );

    final logoutRow = GestureDetector(
        onTap: (){
          APIServer().updateToken('');
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1,
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top:20),
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )
        )
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
      body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                color: AppColors.greyColor,
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  children: <Widget>[
                    headerBox,
                    profileRow,
                    analyticsRow,
                    settingsRow,
                    supportRow,
                    logoutRow,
                  ],
                ),
              ),
              Align(
                  child: loadingIndicator,
                  alignment: FractionalOffset.center
              )
            ],
          )
      ),
    );
  }
}