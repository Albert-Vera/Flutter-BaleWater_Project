import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../BackGroundPantalla.dart';

final mycontrolador = TextEditingController();

class ContacteProveidor extends StatefulWidget {
  @override
  _ContacteProveidorState createState() => _ContacteProveidorState();
}

class _ContacteProveidorState extends State<ContacteProveidor> {
  @override
  void dispose() {
    mycontrolador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BackGroundPantalla(
        child:
        Column(
          children: <Widget>[
            BannerBaleWater(texte: "Contacte proveidor"),
            Expanded(child: detallComanda()),
          ],
        ),
        ),

    );
  }
}

Container detallComanda() {
  return Container(
    margin: EdgeInsets.only(
        top: 5.0,
        left: 15.0,
        right: 15.0
    ),
    height: 750, // Se adapta a todas las pantallas
    width: 680,

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(30.0),
    ),


    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Text("Proveidor",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        TextField(
          controller: mycontrolador,
          decoration: InputDecoration(
              hintText: "Proveidor",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 12.0)),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Consulta",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        TextField(
          keyboardType: TextInputType.multiline, //Mostrara teclado con salto linea
//          obscureText: true,
          //maxLines: 3,
          decoration: InputDecoration(
              hintText: "Consulta",
              ),
        ),
//        SizedBox(
//          height: 35,
//        ),
        Container( // Boton Access Staff
          margin: EdgeInsets.only(
              top: 95.0,
              left: 50.0,
              right: 30.0
          ),
          height: 90.0,
          width: 180.0,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30),
                RaisedButton(
                    onPressed: () {

                      //Home();
                    },
                    textColor: Colors.white,

                    padding: const EdgeInsets.all(0.0),
                    child: Container(

                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            //  Color(0xFF0D47A1),
                            Color(0xFFbdae84),
                            Color(0xFF281236),
                          ],
                        ),
                      ),

                      padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 30.0,
                          right: 30.0,
                          bottom: 10
                      ),
                      child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black)
                      ),
                    )
                )
              ]
          ),
        )
      ],
    ),
  );
}