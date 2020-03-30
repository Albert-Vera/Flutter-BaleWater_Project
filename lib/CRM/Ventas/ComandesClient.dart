import 'package:flutter/material.dart';

class ComandesClient extends StatelessWidget{
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
            ),
//            child: Column(
//              children: <Widget>[
//                bannerLogin(),
//                btnCompras(context),
//                btnVentas(context),
//                btnFacturas(context),
//                btnInventario(context)
//              ],
//            ),
          )

        ],
      ),
    );
  }

}