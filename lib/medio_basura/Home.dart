import 'package:flutter/material.dart';

class Home extends StatelessWidget{
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

            )
    ],
    ),
    );
  }

}