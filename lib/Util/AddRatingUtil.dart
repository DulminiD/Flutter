

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


Widget addRatingWidget(QuerySnapshot snapshot, BuildContext buildContext) {
  var assignments = {};
  var total;
  var count;
  List mappingList = [];
  List student = [];
  var profile = {};

  snapshot.documents.forEach((element) {
    if(element.data['sId'] == "IT001"){
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
      List c = mappingList.where((e) => e["name"] == key.key).toList();
      if(c.length == 0){
        mappingList.add({
          'mark':key.value.toString(),
          'assignment':key.key,
          'classAverage': (total/count).toString()
        });
      }

    }else{
      mappingList.add({
        'mark':key.value.toString(),
        'assignment':key.key,
        'classAverage': (total/count).toString()
      });
    }

  }

  Widget body =  Container(
      child:Column(
        children: <Widget>[
          // studentDetails(profile),
          dog,
           assignmentDetails(mappingList),
        ],
      ),
    );

  return body;
}





Widget studentDetails(details) {
  return Card(
    elevation: 8.0,
    color: Colors.transparent,
    margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
    child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0, top: 0),
            decoration: new BoxDecoration(
                border: new Border(

                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: details['sImagePath'] != null ? Icon(Icons.autorenew, color: Colors.white) : Icon(Icons.account_circle_rounded, color: Colors.white, size: 50,),
          ),
          title: Column(
            children: <Widget>[
              Text(
                "Student ID : ${details['sId']}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                "Student Name : ${details['sName']}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                "Module : ${details['sModule']}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ) ,
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text("Class Average :",
                  style: TextStyle(color: Colors.white, fontSize: 13))
            ],
          ),
        )
    ),
  );
}

Widget assignmentDetails(assignments){
  return ListView.builder(
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
                  child: Icon(Icons.format_list_bulleted, color: Colors.black87),
                ),
                title:  Text(
                  "${assignments[index]['assignment']}",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.linear_scale, color: Colors.yellowAccent),
                    Text("Class Average : ${assignments[index]['classAverage']}", style: TextStyle(color: Colors.black87, fontSize: 13))
                  ],
                ),
                trailing:
                // Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)) ,
                Text("${assignments[index]['mark']}", style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold))),



          ),
        );
      });
}

Widget sample = Container(
       height: 120.0,
       margin: const EdgeInsets.symmetric(
       vertical: 30.0,
       horizontal: 24.0,
          ),
      child: new Stack(
          children: <Widget>[
      new Container(
         height: 124.0,
             margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.white10,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  )
        ,
          Container(
                 margin: new EdgeInsets.symmetric(
             vertical: 1.0
                 ),
              alignment: FractionalOffset.centerLeft,
              child: new Icon(Icons.account_circle_rounded, color: Colors.black87,size: 100,
           //    new Image(
           // image: new AssetImage("assets/img/mars.png"),
        // height: 92.0,
        //   width: 92.0,
       ),
  ),
      ],
    )
   );


Widget addRate(value){

  Widget body = Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text('Add Rating',
                style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.add_reaction, color:Colors.white,),
              textColor: Colors.white,
              color: Colors.black87,
              onPressed: () {
                showDialog(
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 400.0,
                        width: 360.0,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Add Rating",
                                style: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ratingg,
                            )


                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),
    ),
  );
  return body;
}

Widget ratingg = RatingBar.builder(

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
  },
);


Widget dog =  Card(
  elevation: 8.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
  child: Container(

    decoration: BoxDecoration(color: Colors.black12,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text('ddd'),
  ),
);

Widget dog2 = Column(
  children: <Widget>[
    new Row(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(0.0),
          child: new Container(
            margin: const EdgeInsets.all(16.0),
            child: new Container(
              width: 70.0,
              height: 70.0,
            ),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Colors.grey,
              // image: new DecorationImage(
              //     image: new NetworkImage(
              //         image_url + movies[i]['poster_path']),
              //     fit: BoxFit.cover),
              boxShadow: [
                new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: new Offset(2.0, 5.0))
              ],
            ),
          ),
        ),
        new Expanded(

            child: new Container(
              margin: const      EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
              child: new Column(children: [
                new Text(
                  'Main',
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Arvo',
                      fontWeight: FontWeight.bold,
                      color: Colors.black12),
                ),
                new Padding(padding: const EdgeInsets.all(2.0)),
                new Text('overview',
                  maxLines: 3,
                  style: new TextStyle(
                      color: const Color(0xff8785A4),
                      fontFamily: 'Arvo'
                  ),)
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
);