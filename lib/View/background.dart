import 'package:flutter/material.dart';

class background extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFe0e0e0),
        body:
              Container(
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
                // child: Center(
                //   child: Text('WELCOME!',
                //     textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
                //   ),
                // ),
              ),
      ),
    );
  }
}