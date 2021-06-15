import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Controller/addStudent.dart';
import 'package:mobile_app/View/AddAssignmentView.dart';
import 'package:mobile_app/View/AddRating.dart';
import 'package:mobile_app/View/AllStudentListView.dart';
import 'View/StudentView.dart';
import 'package:splashscreen/splashscreen.dart';
import 'View/mainView.dart';
import 'View/background.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => AllStudentListView()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('images/2.png'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 550.0, right: 30.0),
                child: Text('STUDENT',textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF310062), fontSize: 30, fontWeight: FontWeight.bold, ) ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 600.0, right: 30.0),
                child: Text('ASSESSMENTS',textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF310062), fontSize: 30, fontWeight: FontWeight.bold) ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 6,
//       navigateAfterSeconds: new Home(),
//       title: new Text('Dulmaynayyy',textScaleFactor: 2,),
//       image: Image.asset(
//         'images/2.2.png',
//       ),
//       loadingText: Text("Loading"),
//       photoSize: 100.0,
//       loaderColor: Color(0xFF8c0074),
//     );
//   }
// }

class _HomeState extends State<Home> {
  final Firestore firestore = Firestore.instance;

  void _create() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddStudent()),
    );
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('users').document('IT11').get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection('users').document('testUser').updateData({
        'firstName': 'Alan',
      });
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('users').document('testUser').delete();
    } catch (e) {
      print(e);
    }
  }
  void _addRating() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRating()),
    );
  }
  void _addAssignment() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAssignmentView()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0e0e0),
      body: Container(
        width: 420,
        height: 400,
        alignment: Alignment.topCenter,
        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0)),
            image: new DecorationImage(
              image: new AssetImage('images/2.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          RaisedButton(
            child: Text("Create"),
            onPressed: _create,
          ),
          RaisedButton(
            child: Text("Read"),
            onPressed: _read,
          ),
          RaisedButton(
            child: Text("Update"),
            onPressed: _update,
          ),
          RaisedButton(
            child: Text("Delete"),
            onPressed: _delete,
          ),

          RaisedButton(
            child: Text("add Rating"),
            onPressed: _addRating,
          ),
          RaisedButton(
            child: Text("add Assignment"),
            onPressed: _addAssignment,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentView(id: 'IT001'),
              )
          );
        },
        child: const Icon(Icons.free_breakfast_rounded),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
