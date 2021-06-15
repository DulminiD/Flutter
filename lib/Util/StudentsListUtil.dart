import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Controller/addStudent.dart';
import 'package:mobile_app/View/AddAssignmentView.dart';
import 'StudentListOneItem.dart';

Widget buildUserList(
    BuildContext context,
    AsyncSnapshot<QuerySnapshot> snapshot,
    ScrollController _mainScrollController,
    ScrollController _subScrollController,
    double _removableWidgetSize,
    bool _isStickyOnTop,
    TextEditingController _controller,
    _changeState) {
  if (snapshot.hasData) {
    return Container(
        
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Flexible(
              child: Stack(children: [
            ListView(
                controller: _mainScrollController,
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                                 image: new DecorationImage(
                                      image: new AssetImage('images/2.png'),
                                         fit: BoxFit.cover,
            )
                              ),
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              
                              alignment: Alignment.center,
                              height: _removableWidgetSize,
                              // color: Colors.deepPurple[600],

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // -------------------------- Add Student Button ---------------------------------------------------------------------------
                                      buttonWidget(
                                        0.0,
                                        5.0,
                                        context,
                                        'Student',
                                        Icons.add_circle_outline_sharp,
                                      ),

                                      // -------------------------- Add Assignment Button ---------------------------------------------------------------------------
                                      buttonWidget(
                                        0.0,
                                        5.0,
                                        context,
                                        'Assignment',
                                        Icons.add_circle_outline_sharp,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                         _getStickyWidget(_controller, _changeState, false),
                      ],
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        controller: _subScrollController,
                        padding: EdgeInsets.only(top: 4),
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot user =
                              snapshot.data.documents[index];
                          return studenlistView(user, context);
                        }),
                  )
                ]),
            if (_isStickyOnTop) _getStickyWidget(_controller, _changeState, true)
          ]))
        ]));
  } else if (snapshot.connectionState == ConnectionState.done &&
      !snapshot.hasData) {
    // Handle no data
    return Center(
      child: Text("No users found."),
    );
  } else {
    // Still loading
    return CircularProgressIndicator();
  }
}

InkWell buttonWidget(double mLeft, double mRight, BuildContext context,
    String btnName, IconData btnIcon) {
  return InkWell(
    onTap: () => {
      if (btnName == 'Student')
        {_goToAddStudent(context)}
      else
        {_goToAddAssignment(context)}
    },
    child: Container(
      margin: EdgeInsets.only(top: 40, bottom: 10, right: mRight, left: mLeft),
      width: 150.0,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0.0, 20.0), blurRadius: 30.0, color: Colors.black12)
      ], color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 110.0,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Text(
              btnName,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Color(0xFF8c0074),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90.0),
                  topLeft: Radius.circular(90.0),
                  bottomRight: Radius.circular(200.0),
                )),
          ),
          Icon(
            btnIcon,
            size: 30.0,
          )
        ],
      ),
    ),
  );
}

DecorationImage _setImage(bool status){
  if(status){
  return DecorationImage(
              image: new AssetImage('images/2.png'),
              fit: BoxFit.cover,
            );
  }else{
    return null;
  }
}

Container _getStickyWidget(_controller, _changeState, bool status) {
  return Container(
    alignment: Alignment.center,
    height: 120,
    decoration: BoxDecoration(
      image: _setImage(status),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        )),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: TextField(
        autofocus: false,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 18),
        onChanged: (value) {
          _changeState(value);
        },
        controller: _controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.5),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ), // icon is 48px widget.
          ),
          suffixIcon: IconButton(
            onPressed: () => {_controller.clear(), _changeState('')},
            icon: Icon(Icons.clear),
          ),
          border: OutlineInputBorder(),
          hintText: 'Search By Name',
          
        ),
      ),
    ),
  );
}

void _goToAddStudent(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStudent(),
      ));
}

void _goToAddAssignment(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAssignmentView(),
      ));
}

void deteleUser(String id) {
  Firestore.instance
      .collection('users')
      .document(id) // <-- Doc ID to be deleted.
      .delete() // <-- Delete
      .then((_) => print('Deleted'))
      .catchError((error) => print('Delete failed: $error'));
}

Future confirmAndDetele(context, String studentID) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Confirm Delete"),
        content: new Text("Are you sure to delete this student ?"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Delete"),
            color: Colors.red,
            onPressed: () {
              deteleUser(studentID);
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Cancel"),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
