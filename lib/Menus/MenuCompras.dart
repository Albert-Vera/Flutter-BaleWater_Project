

import 'package:Balewaterproject/medio_basura/Home.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class MenuCompras extends StatelessWidget{
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
            child: Column(
              children: <Widget>[
                bannerLogin(),
                title(),
                btnComandes(context),
                btnProveidors(context),
                btnProductes(context),
                btnProducteARebre(context),
                btnFacturesProveidors(context)
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
  Container title() {
    return Container(
        margin: EdgeInsets.only(
          left: 150.0,
            right: 1.0
        ),

      width: 80,
      height: 22,
      child:  Image.asset("image/bannerCompres.png"),

    );
  }
  Container btnComandes(BuildContext context){
    return Container(
      margin: EdgeInsets.only(
          top: 65.0,
          left: 40.0,
          right: 40.0
      ),
      width: 150.0,
      child:  RaisedButton(
        onPressed: () {
          pushPage(context, Home());
        },
        child: Text("Comandes"),
      ),
    );
  }
  Container btnProveidors(BuildContext context){
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
        child: Text("Proveidors"),
      ),
    );
  }
  Container btnProductes(BuildContext context){
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
        child: Text("Productes"),
      ),
    );
  }
  Container btnProducteARebre(BuildContext context){
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
        child: Text("Prod. a rebre"),
      ),
    );
  }
  Container btnFacturesProveidors(BuildContext context){
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
        child: Text("Fact. proveidors"),
      ),
    );
  }
}