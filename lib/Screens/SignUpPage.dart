import 'package:DARKEN/Screens/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:DARKEN/BottomTabbar.dart';

import 'package:DARKEN/Styling/AppColors.dart';

class SignUpPage extends StatefulWidget {
  static String tag = '/signup-page';
  @override
  _SignUpPage createState() => new _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TextEditingController _dateTextController = new TextEditingController();
    final _dateFormatter = new DateFormat('dd-MM-yyyy');

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1901, 1),
          lastDate: DateTime(2100));
      if (pickedDate != null && pickedDate != selectedDate) {
        selectedDate = pickedDate;
        _dateTextController.text = _dateFormatter.format(selectedDate);
      }
    }

    final firstNameTextField = TextField(
      keyboardType: TextInputType.name,
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
      keyboardType: TextInputType.name,
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
      readOnly: true,
      onTap: () => _selectDate(context),
      controller: _dateTextController,
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
      keyboardType: TextInputType.number,
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
      keyboardType: TextInputType.emailAddress,
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
      keyboardType: TextInputType.emailAddress,
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
      keyboardType: TextInputType.emailAddress,
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
      onPressed: (){
        Navigator.of(context).pushNamed(BottomTabbar.tag);
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('CREATE A NEW ACCOUNT'),
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