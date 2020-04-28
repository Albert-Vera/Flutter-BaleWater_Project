import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/medio_basura/MostrarComandes1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Productes extends StatefulWidget{
  String coleccion;

  Productes( {
    Key key,
    this.coleccion}): super(key: key);
  @override
  _ProductesState createState() => _ProductesState();
}
class _ProductesState extends State<Productes> {
  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Llistat de productes",),
              Expanded(child:
              _buildBody(context, this.widget.coleccion)
              ),
            ],
          )
      ),
    );
  }

//  @override
//  void initState() {
//    //Experimento();
//  }

  Widget _buildBody(BuildContext context, String coleccio) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("castle").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        // if (snapshot.data.documents.isEmpty)  _comanServidasVacio(context);
        return _buildList(context, snapshot.data.documents, coleccio);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot,
      String coleccio) {
    return
      ListView(
        padding: const EdgeInsets.only(top: 30.0),
        children: snapshot.map((data) =>
            _buildListItem(context, data, coleccio)).toList(),
      );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot datos,
      String coleccio) {
    final record = Record.fromSnapshot(datos);

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("castle").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _actualitzarDades(context, record);
      },
    );
  }

  Widget _actualitzarDades(BuildContext context, Record record) {


    //todo  TORNAR A LLEGIR FIREBASE SERVIDAS Y RESTA SERVIDAS Y SUMA RECOLLIDAS

    return _impresioDades(context, record);

  }

  Widget _impresioDades(BuildContext context, Record record) {
    return Container(
      height: 350.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 200.0),
                    child: Image.network(record.imageCastle,
                        width: 100,
                        height: 100),
                  ),
                  Container(
                    width: 250.0,
                    margin: EdgeInsets.only(
                        top: 80.0,
                        left: 20.0
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.symmetric(
                            horizontal: 10.0)),
                        _lineaCard("id: 0", record.id.toString()),
                        _lineaCard("Nom: " , record.nomCastle),
                        _lineaCard("Proveedor: ", record.proveedor),
                        _lineaCard("Stock: ", record.stock.toString()),
                        _lineaCard("servidas: ", record.servidas.toString()),
                        _lineaCard("En Almacen: ", record.enAlmacen.toString()),
                        _lineaCard("Averiados: ", record.averiados.toString()),
                        _lineaCard("Precio Coste: ", record.precioCoste.toString()),
                        _lineaCard("Precio Alquiler: ", record.precioAlquiler.toString()),
                      ],
                    ),
                  )
                ],
              )
            ]
        ),
      ),
    );
  }
  Widget _lineaCard( String text_1, String text_2){
    // final screenSize = MediaQuery.of(context).size;
    return  Container(
      width: 250.0,
      //color: Colors.tealAccent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(text_1,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18.0)),
          ),
          Expanded(
            child: Text(text_2,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18.0)),
          ),
        ],
      ),
    );
  }
}
class Record {
  final String id, nomCastle,imageCastle, proveedor;
  var stock, enAlmacen, servidas, averiados;
  var precioCoste, precioAlquiler;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['nomCastle'] != null),
        assert(map['imageCastle'] != null),
        assert(map['proveedor'] != null),
        assert(map['stock'] != null),
        assert(map['enAlmacen'] != null),
        assert(map['servidas'] != null),
        assert(map['averiados'] != null),
        assert(map['precioCoste'] != null),
        assert(map['precioAlquiler'] != null),
        id = map['id'],
        nomCastle = map['nomCastle'],
        proveedor = map['proveedor'],
        stock = map['stock'],
        enAlmacen = map['enAlmacen'],
        servidas = map['servidas'],
        averiados = map['averiados'],
        precioCoste = map['precioCoste'],
        precioAlquiler = map['precioAlquiler'],
        imageCastle = map['imageCastle'];


  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$id:$nomCastle>";
}
