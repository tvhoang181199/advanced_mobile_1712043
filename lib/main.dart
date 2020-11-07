import 'package:flutter/material.dart';
import 'Screens/IntroPage.dart';
import 'Screens/LoginPage.dart';
import 'Screens/SignUpPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      IntroPage.tag: (context) => IntroPage(),
      LoginPage.tag: (context) => LoginPage(),
      SignUpPage.tag: (context) => SignUpPage(),
    };

    return MaterialApp(
      title: 'DARKEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IntroPage.tag,
      routes: routes,
    );
  }
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   DateTime selectedDate = DateTime.now();
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != selectedDate)
//       setState(() {
//         selectedDate = picked;
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text("${selectedDate.toLocal()}".split(' ')[0]),
//             SizedBox(height: 20.0,),
//             RaisedButton(
//               onPressed: () => _selectDate(context),
//               child: Text('Select date'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }