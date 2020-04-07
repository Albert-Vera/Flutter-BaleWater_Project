import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('       Bale Water'),
        ),
        body:
        ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),

          itemCount: data.length,
        ),

      ),
    );
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children:  root.children.map(_buildTiles).toList(),

    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);

  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
  //final RaisedButton<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Compras',
    <Entry>[
      Entry('Comandes'),
      Entry('Proveidors'),
      Entry('Productes'),
      Entry('Productes a rebre'),
      Entry('Factures proveidors'),
    ],
  ),
  Entry(
    'Ventas',
    <Entry>[
      Entry('Clients'),
      Entry('Presupostos'),
      Entry('Comandes'),
      Entry('Comandes servidas')
    ],
  ),
  Entry(
    'Facturación',
    <Entry>[
      Entry('Proveidors',
        <Entry>[
          Entry('factures'),
          Entry('pagaments'),
          Entry('otra opcio'),

        ],
      ),
      Entry(
        'Clients',
        <Entry>[
          Entry('factures'),
          Entry('pagaments'),
          Entry('otra opcio'),

        ],
      ),
    ],
  ),
  Entry(
    'Inventari',
    <Entry>[
      Entry('Productes'),
      Entry('Deixalla')
    ],
  ),

];


