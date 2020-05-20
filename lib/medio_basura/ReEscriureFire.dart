import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ReEscriureFire{

      void escriure() {
        var nombre = [ "", "Ana", "Maria", "Carme", "Silvie", "Jordi", "Javier", "Albert", "Señor", "Pere", "Tomás", "Señor", "Enric", "Andreu", "Alba", "Asunción" ];
        var apellido = ["", "Manzana", "Pera" ,"Filemon", "Mortadelo","Naranjo","Martin", "Betancurt", "Garcia", "Bonaparte", "Sin Miedo", "Mandarina", "Platano", "Chirimoya","Aguacate", "Guayaba"];
        for (int x= 1; x<16; x++) {
          Firestore.instance.collection("comanda").document(x.toString())
              .setData(
              {
                      'id': x,
                      'idClient': 0,
                      'nom': nombre[x],
                      'cognoms': apellido[x],
                  'email': "señora@gmail.com",
                'telef': "666 666 666",
                      'data_servei': "26/04/2020",
                      'data_comanda': "01/04/2020",
                      'horas': 4,
                      'product_id': "FB-055",
                      'recollida': false,
                      'servida': false,
                      'importComanda': 450,
                      'productNom': "Tobogán",
                      'adreca': "vista al mar, 13",
                      'localitat': "Barcelona",
                      'provincia': "Barcelona",
                      'cp': 08080,
                      'mes' : 4,
                      'dia' : 26
              });
        }

      }
}

/////   COMANDA
//Firestore.instance.collection("comanda").document("07")
//.setData(
//{
//'id': 1,
//'nom': "Mendoza",
//'cognoms': "Javier",
//'data_servei': "10/02/2020",
//'data_comanda': "02/02/200",
//'horas': 4,
//'product_id': "FB-001",
//'recollida': false,
//'servida': false,
//'importComanda': 450,
//'productNom': "Fútbol burbuja",
//'mes' : 2,
//'dia' : 10});


/////  PRODUCTES
//Firestore.instance.collection("productes").document("FB-055")
//.setData(
//{
//'averiados': 0,
//'enAlmacen': 5,
//'id': "FB-055",
//'imageCastle': "https://firebasestorage.googleapis.com/v0/b/balewaterproject-580af.appspot.com/o/happyCastle.jpeg?alt=media&token=0b006b62-2966-4464-8d73-8d23fc2d0240",
//'nomCastle': "Tobogán",
//'precioCoste': 3500,
//'precioAlquiler': 350,
//'proveedor': "JB-Hinchables",
//'servidas': 0,
//'stock': 5
//
//}
//
//);