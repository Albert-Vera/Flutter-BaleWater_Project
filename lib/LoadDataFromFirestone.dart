import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadDataFromFirestore extends StatefulWidget {
  @override
  _LoadDataFromFirestoreState createState() => _LoadDataFromFirestoreState();
}

class _LoadDataFromFirestoreState extends State<LoadDataFromFirestore> {
  @override
  void initState() {
    super.initState();
    getDriversList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showDrivers(),
    );
  }

  //build widget as prefered
  //i'll be using a listview.builder
  Widget _showDrivers() {
    final screenSize = MediaQuery.of(context).size;
    //check if querysnapshot is null
    if (querySnapshot != null) {

      return
      Scaffold(
        body: Container(
          height: screenSize.height,
          width:  screenSize.width,
          child:   ListView.builder(

            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: false,
            itemCount: querySnapshot.documents.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, i) {
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
                              child: Text("id: 023" + "   " , textAlign: TextAlign.justify,),
                            ),
                            Expanded(
                              child: Text("${querySnapshot.documents[i].data['nom']}"+ "   "+"${querySnapshot.documents[i].data['cognoms']}", textAlign: TextAlign.center,),
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
                                child: Text("Data Comanda: " + "${querySnapshot.documents[i].data['dataComanda']}" , textAlign: TextAlign.left,),
                              ),
                              Expanded(
                                child: Text("Data Servei: " + "${querySnapshot.documents[i].data['dataServei']}", textAlign: TextAlign.right,),
                              )
                            ],
                          )
                      ),
//                      Container(
//                        width: screenSize.width,
//                        color: Colors.green,
//                        child:  Text("${querySnapshot.documents[i].data['adreca']}"),
//                      ),
//                      Container(
//                        width: screenSize.width,
//                        color: Colors.yellow,
//                        child: Text("${querySnapshot.documents[i].data['localitat']}"),
//                      ),
//                      Container(
//                        width: screenSize.width,
//                        color: Colors.orange,
//                        child:  Text("${querySnapshot.documents[i].data['provincia']}"),
//                      ),
                    ],
                  ),
                  //scrollDirection: Axis.horizontal,

                ),
              );






//          return Column(
//
//            children: <Widget>[
////load data into widgets
//
//              Text("${querySnapshot.documents[i].data['nom']}"),
//              Text("${querySnapshot.documents[i].data['cognoms']}"),
//              Text("${querySnapshot.documents[i].data['adreca']}"),
//              Text("${querySnapshot.documents[i].data['localitat']}"),
//              Text("${querySnapshot.documents[i].data['provincia']}"),
//              Text("${querySnapshot.documents[i].data['email']}"),
//            ],
//          );
            },
          ),
        ),
      );

    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //get firestore instance
  getDriversList() async {
    return await Firestore.instance.collection('comanda').getDocuments();
  }
}