import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class mainView extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
              children: <Widget>[
          Container(
            // constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage('images/8.png'),
                fit: BoxFit.cover,
              )
              ),
            // child: Center(
            //   child: Text('WELCOME!',
            //     textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
            //   ),
            // ),
            ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 80.0, right: 30.0),
                  child: Text('DULMAYNAY!',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold) ),
                )
              ],
          ),
          ),
        ),
    );
  }
}