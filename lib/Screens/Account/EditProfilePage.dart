import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/UserMeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class EditProfilePage extends StatefulWidget {
  static String tag = '/edit-profile-page';

  final UserMeModel userMe;
  EditProfilePage({Key key, @required this.userMe}) : super(key: key);

  @override
  _EditProfilePage createState() => new _EditProfilePage(userMe);
}

class _EditProfilePage extends State<EditProfilePage> {

  TextEditingController _nameTextController = new TextEditingController();
  TextEditingController _phoneTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  TextEditingController _confirmPasswordTextController = new TextEditingController();

  UserMeModel userMe;
  _EditProfilePage(this.userMe);

  void initState() {
    super.initState();
    _showDialog();
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
              "Instruction",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.themeColor,
                  fontSize: 18.0)
          ),
          content: Text("Enter name and phone for update information, or password and confirm password to change password."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0)
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final node = FocusScope.of(context);

    final nameTextField = TextField(
      controller: _nameTextController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: AppColors.themeColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 0.0),
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
    );

    final phoneTextField = TextField(
      controller: _phoneTextController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      decoration: InputDecoration(
        labelText: 'Phone',
        labelStyle: TextStyle(
          color: AppColors.themeColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 0.0),
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
    );

    final passwordTextField = TextField(
      controller: _passwordTextController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: AppColors.themeColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
    );

    final confirmPasswordTextField = TextField(
      controller: _confirmPasswordTextController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => node.unfocus(),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: TextStyle(
          color: AppColors.themeColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
    );

    final updateButton = RaisedButton(
      padding: EdgeInsets.fromLTRB(97, 15, 97, 15),
      color: AppColors.themeColor,
      child: Text(
        "Update",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: (){},
    );

    final changePasswordButton = RaisedButton(
      padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
      color: AppColors.themeColor,
      child: Text(
        "Change Password",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: (){},
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'EDIT PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: Stack(
          children: [
            GestureDetector(
                onTap:() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Center(
                    child: Container (
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 20),
                                nameTextField,
                                SizedBox(height: 10),
                                phoneTextField,
                                SizedBox(height: 10),
                                passwordTextField,
                                SizedBox(height: 10),
                                confirmPasswordTextField,
                                SizedBox(height: 10),
                                updateButton,
                                SizedBox(height: 10),
                                changePasswordButton
                              ]
                          ),
                        )
                    )
                )
            )
          ],
        )
    );
  }
}