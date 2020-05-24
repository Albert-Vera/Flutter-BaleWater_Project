import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Datos_Firebase.dart';


class Clients extends StatefulWidget{
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  var clients = [];

  @override
  void initState() {
    getClients();
    super.initState();
  }

  getClients() async {
    var comandes = await Firestore.instance.collection("comanda").getDocuments();

    final clients = [];
    final emails = new Set<String>();
    for(DocumentSnapshot comanda in comandes.documents){
      if(!emails.contains(comanda.data["email"])){
        emails.add(comanda.data["email"]);
        clients.add(comanda);
      }
    }

    setState(() {
      this.clients = clients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Llistat de clients",),
              Expanded(child:
              _buildBody("comanda"),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBody(String coleccio) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(coleccio).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(snapshot.data.documents, coleccio );
      },
    );
  }

  Widget _buildList(List<DocumentSnapshot> snapshot, String coleccio) {
    return
      ListView.builder(
        padding: const EdgeInsets.only(top: 30.0),
        itemCount: snapshot.length,
        itemBuilder: (context, index){
          return _buildListItem(snapshot[index], coleccio);
        },
      );
  }

  //Future<DocumentSnapshot> busqueda (Record record) async {
//  List<DocumentSnapshot> documentList = (await Firestore.instance
//      .collection("clients")
//      .where("nom", isEqualTo: record.nom)
//      .where("cognoms", isEqualTo: record.cognoms)
//      .getDocuments())
//      .documents;
//  print("dkalsdkla --------------------------------------------------  " + documentList.length.toString());
//  return  documentList;
//}

  Widget _buildListItem(DocumentSnapshot datos, String coleccio)  {
    final record = Record.fromSnapshot(datos);
    return _mostrarDetall(record);
//  print("dkalsdkla -----------------------111111---------------------------  " + numeroRepetidos.toString());
//      final  <Future> a =  busqueda(record); // si meto ASYNC el metodo no admite async
//
//      if ( numeroRepetidos != null) {
//        if (numeroRepetidos == 0) {
//          _writeFirebase(context, record);
//          return _mostrarDetall(context, record);
//        } else {
//          return Container();
//        }
//      }
    return Container();
  }

  Container _mostrarDetall(Record record) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.2),
          blurRadius: 2.0,
        ),
      ],
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  lineaCard( "Id Client:" , record.idClient.toString()),
                  lineaCard( "Nom :" , record.nom ),
                  lineaCard("Cognoms: " , record.cognoms ),
                  lineaCard( "email:" , record.email),
                  lineaCard( "Tel·lefon:" , record.telef ),
                  lineaCard( "adreça:" , record.adreca ),
                  lineaCard( "localitat:" , record.localitat ),
                  lineaCard( "Provincia:" , record.provincia ),
                  lineaCard( "Data registre:" , record.dat_comanda ),


//                    Row(
//                      children: <Widget>[
//                        _btnRetroceso(context, record ),
//                        if (texte != "") _boton(context, record),
//                      ],
//                    )
                ]
              ),
            ),
          ],
        )
      ),
    );
  }

  void deleteFirebase(Record record, String coleccion) {
    Firestore.instance.collection(coleccion).document(record.id.toString()).delete();
  }

  void _writeFirebase(Record record  ) {
    StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
        .collection('client')
        .where("cognoms", isEqualTo: record.cognoms)
        .where("nom", isEqualTo: record.nom)
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
        if (!data.hasData) {

          Firestore.instance.collection("client").document(record.id.toString())
            .setData({
            'idClient': record.idClient,
            'nom': record.nom,
            'cognoms': record.cognoms,
            'email': record.email,
            'provincia': record.provincia,
            'telf': record.telef,
            'data_comanda': record.dat_comanda,
            'adreca': record.adreca,
            'localitat': record.localitat,
            'cp': record.cp,})
            .then((_) {

          }).catchError((onError) {
            print(onError);
          });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}








