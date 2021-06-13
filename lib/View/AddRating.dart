import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AddRating extends StatefulWidget {
  const AddRating({Key key}) : super(key: key);

  @override
  _AddRatingState createState() => _AddRatingState();
}

class _AddRatingState extends State<AddRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Add Ratings'),
    );
  }
}
