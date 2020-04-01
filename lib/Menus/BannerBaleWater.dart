import 'package:flutter/material.dart';

class BannerBaleWater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
          top: 35.0,
          left: 40.0,
          right: 40.0
      ),
      child:  Image.asset("image/banner.png"),
    );
  }

}