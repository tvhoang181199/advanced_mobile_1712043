import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class ProfileDetailPage extends StatefulWidget {
  static String tag = '/profiledetail-page';

  @override
  _ProfileDetailPage createState() => new _ProfileDetailPage();
}

class _ProfileDetailPage extends State<ProfileDetailPage> {
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
        body: Container(
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
                  'Trinh Vu Hoang',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                'Student',
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
                          Text('50')
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
                          Text('14')
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
                          Text('50')
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

    );
  }
}