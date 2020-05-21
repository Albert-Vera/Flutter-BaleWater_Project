import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Home.dart';

final mycontrolador = TextEditingController();
//final BuildContext contexto = BuildContext();
//BuildContext  contexto;


class  LoginMasBonito extends StatefulWidget {
  @override
  _LoginMasBonitoState createState() => _LoginMasBonitoState();
}

class _LoginMasBonitoState extends State<LoginMasBonito> {




  @override
  void dispose() {
    mycontrolador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
      ..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: 25.0,
              bottom: 10.0,
              left: 15.0,
              right: 15.0
          ),
//          padding: EdgeInsets.only(
//            top: 10.0,
//            bottom: 50.0,
//            left: 15.0,
//            right: 15.0
//          ),
          height: 600.0,
          width: 330,
          decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFc5cdd9),
                    offset: Offset(10.0, 10.0),
                    blurRadius: 10.0
                )
              ],
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFbdae84),
                    Color(0xFF281236)
                  ],
                  begin: const FractionalOffset(1.0, 0.1),
                  end: const FractionalOffset(1.0, 0.9)
              )
          ),
          child: Column(
              children: <Widget>[
                bannerLogin(),
                loginText(),
              ]
          ),
        ),
      ),
    );
  }
}





Container bannerLogin() {
  return Container(
    margin: EdgeInsets.only(
        top: 95.0,
        left: 40.0,
        right: 40.0
    ),
    child:  Image.asset("image/banner_1.png"),
  );
}

Container loginText() {
  return Container(
    margin: EdgeInsets.only(
        top: 50.0,
        left: 15.0,
        right: 15.0
    ),
    height: ScreenUtil.getInstance().setHeight(750), // Se adapta a todas las pantallas
    width: ScreenUtil.getInstance().setWidth(680),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(30.0),
    ),


    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Text("Username",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        TextField(
          controller: mycontrolador,
          decoration: InputDecoration(
              hintText: "username",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 12.0)),
        ),
        SizedBox(
          height: 30,
        ),
        Text("PassWord",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 12.0)),
        ),
        SizedBox(
          height: 35,
        ),
        Container( // Boton Access Staff
          margin: EdgeInsets.only(
              left: 50.0,
              right: 30.0
          ),
          height: 90.0,
          width: 180.0,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30),
                RaisedButton(
                    onPressed: () {

                     Home();
                    },
                    textColor: Colors.white,

                    padding: const EdgeInsets.all(0.0),
                    child: Container(

                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            //  Color(0xFF0D47A1),
                            Color(0xFFbdae84),
                            Color(0xFF281236),
                          ],
                        ),
                      ),

                      padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 30.0,
                          right: 30.0,
                          bottom: 10
                      ),
                      child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black)
                      ),
                    )
                )
              ]
          ),
        )
      ],
    ),
  );
}