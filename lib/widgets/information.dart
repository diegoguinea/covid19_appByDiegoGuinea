import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covid19_app/home.dart';
import 'package:covid19_app/services/lang.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:covid19_app/utils/constants.dart';


class InfoPage extends StatelessWidget{

  static const String routeName = '/information';

  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return new Scaffold(
        appBar: AppBar(
          title: Text(localizations.informacion),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: InformationScreen());
  }
}

class InformationScreen extends StatefulWidget{

  InformationScreen({Key key}) : super(key : key);
  @override
  InformationScreenState createState() => InformationScreenState();
}

class InformationScreenState extends State<InformationScreen> {
  Future<InformationData> post;
  Future<String> appVersion;

  @override
  void initState(){
    super.initState();
    post = fetchInformation();
    appVersion = getAppVersion();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BottomAppBar(
        child: SingleChildScrollView(
          child: Column(
              children:<Widget>[
                Container(
                  width: 300 ,
                  height: 200 ,
                  child : Image.asset('assets/diegoguinea.png'),
                ),
                Container(
                  child: FutureBuilder<InformationData>(
                      future: post,
                      builder: (context, snapshot){
                        if(snapshot.hasData) {
                          if(snapshot.data.valor == 1) {
                            return Container(margin: EdgeInsets.all(15.0),
                              child: Center(
                                child: Text(snapshot.data.texto),),);
                          }
                        }else if(snapshot.hasError){
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      }
                  ),
                ),
              ]
             ),
          ),
        ),
    );
  }

  Future<String> getAppVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<InformationData> fetchInformation() async{


    final response = await http.get(Constants.API_GET_INFORMATION);

    if(response.statusCode == 200){
      print("respuesta:" + response.body);
      String recievedJson = response.body;
      List<dynamic> listJson = json.decode(recievedJson);
      return InformationData.fromJson(listJson[0]);
    } else {
      throw Exception('No pudieron cargarse los datos:' + response.body);
    }
  }
}

  class InformationData{
    int valor;
    String texto;

    InformationData({this.valor, this.texto});

      factory InformationData.fromJson(Map<String, dynamic> json){
        return InformationData(
          valor: json['id'],
          texto: json['name'],
        );
     }
  }





