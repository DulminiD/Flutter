import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/View/EditStudentView.dart';

Widget studentWidget(context, DocumentSnapshot data) {
  Widget body = Scaffold(
    body: Column(children: [
      Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: imgSection),
      fieldSection("Student ID", data['sId'], 22.0, 30.0),
      fieldSection("Name", data['sName'], 22.0, 22.0),
      assignmentSection("Assignments"),
      Expanded(child: listAssignment(data["assignments"])),
    ]),
    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditStudentView(id: 'IT03'),
            ));
      },
      child: const Icon(Icons.edit_outlined ),
      backgroundColor: Colors.amber[600],
    ),
  );

  return body;
}

Widget imgSection = Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 8,
        blurRadius: 25,
        offset: Offset(15, 15), // changes position of shadow
      ),
    ],
  ),
  child: Image.asset(
    'images/img.png',
    width: 200,
    height: 200,
  ),
);

Widget fieldSection(String name, String id, double font1, double font2) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex: 3,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: font1,
                    fontWeight: FontWeight.w300),
              ),
            )),
        Expanded(
            flex: 2,
            child: Text(
              id,
              style: TextStyle(fontSize: font2, fontWeight: FontWeight.w600),
            ))
      ],
    ),
  );
}

Widget assignmentSection(String name) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 1,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300),
              ),
            )),
      ],
    ),
  );
}

Widget listAssignment(data) {
  return ListView.builder(
    padding: const EdgeInsets.all(30),
    itemCount: data.length,
    itemBuilder: (context, index) {
      return Container(
        height: 50,
        color: Colors.amber[300 - (index * 100)],
        child: Center(child: Text('Assignment ${index+1} - ${data[index.toString()]}')),
      );
    },
  );
}
