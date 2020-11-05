import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = '/login-page';
  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailTextField = TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Color.fromRGBO(40, 75, 99, 1),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: Color.fromRGBO(40, 75, 99, 1),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 00.0, 20.0, 0.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Color.fromRGBO(40, 75, 99, 1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Color.fromRGBO(40, 75, 99, 1),
            width: 1,
          ),
        ),
      ),
      cursorColor: Color.fromRGBO(40, 75, 99, 1),
      style: TextStyle(
        color: Color.fromRGBO(40, 75, 99, 1),
      ),
    );

    final passwordTextField = TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Color.fromRGBO(40, 75, 99, 1),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: Color.fromRGBO(40, 75, 99, 1),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Color.fromRGBO(40, 75, 99, 1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Color.fromRGBO(40, 75, 99, 1),
            width: 1,
          ),
        ),
      ),
      cursorColor: Color.fromRGBO(40, 75, 99, 1),
      style: TextStyle(
        color: Color.fromRGBO(40, 75, 99, 1),
      ),
    );

    final loginButton = RaisedButton(
      padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
      color: Color.fromRGBO(40, 75, 99, 1),
      child: Text(
        "LOGIN",
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

      },
    );

    final forgetPasswordButton = OutlineButton(
      padding: EdgeInsets.all(0),
      borderSide: BorderSide.none,
      child: Text(
        "Forget your password?",
        style: TextStyle(
          color: Color.fromRGBO(40, 75, 99, 1),
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),

      onPressed: (){

      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('LOGIN'),
          backgroundColor: Color.fromRGBO(40, 75, 99, 1),
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
                            Container(
                              padding: EdgeInsets.only(left: 100.0, top: 50.0, right: 100.0, bottom: 50.0),
                              child: AspectRatio(
                                aspectRatio: 1/1,
                                child: Image.asset(
                                  "assets/Icons/app_icon.png",
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            emailTextField,
                            SizedBox(height: 10.0),
                            passwordTextField,
                            SizedBox(height: 20.0),
                            loginButton,
                            forgetPasswordButton,
                          ]
                      ),
                    )
                )
            )
        )
    );
  }
}