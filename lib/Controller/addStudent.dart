import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Model/Student.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final Firestore firestore = Firestore.instance;
  Student student = new Student();

  void _create() async {
    try {
      await firestore.collection('users').document(student.sId).setData({
        'sId': student.sId,
        'sName': student.sName,
        'sModule': student.sModule
      });
    } catch (e) {
      print(e);
    }
  }

  void _onChangesId(String value) async {
    try {
      this.setState(() {
        student.sId = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesName(String value) async {
    try {
      this.setState(() {
        student.sName = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesModule(String value) async {
    try {
      this.setState(() {
        student.sModule = value;
      });

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CRUD with Firebase"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          TextField(
            onChanged : (value)=>_onChangesId(value),
          ),
          TextField(
            onChanged : (value)=>_onChangesName(value),
          ),
          TextField(
            onChanged : (value)=>_onChangesModule(value),
          ),
          RaisedButton(
            child: Text("Create"),
            onPressed: _create,
          ),
        ]),
      ),
    );
  }
}