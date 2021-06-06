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
      appBar: AppBar(
        title: Text("Flutter CRUD with Firebase"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 22,),
                Center(
                  child: GestureDetector( onTap: () {_showPicker(context); },
                    child: CircleAvatar( radius: 55, backgroundColor: Color(0xffFDCF09),
                      child: _image != null ? ClipRRect( borderRadius: BorderRadius.circular(50),
                        child: Image.file(_image, width: 100, height: 100, fit: BoxFit.fitHeight,), )
                          : Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(50)), width: 100, height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2, child: TextField(
                    controller: sId,
                    decoration: new InputDecoration(labelText: "Student ID"),
                    onChanged : (value)=>_onChangesId(value),
                  ),),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2, child: TextField(
                    controller: sName,
                    decoration: new InputDecoration(labelText: "Student Name"),
                    onChanged : (value)=>_onChangesName(value),
                  ),),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: MediaQuery.of(context).size.width*0.8, height: MediaQuery.of(context).size.width*0.2, child: TextField(
                    controller: sModule,
                    decoration: new InputDecoration(labelText: "Student Module"),
                    onChanged : (value)=>_onChangesModule(value),
                  ),),
                ),
                RaisedButton(
                  child: Text("Create"),
                  onPressed: ()=> _create(context),
                ),
              ]),
        ),
      )
    );
  }
}


// Container(
// padding: const EdgeInsets.all(10.10),
// child: Image.file(new File("/data/user/0/com.example.mobile_app/app_flutter/IT11.jpg")),
// ),