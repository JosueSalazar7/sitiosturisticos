import 'package:flutter/material.dart';
import 'dart:async';
import 'login_page.dart'; // Importa tu LoginPage

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen más grande
            Image.asset(
              'assets/logo.jpg', // Reemplaza con la ruta de tu imagen
              width: 150, // Ajusta el ancho según tus necesidades
              height: 150, // Ajusta la altura según tus necesidades
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y los nombres
            // Nombres
            Text(
              'Wilson Guayanay',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Marlon Lalangui',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Josué Salazar',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();

    // Inicia un temporizador para redirigir después de 5 segundos
    Timer(const Duration(seconds: 5), () {
      // Utiliza Navigator.pushReplacementNamed para navegar a la página por nombre
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
