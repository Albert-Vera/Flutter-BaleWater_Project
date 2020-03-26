
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'util.dart';




class StartPage extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("image/banner_1.png"),

          RaisedButton(
            onPressed: () {
              pushPage(context, LoginPage());
            },
            child: Text("Access Staff"),
          ),
        ],
      ),
    );
  }
}