import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TouristSitesPage extends StatelessWidget {
  final User user;

  TouristSitesPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sitios Turísticos'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Sitios_turisticos')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String nombre = data['Nombre'];
              String descripcion = data['Descripción'];

              // Construye la ruta de la imagen directamente desde el nombre
              String imagePath = 'assets/$nombre.jpg';

              return Card(
                child: Column(
                  children: [
                    Image.asset(
                      imagePath,
                      width: double
                          .infinity, // Ancho de la imagen que ocupa todo el ancho de la tarjeta
                      height: 500, // Altura de la imagen
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                      title: Text(nombre),
                      subtitle: Text(descripcion),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TouristSitesPage(user: FirebaseAuth.instance.currentUser!),
  ));
}
