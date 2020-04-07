import 'package:flutter/material.dart';
import '../util.dart';

class MenuItem extends StatelessWidget {
  Widget page;
  IconData icon;
  String text;
  double width;

  MenuItem({
    Key key,
    this.page,
    this.icon,
    this.text,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => pushPage(context, page),
    child: Tooltip(
    message: text,
      child: Card(
        elevation: 57,
        child: Column(
          children: <Widget>[
            Icon(icon, size: 45.0,),
            Container(
              width: width,
              padding: const EdgeInsets.only(top: 10.0),
//                      splashColor: Colors.blue.withAlpha(30),

              child: Text(text,
                style: TextStyle(fontSize: 18.0,
                    color: Colors.black ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}