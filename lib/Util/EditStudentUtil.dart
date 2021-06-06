import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/View/StudentView.dart';

Widget editStudentWidget(DocumentSnapshot data, BuildContext buildContext) {
  TextEditingController controller =
      new TextEditingController(text: data["sName"]);
  List<TextEditingController> controllers = [];
  Widget body = Scaffold(
    body: Column(children: [
      Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              imgSection,
              Text(
                'Student ID',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                data['sId'],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ],
          )),
      Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ))
          ],
        ),
      ),
      assignmentSection("Assignments"),
      Expanded(
          child: ListView.builder(
        padding: const EdgeInsets.all(30),
        itemCount: data["assignments"].length,
        itemBuilder: (context, index) {
          controllers.add(new TextEditingController(
              text: data["assignments"][index.toString()].toString()));
          return Container(
            height: 50,
            color: Colors.amber[300 - (index * 100)],
            child: Center(
                child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Assignment ${index + 1} - '),
                ),
                Flexible(
                  child: TextField(
                    controller: controllers[index],
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            )),
          );
        },
      )),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          primary: Colors.black,
          backgroundColor: Colors.amber[300],
          onSurface: Colors.grey,
          textStyle: TextStyle(
              fontSize: 20,
          ),
        ),
        onPressed: () {
          update(data["sId"], controller, controllers, buildContext);
        },
        child: Text('Save'),
      ),
    ]),
  );

  return body;
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

void update(id, TextEditingController controller,
    List<TextEditingController> controllers, BuildContext buildContext) async {
  final Firestore firestore = Firestore.instance;
  print(id);
  print(controller.text);
  HashMap hashMap = new HashMap<String, int>();
  for (var i = 0; i < controllers.length; i++) {
    hashMap[i.toString()] = int.parse(controllers[i].text);
  }
  print(hashMap);
  try {
    firestore.collection('users').document(id).updateData({
      'sName': controller.text,
      'assignments': hashMap
    }).then((value) => {
          Navigator.push(buildContext,
              MaterialPageRoute(builder: (context) => StudentView(id: id))),
        });
  } catch (e) {
    print(e);
  }
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
    width: 100,
    height: 100,
  ),
);
