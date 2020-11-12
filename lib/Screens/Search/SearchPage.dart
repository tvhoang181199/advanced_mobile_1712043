import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class SearchPage extends StatefulWidget {
  static String tag = '/browse-page';

  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: (){
                            print('Clicked on Search Button');
                          },
                          icon: Icon(
                            Icons.search,
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
            ],
          ),
        ),
      ),
    );
  }
}