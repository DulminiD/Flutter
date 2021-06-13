import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Model/Student.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final Firestore firestore = Firestore.instance;
  Student student = new Student();
  final sId = TextEditingController();
  final sName = TextEditingController();
  final sModule = TextEditingController();
  File _image;

  void addImage() async{
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/'+student.sId+'.jpg'; // 3
    final File localImage = await _image.copy(filePath);
    setState(() {
      student.sImage = localImage.path;
    });

  }


  void _create(BuildContext context) async {
    await addImage();
    try {
      await firestore.collection('users').document(student.sId).setData({
        'sId': student.sId,
        'sName': student.sName,
        'sModule': student.sModule,
        'sImagePath': student.sImage
      }).then((value) => {
        showAlertDialog(context)
      });
    } catch (e) {
      print(e);
    }
  }

  void _onChangesId(String value) async {
    try {
      this.setState(() {
        student.sId = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesName(String value) async {
    try {
      this.setState(() {
        student.sName = value;
      });

    } catch (e) {
      print(e);
    }
  }

  void _onChangesModule(String value) async {
    try {
      this.setState(() {
        student.sModule = value;
      });

    } catch (e) {
      print(e);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        clearTextInput();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Student added!"),
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

  clearTextInput(){
    sId.clear();
    sName.clear();
    sModule.clear();
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFe0e0e0),
      resizeToAvoidBottomInset: false,
      body:
          Container(
            child: Column(
                children: <Widget>[
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
                      // decoration: BoxDecoration(
                      //     image: new DecorationImage(
                      //       image: new AssetImage('images/8.png'),
                      //       fit: BoxFit.cover,
                      //     )
                      // ),
                      child: Flexible( child:
                      Center(
                        child:
                        Column(
                            children: <Widget>[

                              // Container(
                              //   height: 250.0,
                              //   width: 250.0,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //       image: AssetImage(
                              //           'images/2.png'),
                              //       fit: BoxFit.fill,
                              //     ),
                              //     shape: BoxShape.rectangle,
                              //   ),
                              // ),
                              Container(
                                margin: const EdgeInsets.only(top: 30.0, left: 10, bottom: 30),
                                child:
                              Center(
                                child: GestureDetector( onTap: () {_showPicker(context); },
                                  child: CircleAvatar( radius: 80, backgroundColor: Color(0xFFc401a3),
                                    child: _image != null ? ClipRRect( borderRadius: BorderRadius.circular(50),
                                      child: Image.file(_image, width: 100, height: 100, fit: BoxFit.fitHeight,), )
                                        : Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(95)), width: 150, height: 150,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                margin: const EdgeInsets.only(top: 30.0, left: 20, bottom: 0, right: 20),
                                child: Text('ADD STUDENT',textAlign: TextAlign.center, style: TextStyle(
                                    color: Color(0xFF310062), fontSize: 34, fontWeight: FontWeight.bold) ),
                              ),
                  ]
            ),
          )
                      ),
          ),
                  Container(
                      margin: const EdgeInsets.only(top: 20, right: 30.0, left: 30.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.blue, width: 5),
                        //   color : Colors.white
                      ),
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2, child: TextField(
                                controller: sId,
                                decoration: new InputDecoration(labelText: "Student ID", labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20.0
                                )
                                ),
                                onChanged : (value)=>_onChangesId(value),
                              ),),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2, child: TextField(
                                controller: sName,
                                decoration: new InputDecoration(labelText: "Student Name", labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20.0
                                )),
                                onChanged : (value)=>_onChangesName(value),
                              ),),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2, child: TextField(
                                controller: sModule,
                                decoration: new InputDecoration(labelText: "Student Module", labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20.0
                                )),
                                onChanged : (value)=>_onChangesModule(value),
                              ),),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
                                primary: Colors.white,
                                backgroundColor: Color(0xFF8c0074),
                                onSurface: Colors.grey,
                                textStyle: TextStyle(
                                  fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              child: Text("ADD STUDENT"),
                              onPressed: ()=> _create(context),
                            ),
                          ],
                        ),
                      )
                  ),
            ]),
                        )
    );
  }
}


// Container(
// padding: const EdgeInsets.all(10.10),
// child: Image.file(new File("/data/user/0/com.example.mobile_app/app_flutter/IT11.jpg")),
// ),