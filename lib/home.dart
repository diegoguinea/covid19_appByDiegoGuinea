import 'package:covid19_app/services/lang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/widgets/map.dart';
import 'package:covid19_app/Routes.dart';



class DWidget extends StatelessWidget {


  @override
  Widget build (BuildContext context) {
    multilang localizations =  Localizations.of<multilang>(context, multilang);

    return new Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: Text(localizations.titulomap),
          backgroundColor: Colors.black,
          centerTitle: true,
      ),

      body: MapScreen(),
    );
  }
}
class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:<Widget>[
          _createHeader(),
          new ListTile(
            leading: Icon(Icons.map, color: Colors.black, size: 28 ),
            title: Text(localizations.mapa,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushNamed(context, Routes.map);
            },
          ),
          new ListTile(
            leading: Icon(Icons.important_devices,color: Colors.black),
            title: Text("Codigo QR",style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.lectorqr);
            },
          ),
          new ListTile(
            leading: Icon(Icons.comment,color: Colors.black),
            title: Text("Comentarios",style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.com);
            },
          ),
          new ListTile(
            leading: Icon(Icons.settings,color: Colors.black),
            title: Text(localizations.ajustes,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.settings);
            },
          ),
          new ListTile(
            leading: Icon(Icons.info,color: Colors.black),
            title: Text(localizations.informacion,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.information);
            },
          ),
        ],
      ) ,
    );
  }
}
Widget _createHeader(){
  return UserAccountsDrawerHeader(
    accountName: Text("S2AM",style: TextStyle(color: Colors.black),),
    //accountEmail: Text("usuario@gmail.com"),
    decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0),
        image: DecorationImage(
            fit : BoxFit.cover,
            alignment: Alignment.center,
                image: AssetImage('assets/diegoguinea.png'),
        )
    ),
  );
}

