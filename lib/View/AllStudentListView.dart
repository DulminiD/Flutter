import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/Util/StudentsListUtil.dart';

class AllStudentListView extends StatefulWidget {
  const AllStudentListView({Key key}) : super(key: key);

  @override
  _AllStudentListViewState createState() => _AllStudentListViewState();
}

class _AllStudentListViewState extends State<AllStudentListView> {
  ScrollController _mainScrollController = ScrollController();
  ScrollController _subScrollController = ScrollController();
  TextEditingController _controller = TextEditingController();

  double _removableWidgetSize = 100;
  bool _isStickyOnTop = false;

  String searchKey;
  Stream<QuerySnapshot> streamQuery =
      Firestore.instance.collection('users')
      .orderBy('rating').snapshots();
  // TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mainScrollController.addListener(() {
      if (_mainScrollController.offset >= _removableWidgetSize &&
          !_isStickyOnTop) {
        _isStickyOnTop = true;
        setState(() {});
      } else if (_mainScrollController.offset < _removableWidgetSize &&
          _isStickyOnTop) {
        _isStickyOnTop = false;
        setState(() {});
      }
    });
  }

  _changeState(String value) {
    setState(() {
      searchKey = value;
      streamQuery = Firestore.instance
          .collection('users')
          .where('sName', isGreaterThanOrEqualTo: searchKey)
          .where('sName', isLessThan: searchKey + 'z')
          .orderBy('rating')
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFe0e0e0),
            body: StreamBuilder(
          stream: streamQuery,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return buildUserList(
                context,
                snapshot,
                _mainScrollController,
                _subScrollController,
                _removableWidgetSize,
                _isStickyOnTop,
                _controller,
                _changeState);
          },
        )));
  }
}
