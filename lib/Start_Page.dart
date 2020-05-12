
import 'package:Balewaterproject/Menus/HomePage.dart';
import 'package:Balewaterproject/main.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'Menus/HomeCopia.dart';
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
              pushPage(context, HomeCopia());
            },
            child: Text("Access Staff"),
          ),
        ],
      ),
    );
  }
}