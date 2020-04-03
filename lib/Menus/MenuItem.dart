import 'package:flutter/material.dart';
import '../util.dart';

class MenuItem extends StatelessWidget {
  Widget page;
  IconData icon;
  String text;

  MenuItem({
    Key key,
    this.page,
    this.icon,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => pushPage(context, page),

      child: Card(
        elevation: 57,
        child: Column(
          children: <Widget>[
            Icon(icon, size: 45.0,),
            Container(
              width: 100.0,
              padding: const EdgeInsets.only(top: 10.0),
//                      splashColor: Colors.blue.withAlpha(30),
//                      onTap: () {
//                        print('Card tapped.');
//                      },
              child: Text(text,
                style: TextStyle(fontSize: 18.0,
                    color: Colors.black ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}