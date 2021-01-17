import 'package:DARKEN/APIs/APIServer.dart';
import 'package:DARKEN/Models/UserMeModel.dart';
import 'package:DARKEN/Screens/Account/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:DARKEN/Styling/AppColors.dart';

import 'package:http/http.dart' as http;

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
  TextEditingController _oldPasswordTextController = new TextEditingController();
  TextEditingController _newPasswordTextController = new TextEditingController();

  bool _isLoading = false;

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
          content: Text("Enter name and phone for update information, or old and new password to change password."),
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

    void _updateTapped() async {
      var name = _nameTextController.text;
      var phone = _phoneTextController.text;

      if (_nameTextController.text == "" ||
          _phoneTextController.text == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                  "FAILED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.errorColor,
                      fontSize: 18.0)
              ),
              content: Text("Please enter new name and new phone!"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: Text(
                      "Try again",
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
      else {
        setState(() {
          _isLoading = true;
        });

        http.Response response = await APIServer().updateUserInfo(name, userMe.payload.avatar, phone);

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: Text("SUCCESS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 18.0)
                ),
                content: Text(
                  "Your account has been updated!",
                  style: TextStyle(
                      color: AppColors.darkGreyColor
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: Text("OK", style: TextStyle(
                        color: AppColors.themeColor, fontSize: 16.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: Text(
                    "FAILED",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.errorColor,
                        fontSize: 18.0)
                ),
                content: Text("Your information has not been updated!"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: Text(
                        "Try again",
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
      }
    }

    void _changePasswordTapped() async {
      var oldPassword = _oldPasswordTextController.text;
      var newPassword = _newPasswordTextController.text;

      if (_oldPasswordTextController.text == "" ||
          _newPasswordTextController.text == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                  "FAILED",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.errorColor,
                      fontSize: 18.0)
              ),
              content: Text("Please enter old and new password!"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: Text(
                      "Try again",
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
      else {
        setState(() {
          _isLoading = true;
        });

        http.Response response = await APIServer().changePassword(userMe.payload.id, oldPassword, newPassword);

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: Text("SUCCESS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 18.0)
                ),
                content: Text(
                  "Your password has been changed!",
                  style: TextStyle(
                      color: AppColors.darkGreyColor
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: Text("OK", style: TextStyle(
                        color: AppColors.themeColor, fontSize: 16.0)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }
        else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: Text(
                    "FAILED",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.errorColor,
                        fontSize: 18.0)
                ),
                content: Text("Your password has not been changed!"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: Text(
                        "Try again",
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
      }
    }

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

    final oldPasswordTextField = TextField(
      controller: _oldPasswordTextController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Old Password',
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

    final newPasswordTextField = TextField(
      controller: _newPasswordTextController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => node.unfocus(),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'New Password',
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
      onPressed: _updateTapped,
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
      onPressed: _changePasswordTapped,
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
                                oldPasswordTextField,
                                SizedBox(height: 10),
                                newPasswordTextField,
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