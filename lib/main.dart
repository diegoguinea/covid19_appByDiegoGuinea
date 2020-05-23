import 'package:covid19_app/comentarios.dart';
import 'package:covid19_app/Codigoqr.dart';
import 'package:covid19_app/services/lang.dart';
import 'package:covid19_app/splash.dart';
import 'package:covid19_app/widgets/ajustes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/widgets/information.dart';
import 'package:covid19_app/widgets/map.dart';
import 'package:covid19_app/Routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          const Locale('en'), // English
          const Locale('es'), // Castellano
        ],
        localizationsDelegates: [
          multilang.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: SplashScreen(),             //      new DWidget(),
        routes: <String, WidgetBuilder>{
          Routes.map: (BuildContext context) => new MapPage(),
          Routes.information: (BuildContext context) => new InfoPage(),
          Routes.settings: (BuildContext context) => new SettingsPage(),
          Routes.com: (BuildContext context) => new Coment(),
          Routes.lectorqr: (BuildContext context) => new Lector(),
        }
    );
  }
}






