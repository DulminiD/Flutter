import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/Util/AddRatingUtil.dart';

class AddRating extends StatefulWidget {
  const AddRating({Key key}) : super(key: key);

  @override
  _AddRatingState createState() => _AddRatingState();
}

class _AddRatingState extends State<AddRating> {

  final Firestore firestore = Firestore.instance;

  void _addRating(value) async {
    try {
      await firestore.collection('users').document('user_test')
          .setData({'rating': value}, merge: true).then((value) =>
          print('rating added successfuly'));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFe0e0e0),
      body: Container(
        width: 420,
        height: 400,
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
              StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('users').snapshots(),
                builder: (context, snapshot) {
                  Widget widget;
                  if (!snapshot.hasData) {
                    return widget = Text('...Loading!!');
                  }else{
                    widget = addRatingWidget(snapshot.data, context);
                  }
                  return widget;
                }
              ),
            ],
        ),
      ),
      bottomNavigationBar: addRate('IT001'),
    );
  }
}