
import 'package:Balewaterproject/CRM/Compras/Vacia.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
import '../../Datos_Firebase.dart';

class GestionarComanda extends StatefulWidget {
  String title;

  GestionarComanda( {Key key,  this.title}): super(key: key);

  @override
  _GestionarComandaState createState() => _GestionarComandaState();
}

class _GestionarComandaState extends State<GestionarComanda> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Detall comanda",),
              Expanded(child:
              _ferComanda(context, widget.title, myController)
              ),
            ],
          )
      ),
    );
  }
}
Widget _ferComanda(BuildContext context, String title, TextEditingController myController){
  final _formKey = GlobalKey<FormState>();
  final _unitats = TextEditingController();
  return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
              right: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                          // helperText: "Producte", hoverColor: Colors.blueAccent,
                          labelText: title,

                        ),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.blueAccent)
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 35.0),
                      child: TextField(
                        controller: myController, // per obtenir valor del texfield i despres pasarlo a Int
//                        controller: _unitats,
                        decoration: const InputDecoration(
                          hintText: 'unitats...',
                        ),

                      ),
                    ),
                    //TODO métode preu arreglar-lo
                    //_calcularPreu(title),
                    Container(
                      margin: EdgeInsets.only(top: 35.0),
                        child: Text("preu: 1.600,00 euros")),


                    Container(
                      margin: EdgeInsets.only(
                          top: 60.0,
                      left: 60.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            pushPage(context, Vacia(nomProducte: title, unitatTextField: int.parse(myController.text)));
                            //}
                          },
                          child: Text('Enviar comanda'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
  );
}
Widget _calcularPreu(String title){

  //TODO falta obtener precio producto

if (title != null) {
  StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('productes')
        .where("nomCastle", isEqualTo: title)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
      if (data.hasData) {
        List<DocumentSnapshot> lista = (data.data.documents.map((doc) => doc['preuAlquiler']));
        return Text("maravillos...  " + lista.contains(title).toString());
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
}
Widget _writeComandaFirebase(BuildContext context ) {
  print("..............................................................................111.a.............  ");
  return StreamBuilder(
    stream: Firestore.instance.collection('comandaProveidor').snapshots(),
    builder:(context, snapshot) {
      if (!snapshot.hasData) {

          print("..............................................................................2222.a.............  " + snapshot.data['idComanda'].toString());
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Disponibles en almacén: " + snapshot.data['idComanda'].toString()),
          );
        Firestore.instance.collection("comandaProveidor").document("09ij0")
            .setData({
          'idComanda':  's',
          'nomProducte': 's',
          'idProducte': 's',
          'nomProveidor':  's',
          'idProveidor':  's',
          'dataComanda':  's',
          'dataEntrega':  's',
          'preuUnitat':  's',
          'preuTotal':  's' })
            .then((_) {

        }).catchError((onError) {
          print(onError);
        });
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );



}

