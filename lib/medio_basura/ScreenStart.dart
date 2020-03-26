import 'package:balewater/provisionales/LoginMasBonito.dart';
import 'package:balewater/LoginPage.dart';
import 'package:balewater/provisionales/SigninLogin.dart';
import 'package:flutter/material.dart';

import 'SigninLogin.dart';



class ScreenStart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            fondoPantalla(),
            Container( // Contenido de pantalla Inicio
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      banner(),
                      botonAccess_Staff(context)
                    ],
                  )

                ],
              ),
            ),
          ],
        )
    );

  }

  Container fondoPantalla() {
    return Container(
            margin:EdgeInsets.only(
                top: 30.0,
                bottom: 30.0,
                right: 25.0,
                left: 25.0
            ),
            height: 580.0,
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

                gradient: new LinearGradient(
                    colors: [
                      Color(0xFFbdae84),
                      Color(0xFF281236)
                    ],
                    begin: const FractionalOffset(1.0,0.1 ),
                    end: const FractionalOffset(1.0, 0.9)
                )
            ),
            //child: Image.network('https://firebasestorage.googleapis.com/v0/b/balewaterproject.appspot.com/o/castleImages%2FbouncyCastle.jpeg?alt=media&token=f8df5452-3cdb-42b9-a9e8-80cb8dd317c7'),

          );
  }

  Container banner() {
    return Container( // BANNER
                      margin: EdgeInsets.only(
                        top: 270.0,
                        left: 40.0,
                        right: 40.0
                      ),
                      child:Image.asset("image/banner_1.png"),

                    );
  }

  Container botonAccess_Staff(BuildContext context) {
    return Container( // Boton Access Staff
                      margin:  EdgeInsets.only(
                          top: 500.0,
                          left: 80.0
                      ),
                      height: 50,
                      width: 200,

                      color: Colors.black26,
                      child: GestureDetector(
                          onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                        // The custom button
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(8.0),

                          ),
                          child: Text('Access Staff',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,),
                          ),
                        ),


                      ),

                    );
  }

}

