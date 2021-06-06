import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Model/Student.dart';
import 'package:mobile_app/Util/StudentUtil.dart';

class StudentView extends StatefulWidget{
  final String id;

  StudentView({Key key, @required this.id}) : super(key: key);

  @override
  StudentViewState createState() => StudentViewState(this.id);
}

class StudentViewState extends State<StudentView>{
  Student student;
  String id;
  StudentViewState(String id){
    this.id =id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('users').document(id).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> student) {
        Widget widget;
        if (student.hasData) {
          widget = studentWidget(context, student.data);
        } else {
          widget = Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widget;
      },
    );
  }
}