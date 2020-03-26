

import 'package:Balewaterproject/medio_basura/Home.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'MenuCompras.dart';
import 'MenuVendes.dart';

class MenuPrincipal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin:EdgeInsets.only(
                top: 30.0,
                right: 15.0,
                left: 15.0
            ),
            height: 600.0,
            width: 370.0,
            decoration: new BoxDecoration(
                border: Border.all(),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      color: Color(0xFFc5cdd9),

                      offset: new Offset(10.0, 10.0),
                      blurRadius: 10.0
                  )
                ],
                borderRadius: new BorderRadius.circular(30.0),

//                gradient: new LinearGradient(
//                    colors: [
//                      Color(0xFFbdae84),
//                      Color(0xFF281236)
//                    ],
//                    begin: const FractionalOffset(1.0,0.1 ),
//                    end: const FractionalOffset(1.0, 0.9)
//                )
            ),
            child: Column(
              children: <Widget>[
                bannerLogin(),
                btnCompras(context),
                btnVentas(context),
                btnFacturas(context),
                btnInventario(context)
              ],
            ),
          )

        ],
      ),
    );
  }

  Container bannerLogin() {
    return Container(
      margin: EdgeInsets.only(
          top: 35.0,
          left: 40.0,
          right: 40.0
      ),
      child:  Image.asset("image/banner_1.png"),
    );
  }

  Container btnCompras(BuildContext context){
    return  Container( // Boton Access Staff
      margin:  EdgeInsets.only(
          top: 55.0,
      ),
      height: 40,
      width: 150,

      //color: Colors.black26,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuCompras(),
              ));
        },
        // The custom button
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8.0),

          ),
          child: Text('Compres',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,),
          ),
        ),


      ),

    );
  }
  Container btnVentas(BuildContext context){
    return  Container( // Boton Access Staff
      margin:  EdgeInsets.only(
        top: 35.0,
      ),
      height: 40,
      width: 150,

      //color: Colors.black26,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuVendes(),
              ));
        },
        // The custom button
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8.0),

          ),
          child: Text('Vendes',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,),
          ),
        ),


      ),

    );
  }
  Container btnFacturas(BuildContext context){
    return Container(
      margin: EdgeInsets.only(
          top: 35.0,
          left: 40.0,
          right: 40.0
      ),
      width: 150.0,

      child:  RaisedButton(
        onPressed: () {
          pushPage(context, Home());
        },
        child: Text("Facturación"),
      ),
    );
  }
  Container btnInventario(BuildContext context){
    return Container(
      margin: EdgeInsets.only(
          top: 35.0,
          left: 40.0,
          right: 40.0
      ),
      width: 150.0,

      child:  RaisedButton(
        onPressed: () {
          pushPage(context, Home());
        },
        child: Text("Inventario"),
      ),
    );
  }
}