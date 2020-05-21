import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/CRM/Compras/LlistarProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';

class ComandesProveidor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

               // TODO aqui escollir proveidot i fer-li una comanda

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Realitzar una comanda"),
            Expanded(child: LlistarProduct())
          ],
        ),
      ),
    );
  }

}
Widget ferComanda(String title, String subtitle){
  final _formKey = GlobalKey<FormState>();
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        helperText: "Producte",
                      labelText: subtitle,

                    ),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: '',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // Process data.
                        }
                      },
                      child: Text(''),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        " ?",
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Poppins-Medium",
                            fontSize: 18),
                      )
                    ],
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
