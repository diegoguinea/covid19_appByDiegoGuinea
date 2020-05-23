import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:covid19_app/home.dart';
import 'package:covid19_app/services/lang.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_app/utils/constants.dart';



class Coment extends StatelessWidget{

  static const String routeName = '/comentario';

  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return new Scaffold(
        appBar: AppBar(
          title: Text("Comentarios"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: comentpage());
  }
}

class comentpage extends StatefulWidget{

  comentpage({Key key}) : super(key : key);
  @override
  comentpageState createState() => comentpageState();
}

class comentpageState extends State<comentpage> {
  Future<InformationData> post;
  Future<String> appVersion;
  final TextEditingController myController = TextEditingController();

  @override
  void initState(){
    super.initState();
    post = fetchInformation();

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
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Enter your coment'
                  ),
                  controller: myController,
                ),
                SizedBox(height: 20,),
                FloatingActionButton.extended(
                  onPressed: () {
                    log("controler:  "+ myController.text);
                    setState(() {
                      post = createpost(myController.text);
                    });
                    showAlertDialog(context);
                  },
                  label: Text('Comentar'),
                  icon: Icon(Icons.comment),
                  backgroundColor: Colors.black,
                ),
              ]
             ),
          ),
        ),
    );
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



Future<InformationData> createpost(String title) async {
  log("titulooo :       " + title);
  final http.Response response = await http.post(
    'https://apifluttercsharp20200521230519.azurewebsites.net/api/Diegoes',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': title,

    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    log("RESPUESTA:  " + response.body);
    return InformationData.fromJson(json.decode(response.body));

  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
showAlertDialog(BuildContext context) {


  Widget okButton = FlatButton(
    child: Text("Cerrar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Subido"),
    content: Text("Comprueba que tu ccomentario se subio a la api"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}





