import 'package:flutter/material.dart';

class SliversBasicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return      CustomScrollView(

      slivers: <Widget>[

//        SliverAppBar(
//          //pinned: true,
//          floating: false,
//          expandedHeight: 120.0,
//          flexibleSpace: FlexibleSpaceBar(
//            title: Text('Basic Slivers'),
//          ),
//        ),
        SliverFixedExtentList(
          itemExtent: 50,
          delegate: SliverChildListDelegate([
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
          ]),
        ),

      ],
    );






  }
}



