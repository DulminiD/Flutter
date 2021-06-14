import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/View/AddRating.dart';
import 'package:mobile_app/View/StudentView.dart';

import 'StudentsListUtil.dart';

Padding studenlistView(dataArray, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
    child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.circular(60 / 2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT85rYK5YznuLXnNlbKoK-iRxOLyywBcT6Y3w&usqp=CAU"))),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  // child: Container(

                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentView(id: dataArray.data['sId']),
                            ));
                      },
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '${dataArray.data['sId']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '${dataArray.data['sName']}',
                                style: TextStyle(
                                    color: Colors.blue[600],
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: ClipOval(
                            child: Material(
                              color: Colors.blue, // Button color
                              child: InkWell(
                                splashColor:
                                    Colors.purpleAccent, // Splash color
                                onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                   AddRating(id: dataArray.data['sId'],),
                            ));},
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(Icons.compare_sharp)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: ClipOval(
                            child: Material(
                              color: Colors.red[500], // Button color
                              child: InkWell(
                                splashColor:
                                    Colors.purpleAccent, // Splash color
                                onTap: () {
                                  confirmAndDetele(
                                      context, dataArray.data['sId']);
                                },
                                child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(Icons.delete_forever_sharp)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}
