import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'home.dart';

class Lector extends StatelessWidget {

  static const String routeName = '/Lector_qr';

  String qrData = "https://www.salesianssarria.com/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Codigo QR'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: new Container(
            margin: const EdgeInsets.only(top: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QrImage(data: qrData),
              ],
            ),
          ),
        ),
      ),
    );
  }


}