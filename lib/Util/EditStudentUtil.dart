import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/View/StudentView.dart';

Widget editStudentWidget(DocumentSnapshot data, BuildContext buildContext) {
  TextEditingController controller =
  new TextEditingController(text: data["sName"]);
  List<TextEditingController> controllers = [];
  List<String> assignmentNames = [];

  Widget body = Scaffold(
    backgroundColor: Color(0xFFe0e0e0),
    body: Column(
        children: [
          Container(
            height: 300,
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
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        imgSection,
                        Text(
                          data['sId'],
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                ),
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
                                  fontWeight: FontWeight.w700),
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding:
                                EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
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
                      text: data["assignments"].values.elementAt(index)
                          .toString()));
                  assignmentNames.add(
                      data["assignments"].keys.elementAt(index));
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Assignment ${index + 1} - '),
                            ),
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding:
                                  EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                controller: controllers[index],
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        )),
                  );
                },
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  primary: Colors.white,
                  backgroundColor: Color(0xFF8c0074),
                  onSurface: Colors.grey,
                  textStyle: TextStyle(
                    fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),
                ),
                onPressed: () {
                  update(data["sId"], controller, controllers, buildContext,
                      assignmentNames);
                },
                child: Text(
                  'SAVE',
                ),
              ),
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
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w400),
              ),
            )),
      ],
    ),
  );
}

void update(id,
    TextEditingController controller,
    List<TextEditingController> controllers,
    BuildContext buildContext,
    List<String> assignmentNames) async {
  final Firestore firestore = Firestore.instance;
  print(id);
  print(controller.text);
  HashMap hashMap = new HashMap<String, int>();
  for (var i = 0; i < controllers.length; i++) {
    hashMap[assignmentNames[i]] = int.parse(controllers[i].text);
  }
  print(hashMap);
  try {
    firestore.collection('users').document(id).updateData({
      'sName': controller.text,
      'assignments': hashMap
    }).then((value) =>
    {
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
    width: 150,
    height: 150,
  ),
);
