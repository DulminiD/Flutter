import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/View/EditStudentView.dart';

Widget studentWidget(context, DocumentSnapshot data) {
  Widget body = Scaffold(
    backgroundColor: Color(0xFFe0e0e0),
    body: Column(children: [
      Container(
          height: 300,
          decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/2.2.png'),
                fit: BoxFit.cover,
              )),
          alignment: Alignment.center,
          child: imgSection(data['sImagePath'])
      ),
      fieldSection("Student ID", data['sId'], 20.0, 25.0),
      fieldSection("Name", data['sName'], 23.0, 30.0),
      fieldSectionRating("Rating", data['rating'], 15.0, 18.0),
      assignmentSection("Assignments"),
      Expanded(child: Container(
        child: listAssignment(data["assignments"])),
      )
    ]),
    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditStudentView(id: data['sId']),
            ));
      },
      child: const Icon(
        Icons.edit_outlined,
      ),
      backgroundColor: Color(0xFF8c0074),
    ),
  );

  return body;
}

Widget imgSection1 = Container(
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
    child: Container(
      child: Image.asset(
        'images/img.png',
        width: 200,
        height: 200,
      ),
    ));

Widget imgSection(path){
  return Container(
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
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  path
              )
          )
      ),
    ),
  );
}

Widget fieldSection(String name, String id, double font1, double font2) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex: 2,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: font1,
                    fontWeight: FontWeight.w500
                ),
              ),
            )),
        Expanded(
            flex: 3,
            child: Text(
              id,
              style: TextStyle(
                  fontSize: font2,
                  fontWeight: FontWeight.w600,
                fontFamily: 'PermanentMarker'
              ),
            ))
      ],
    ),
  );
}

Widget fieldSectionRating(String name, double id, double font1, double font2) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex: 2,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: font1,
                    fontWeight: FontWeight.w500
                ),
              ),
            )),
        Expanded(
            flex: 3,
            child: Text(
              id.toString(),
              style: TextStyle(
                  fontSize: font2,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'PermanentMarker'
              ),
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
                    color: Colors.black,
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
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
            child: Text(
                'Assignment ${index + 1} - ${data.values.elementAt(index)}',
            ),
        ),
      );
    },
  );
}
