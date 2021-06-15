

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


Widget addRatingWidget(QuerySnapshot snapshot, BuildContext buildContext, id) {
  var assignments = {};
  var total;
  var count;
  List mappingList = [];
  List student = [];
  var profile = {};

  snapshot.documents.forEach((element) {
    if(element.data['sId'] == id){
      student.add(element.data);
      if(element.data['assignments'] != null){
        assignments = element.data['assignments'];
      }
    }
  });

  profile = student[0];

  for(var key in assignments.entries) {
    total = 0;
    count = 0;
    snapshot.documents.forEach((element) {
      if(element.data['assignments'] != null){
        if(element.data['assignments']['${key.key}'] != null){
          total = total + element.data['assignments']['${key.key}'];
          count++;
        }
      }
    });

    if(mappingList.length != 0){
      List c = mappingList.where((e) => e["assignment"] == key.key).toList();
      if(c.length == 0){
        mappingList.add({
          'mark':key.value.toString(),
          'assignment':key.key,
          'classAverage': (total/count).toStringAsFixed(2)
        });
      }

    }else{
      mappingList.add({
        'mark':key.value.toString(),
        'assignment':key.key,
        'classAverage': (total/count).toStringAsFixed(2)
      });
    }

  }

  Widget body =  Container(
      child:Column(
        children: <Widget>[
          studentDetails(profile),
          assignmentDetails(mappingList,buildContext),
        ],
      ),
    );

  return body;
}

Widget studentDetails(details) {
  return  Container(
    child: Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 170,
        decoration: BoxDecoration(color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(0.0),
                  child:
                  //details['sImagePath'] != null ?
                  // new Container(
                  //   margin: const EdgeInsets.all(16.0),
                  //   child: new Container(
                  //     width: 100.0,
                  //     height: 100.0,
                  //   ),
                  //   decoration: new BoxDecoration(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  //     color: Colors.grey,
                  //     // image: new DecorationImage(
                  //     //     image: new AssetImage(details['sImagePath']),
                  //     //     fit: BoxFit.cover),
                  //     boxShadow: [
                  //       new BoxShadow(
                  //           color: Colors.black12,
                  //           blurRadius: 5.0,
                  //           offset: new Offset(2.0, 5.0))
                  //     ],
                  //   ),
                  // )
                  //:
                  new Container(
                    margin: const EdgeInsets.all(16.0),
                    child: new Container(
                      child: Icon(Icons.account_circle,size: 110,),
                      width: 100.0,
                      height: 100.0,
                    ),

                  ),
                ),
                new Expanded(

                    child: new Container(
                      margin: const      EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
                      child: new Column(children: [
                        new Text(
                          'PROFILE | ${details['sId']}',
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Arvo',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8c0074)),
                        ),
                        new Padding(padding: const EdgeInsets.all(2.0)),
                        new Text('Name: ${details['sName']}',
                          maxLines: 3,
                          style: new TextStyle(
                              color: const Color(0xff8785A4),
                              fontFamily: 'Arvo',
                              fontSize: 17
                          ),),
                        new Padding(padding: const EdgeInsets.all(2.0)),
                        new Text('Module: ${details['sModule']}',
                          maxLines: 3,
                          style: new TextStyle(
                              color: const Color(0xff8785A4),
                              fontFamily: 'Arvo',
                              fontSize: 17
                          ),),
                        new Padding(padding: const EdgeInsets.all(2.0)),
                        ratedBar(4.0)
                      ],
                        crossAxisAlignment: CrossAxisAlignment.start,),
                    )
                ),
              ],
            ),
            new Container(
              width: 300.0,
              height: 0.5,
              color: const Color(0xD2D2E1ff),
              margin: const EdgeInsets.all(16.0),
            )
          ],
        )
      ),
    )

  );
}

Widget assignmentDetails(assignments,buildContext){
  return Container(
    height: MediaQuery.of(buildContext).size.height/1.9,
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: assignments.length,
      itemBuilder:(context, index){
        return  Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
          child: Container(

            decoration: BoxDecoration(color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.4),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: Colors.white24))),
                  child: Icon(Icons.format_list_bulleted, color: Color(0xFF310062)),
                ),
                title:  Text(
                  "${assignments[index]['assignment']}",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.linear_scale, color: Color(0xFF8c0074)),
                    Text("Class Average : ${assignments[index]['classAverage']}", style: TextStyle(color: Colors.black87, fontSize: 15.5))
                  ],
                ),
                trailing:
                // Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)) ,
                Text("${assignments[index]['mark']}", style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold))),



          ),
        );

      }));
}
bool a = false;
Widget addRate(stId,BuildContext context){
    return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 16,
    child: Container(
      height: 450.0,
      width: 360.0,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Text(
              "Add Rating",
              style: TextStyle(fontSize: 24, color: Color(0xFF310062), fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ratingBar(stId, context),
          ),
        ],
      ),
    ),
  );
}

double rate = 0;

Widget ratedBar(rated){
  return RatingBar.builder(
    initialRating: rated,
    minRating: rated,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
      size: 2.0,
    ),
  );
}

Widget ratingBar(stId, BuildContext context) {
  return RatingBar.builder(
    initialRating: 3,
    itemCount: 5,
    itemBuilder: (context, index) {
      switch (index) {
        case 0:
          return Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
          );
        case 1:
          return Icon(
            Icons.sentiment_dissatisfied,
            color: Colors.redAccent,
          );
        case 2:
          return Icon(
            Icons.sentiment_neutral,
            color: Colors.amber,
          );
        case 3:
          return Icon(
            Icons.sentiment_satisfied,
            color: Colors.lightGreen,
          );
        case 4:
          return Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.green,
          );
      }
    },
    onRatingUpdate: (rating) {
      print(rating);
      _addRating(rating,stId, context);
    },
  );
}



  void _addRating(value, stId, BuildContext context) async {
    try {
      await Firestore.instance.collection('users').document(stId)
          .setData({'rating': value}, merge: true).then((value) =>
          print('rating added successfuly'));
          showAlertDialog(context, value);

    } catch (e) {
      print(e);
    }
  }


showAlertDialog(BuildContext context, value) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Icon(Icons.check_circle_outline_rounded,size:50, color: Color(0xFF7401b8)),
    content:  Text("Rated as ${value}/5!!",textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF7401b8)) ),
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
