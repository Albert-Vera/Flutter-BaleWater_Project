
import 'package:Balewaterproject/CRM/Compras/Vacia.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
import '../../Datos_Firebase.dart';

class GestionarComanda extends StatefulWidget {
  String title, preu;

  GestionarComanda( {Key key,  this.title, this.preu}): super(key: key);

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
              _ferComanda(context, widget.title, myController, widget.preu)
              ),
            ],
          )
      ),
    );
  }
}
Widget _ferComanda(BuildContext context, String title, TextEditingController myController, String preu){
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
                      child: TextFormField(
                        controller: myController, // per obtenir valor del texfield i despres pasarlo a Int
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'unitats...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Si us plau inserta una quantitat ';
                          }
                          return null;
                        },
                      ),
                    ),
                    //TODO métode preu arreglar-lo
                    //_calcularPreu(title),
                    Container(
                        margin: EdgeInsets.only(top: 35.0),
                        child: Text("Preu unitat: " + preu)),


                    Container(
                      margin: EdgeInsets.only(
                          top: 60.0,
                          left: 60.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              pushPage(context, Vacia(nomProducte: title, unitatTextField: int.parse(myController.text)));
                            }
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


