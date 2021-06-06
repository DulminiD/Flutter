import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Util/EditStudentUtil.dart';

class EditStudentView extends StatefulWidget {
  final String id;

  EditStudentView({Key key, @required this.id}) : super(key: key);

  @override
  EditStudentViewState createState() => EditStudentViewState(this.id);

}

class EditStudentViewState extends State<EditStudentView>{
  String id;

  EditStudentViewState(String id){
    this.id =id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('users').document(id).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> student) {
        Widget widget;
        if (student.hasData) {
          widget = editStudentWidget(student.data, context);
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

