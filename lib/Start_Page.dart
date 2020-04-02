
import 'package:Balewaterproject/HomePage.dart';

import 'package:flutter/material.dart';

import 'util.dart';

class StartPage extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("image/banner.png"),

          RaisedButton(
            onPressed: () {
              pushPage(context, HomePage());
            },
            child: Text("Access Staff"),
          ),
        ],
      ),
    );
  }
}