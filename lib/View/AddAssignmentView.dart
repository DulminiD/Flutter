import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Model/Assignment.dart';

class AddAssignmentView extends StatefulWidget {

  @override
  _AddAssignmentViewState createState() => _AddAssignmentViewState();
}

class _AddAssignmentViewState extends State<AddAssignmentView> {
  final Firestore firestore = Firestore.instance;
  Assignment assignment = new Assignment();

  final assignID = TextEditingController();
  final heading = TextEditingController();
  final module = TextEditingController();
  final assignedTo = TextEditingController();
  final totalMark = TextEditingController();
  final className = TextEditingController();

  void _create(BuildContext context) async {
    try {
      await firestore.collection('assignments').document(assignment.assignID).setData({
        'assignID': assignment.assignID,
        'heading': assignment.heading,
        'module': assignment.module,
        'assignedTo': assignment.assignedTo,
        'totalMark': double.parse(assignment.totalMark) ,
        'className': assignment.className
      });

      await firestore.collection('users').getDocuments().then((querySnapshot) => {
        querySnapshot.documents.forEach((element) async {
          if(element.data['sId'] != null){
            await firestore.collection("users").document(element.data['sId']).get().then((value) async => {
              await firestore.collection('users').document('${element.data['sId']}').setData({
                "assignments":{
                  "${assignment.assignID}":0
                }
              }, merge: true)

            });
          }
        })

      }).then((value) =>  showAlertDialog(context));


    } catch (e) {
      print(e);
    }
  }

  void _onChangesId(String value) async {
    try {
      this.setState(() {
        assignment.assignID = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesHeading(String value) async {
    try {
      this.setState(() {
        assignment.heading = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesModule(String value) async {
    try {
      this.setState(() {
        assignment.module = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesAssign(String value) async {
    try {
      this.setState(() {
        assignment.assignedTo = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesClassName(String value) async {
    try {
      this.setState(() {
        assignment.className = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesMark(String value) async {
    try {
      this.setState(() {
        assignment.totalMark = value;
      });

    } catch (e) {
      print(e);
    }
  }


  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        clearTextInput();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Icon(Icons.check_circle_outline_rounded,size:50, color: Color(0xFF7401b8)),
      content:  Text("Successfully Added !!",textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF7401b8)) ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  clearTextInput(){
    assignID.clear();
    heading.clear();
    module.clear();
    className.clear();
    assignedTo.clear();
    totalMark.clear();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Color(0xFFe0e0e0),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child:
        Container(
          child: Column(
              children: <Widget>[
                Container(
                  height: 190,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.0),
                          bottomLeft: Radius.circular(50.0)),
                      image: new DecorationImage(
                        image: new AssetImage('images/2.2.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: SingleChildScrollView(
                      child:
                  Center(
                    child:
                    Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(top: 120.0, left: 20, bottom: 0, right: 20),
                            child: Text('ADD ASSIGNMENT',textAlign: TextAlign.center, style: TextStyle(
                                color: Color(0xFF310062), fontSize: 34, fontWeight: FontWeight.bold) ),
                          ),
                        ]
                    ),
                  )
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2,
                  child: TextFormField(
                    controller: assignID,
                    onChanged : (value)=>_onChangesId(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter assignment ID';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(labelText: "Assignment ID", labelStyle: TextStyle(
                        color: Color(0xFF7401b8), fontSize: 20.0
                    )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2,
                    child: TextFormField(
                      controller: heading,
                      onChanged : (value)=>_onChangesHeading(value),
                      decoration: new InputDecoration(labelText: "Assignment Heading", labelStyle: TextStyle(
                          color: Color(0xFF7401b8), fontSize: 20.0
                      )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2,
                    child: TextFormField(
                      controller: module,
                      onChanged : (value)=>_onChangesModule(value),
                      decoration: new InputDecoration(labelText: "Module", labelStyle: TextStyle(
                          color: Color(0xFF7401b8), fontSize: 20.0
                      )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2,
                    child: TextFormField(
                      controller: className,
                      onChanged : (value)=>_onChangesClassName(value),
                      decoration: new InputDecoration(labelText: "Assigned Class", labelStyle: TextStyle(
                          color: Color(0xFF7401b8), fontSize: 20.0
                      )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2,
                    child: TextFormField(
                      controller: assignedTo,
                      onChanged : (value)=>_onChangesAssign(value),
                      decoration: new InputDecoration(labelText: "Assigned Lecturer", labelStyle: TextStyle(
                          color: Color(0xFF7401b8), fontSize: 20.0
                      )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2,
                    child: TextFormField(
                      controller: totalMark,
                      onChanged : (value)=>_onChangesMark(value),
                      decoration: new InputDecoration(labelText: "Assigned Mark", labelStyle: TextStyle(
                          color: Color(0xFF7401b8), fontSize: 20.0
                      )),
                    ),
                  ),
                ),
                SizedBox(height:20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.7, height: MediaQuery.of(context).size.width*0.15,
                    child:
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
                          primary: Colors.white,
                          backgroundColor: Color(0xFF8c0074),
                          onSurface: Colors.grey,
                          textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        child: Text("ADD ASSIGNMENT",   style: TextStyle(fontSize: 17)),
                        onPressed: ()=> _create(context),
                      ),
                  ),
                ),

                    ],
                  ),
                )

              ]),
        )
        )
    );
  }



}

