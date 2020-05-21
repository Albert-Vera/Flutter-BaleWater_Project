import 'package:Balewaterproject/CRM/Compras/ComandesProveidor.dart';
import 'package:Balewaterproject/Menus/HomePage.dart';
import 'package:Balewaterproject/medio_basura/LoginDiferente.dart';
import 'package:Balewaterproject/medio_basura/LoginMasBonito.dart';
import 'package:Balewaterproject/util.dart';
import 'package:flutter/material.dart';


class LlistarProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new StuffInTiles(listOfTiles[index], context, listOfsubTitles[index]);
        },
        itemCount: listOfTiles.length,
      ),
    );

  }
}

class StuffInTiles extends StatelessWidget {
  final MyTile myTile;
  final Subtitle listSubtitle;
  final BuildContext context;
  StuffInTiles(this.myTile, this.context, this.listSubtitle);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(myTile, listSubtitle );
  }

  Widget _buildTiles(MyTile t, Subtitle s) {
    if (t.children.isEmpty)
      return new ListTile(
          dense: true,
          enabled: true,
          isThreeLine: false,
          onLongPress: () => print("long press"),
          onTap: () => pushPage(context, ferComanda(t.title, s.subtitle)),
          subtitle: new Text(s.subtitle),
          leading: new Text("Leading"),
          selected: true,
          trailing: new Text("trailing"),
          title: new Text(t.title));

    return new ExpansionTile(
      key: new PageStorageKey<int>(3),
      title: new Text(t.title),
      children: t.children.map(_buildTiles).toList(),
    );
  }
}

class MyTile {
  String title;
  List<MyTile> children;
  MyTile(this.title, [this.children = const <MyTile>[]]);
}
class Subtitle{
  String subtitle;
  List<Subtitle> hijos;
  Subtitle(String children,  [this.hijos = const <Subtitle>[]]);
}

List<MyTile> listOfTiles = <MyTile>[
  new MyTile(
    'Triar un Producte per fer la comanda',
    <MyTile>[
      new MyTile('Salta Bolas'),
      new MyTile('Rocódromo'),
      new MyTile('Hinchables España.S.L.'),
      new MyTile('Tobogán del espacio'),
      new MyTile('Fútbol burbuja'),
      new MyTile('Turbina inflador'),
    ],


  ),

];
List<Subtitle> listOfsubTitles = <Subtitle>[
  new Subtitle(
    'Triar un Producte per fer la comanda'


  ),

];

//new MyTile(
//'Proveidors',
//<MyTile>[
//new MyTile('EuroHinchable.S.L.',
//<MyTile>[
//new MyTile('Salta Bolas'),
//new MyTile('Rocódromo'),
//]
//),
//
//new MyTile('Hinchables España.S.L.',
//<MyTile>[
//new MyTile('Tobogán del espacio'),
//]
//),
//new MyTile('JB-Inflatable, B.V.',
//<MyTile>[
//new MyTile('Fútbol burbuja'),
//]
//),
//new MyTile('Amazon'),
//],
//),