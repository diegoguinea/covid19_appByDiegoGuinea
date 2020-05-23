import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/home.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplshScr createState() => _SplshScr();
}

class _SplshScr extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder:(BuildContext context){
     return DWidget();
   }))
   );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 400,
             width: 400,
             child : Image.asset('assets/diegoguinea.png'),
          ),
          Center(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Center(
                        child: Text('Creada por Diego Guinea',style: TextStyle(fontSize: 12, color: Colors.black),),
                      )
                  ),
                ]
            ),
          ),
      ],),
    );
  }
}