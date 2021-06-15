import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/Util/AddRatingUtil.dart';

class AddRating extends StatefulWidget {
  final String id;
  const AddRating({Key key,@required this.id}) : super(key: key);
  @override
  _AddRatingState createState() => _AddRatingState(this.id);
}

class _AddRatingState extends State<AddRating> {
  String id;

  _AddRatingState(String id){
    this.id =id;
  }
  final Firestore firestore = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0e0e0),
      body: Container(
        width: 420,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0)),
            image: new DecorationImage(
              image: new AssetImage('images/2.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric( vertical: 60.0),
              child:
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('users').snapshots(),
                builder: (context, snapshot) {
                  Widget widget;
                  if (!snapshot.hasData) {
                    return widget = Text('...Loading!!');
                  }else{
                    widget = addRatingWidget(snapshot.data, context, id);
                  }
                  return widget;
                }
            ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return  addRate(id, context);
              }
          );
        },
        child: const Icon(Icons.star),
        backgroundColor: Colors.pink,
      ),
    );

    // return Scaffold(
    //   backgroundColor: Color(0xFFe0e0e0),
    //   body: Container(
    //     width: 420,
    //     height: 900,
    //     alignment: Alignment.topCenter,
    //     // constraints: BoxConstraints.expand(),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //             bottomRight: Radius.circular(50.0),
    //             bottomLeft: Radius.circular(50.0)),
    //         image: new DecorationImage(
    //           image: new AssetImage('images/2.png'),
    //           fit: BoxFit.cover,
    //         )
    //     ),
    //     child: Column(
    //         children: <Widget>[
    //           StreamBuilder<QuerySnapshot>(
    //             stream: firestore.collection('users').snapshots(),
    //             builder: (context, snapshot) {
    //               Widget widget;
    //               if (!snapshot.hasData) {
    //                 return widget = Text('...Loading!!');
    //               }else{
    //                 widget = addRatingWidget(snapshot.data, context);
    //               }
    //               return widget;
    //             }
    //           ),
    //         ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       showDialog(
    //           context: context,
    //           builder: (context) {
    //            return  addRate('IT001');
    //           }
    //       );
    //     },
    //     child: const Icon(Icons.add_reaction_rounded),
    //     backgroundColor: Colors.pink,
    //   ),
    // );
  }
}