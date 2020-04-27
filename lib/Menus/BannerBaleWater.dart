import 'package:flutter/material.dart';

class BannerBaleWater extends StatelessWidget {
  String texte;
  BannerBaleWater( {
    Key key,
    this.texte}): super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
          top: 35.0,
          left: 40.0,
          right: 40.0,
          bottom: 30.0
      ),
      child: Column(
        children: <Widget>[
          Image.asset("image/banner.png"),
          Container(
            margin: new EdgeInsets.only(
                top: 20.0,

            ),
            height: 25.0,
            width: 250.0,
//            decoration: new BoxDecoration(
//
//
//              borderRadius: new BorderRadius.circular(5.0),
//              color: Color(0xFFfeb800),
//            ),
            child: new Center(
              child: new Text(
                texte,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
          )

        ],
      )



    );
  }

}