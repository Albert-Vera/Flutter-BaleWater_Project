import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Clients extends StatefulWidget{
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  void initState() {
    super.initState();
    getComandesList().then((results) {
      setState(() { 
        querySnapshot = results;
      });
    });
  }
  //get firestore instance
  getComandesList() async {
    return await Firestore.instance.collection('comanda').getDocuments();
  }

  QuerySnapshot querySnapshot, queryAcomparar;
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    //check if querysnapshot is null
    if (querySnapshot != null) {
      return Scaffold(
        body: BackGroundPantalla(
          child:  Column(
            children: <Widget>[
              BannerBaleWater(),
              writeBBDD_Client(),
              impresiodeDades(screenSize)
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
  Widget writeBBDD_Client() {
    List<String> pajarito = new List(querySnapshot.documents.length  );
 //  DESACTIVADO DE POCO SIRVE
    for (int i=0; i < querySnapshot.documents.length; i++) {
      if ( pajarito[i] == null || !pajarito[i].contains("${querySnapshot.documents[i].data['email]']}")) {
        Firestore.instance.collection("client").document("CL00$i")
            .setData({
          'nom': '${querySnapshot.documents[i].data['nom']}',
          'cognoms': '${querySnapshot.documents[i].data['cognoms']}',
          'email': '${querySnapshot.documents[i].data['email']}'});

        pajarito[i]=("${querySnapshot.documents[i].data['email]']}");
        var ddd = pajarito[i];  // sale valor nulo
        print("tamany de pajarito $pajarito");
      }
    }
//
//
//
//
//    var tamany = querySnapshot.documents.length ;
////  //var cosas = querySnapshot.documents.getRange(0, tamany).
////
//  List<String> emailString =  List();
// // emailString[0] = "0";
//
//  for ( int i = 0; i < tamany; i++){
//    if ( !emailString[i].contains("${querySnapshot.documents[i].data['email]']}")){
//      emailString[i] = "${querySnapshot.documents[i].data['email]']}";
//      print("maravilloso-.........");
//    }
//  }
  }
  Widget impresiodeDades(Size screenSize) {
   // List<String> pajarito = new List(querySnapshot.documents.length  );

    return SingleChildScrollView(
//          height: screenSize.height,
//          width:  screenSize.width,
          child:   ListView.builder(

            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemCount: querySnapshot.documents.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, i) {

             // for (int j = 0; j < querySnapshot.documents.length; j++) {

//                if ( pajarito[i] == null || !pajarito[i].contains("${querySnapshot.documents[i].data['email]']}")){
//
//                  pajarito[i]=("${querySnapshot.documents[i].data['email]']}");
//                  var ddd = pajarito[i];  // sale valor nulo
//                  print("tamany de pajarito $pajarito");
                  return Container(

                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    height: 80.0,
                    // color: Colors.tealAccent,
                    child: Card(
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Container(

                              width: screenSize.width,
                              //color: Colors.tealAccent,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("id: 023" + "   ",
                                      textAlign: TextAlign.justify,),
                                  ),
                                  Expanded(
                                    child: Text("${querySnapshot.documents[i].data['nom']}" + "   " +
                                        "${querySnapshot.documents[i]
                                            .data['cognoms']}",
                                      textAlign: TextAlign.center,),
                                  )
                                ],
                              )


                          ),

                          Container(
                              width: screenSize.width,
                              //  color: Colors.red,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("Data Comanda: " +
                                        "${querySnapshot.documents[i]
                                            .data['dataComanda']}",
                                      textAlign: TextAlign.left,),
                                  ),
                                  Expanded(
                                    child: Text("Data Servei: " +
                                        "${querySnapshot.documents[i]
                                            .data['dataServei']}",
                                      textAlign: TextAlign.right,),
                                  )
                                ],
                              )
                          ),

                        ],
                      ),
                      //scrollDirection: Axis.horizontal,

                    ),
                  );

             //   }else
//              }
//              return Container(
//
//              );

            },
          ),
        );
  }
}