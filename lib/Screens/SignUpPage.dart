import 'package:DARKEN/Screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:DARKEN/BottomTabbar.dart';
import 'package:DARKEN/Styling/AppColors.dart';
import 'package:DARKEN/APIs/APIServer.dart';

import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  static String tag = '/signup-page';
  @override
  _SignUpPage createState() => new _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    DateTime selectedDate = DateTime.now();
    final _dateFormatter = new DateFormat('dd-MM-yyyy');

    final node = FocusScope.of(context);

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1901, 1),
          lastDate: DateTime(2100));
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
          _birthdayController.text = _dateFormatter.format(selectedDate);
        });
        node.nextFocus();
      }
    }

    void _signUpTapped() async {
      var username = _emailController.text;
      var email = _emailController.text;
      var password = _passwordController.text;
      var phone = _phoneController.text;

      if (_firstNameController.text == "" ||
      _lastNameController.text == "" ||
      _birthdayController.text == "" ||
      _phoneController.text == "" ||
      _emailController.text == "" ||
      _passwordController.text == "" ||
      _confirmPasswordController == "") {
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
              content: Text("Please fill all information!"),
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
      else if (_passwordController.text != _confirmPasswordController.text) {
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
              content: Text("Your confirm password doesn't match!"),
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

        http.Response response = await APIServer().register(username, email, phone, password);

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
                  "Your account has been created!\n Check your email for confirmation!",
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
                      Navigator.popAndPushNamed(context, LoginPage.tag);
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
                content: Text("Email or Phone number has been used!"),
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

    final firstNameTextField = TextField(
      controller: _firstNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      decoration: InputDecoration(
        labelText: 'First Name',
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

    final lastNameTextField = TextField(
      controller: _lastNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      onSubmitted: (v){
        _selectDate(context);
      },
      onEditingComplete: () => node.nextFocus(),
      decoration: InputDecoration(
        labelText: 'Last Name',
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

    final birthdayTextField = TextFormField(
      controller: _birthdayController,
      readOnly: true,
      onTap: () => _selectDate(context),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "Birthday",
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
      controller: _phoneController,
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

    final emailTextField = TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      decoration: InputDecoration(
        labelText: 'Email',
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
      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
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
      controller: _confirmPasswordController,
      keyboardType: TextInputType.emailAddress,
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

    final signUpButton = RaisedButton(
      padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
      color: AppColors.themeColor,
      child: Text(
        "SIGNUP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: _signUpTapped,
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
            'CREATE A NEW ACCOUNT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.themeColor,
        ),
        body: GestureDetector(
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
                            firstNameTextField,
                            SizedBox(height: 10),
                            lastNameTextField,
                            SizedBox(height: 10),
                            birthdayTextField,
                            SizedBox(height: 10),
                            phoneTextField,
                            SizedBox(height: 10),
                            emailTextField,
                            SizedBox(height: 10),
                            passwordTextField,
                            SizedBox(height: 10),
                            confirmPasswordTextField,
                            SizedBox(height: 10),
                            signUpButton,
                          ]
                      ),
                    )
                )
            )
        )
    );
  }
}