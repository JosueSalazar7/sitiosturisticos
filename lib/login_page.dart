import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tourist_sites_page.dart'; // Importa la página de TouristSitesPage

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // Método para navegar a la página de TouristSitesPage
    void navigateToTouristSitesPage() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TouristSitesPage(user: FirebaseAuth.instance.currentUser!),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campos de entrada para el correo electrónico y la contraseña
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Iniciar sesión exitosa, navegar a la página de sitios turísticos
                  navigateToTouristSitesPage();
                } catch (e) {
                  // Maneja errores de inicio de sesión aquí
                  print('Error al iniciar sesión: $e');
                }
              },
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Navegar a la página de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campos de entrada para el registro
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Número de celular'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Registro de usuario
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Registro exitoso
                  _showRegistrationSuccessDialog(context);
                } catch (e) {
                  // Manejo de errores durante el registro
                  print('Error al registrar: $e');
                }
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar el cuadro de diálogo de registro exitoso
  void _showRegistrationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Exitoso'),
          content: const Text('¡Tu registro ha sido exitoso!'),
          actions: [
            TextButton(
              onPressed: () {
                // Navegar a la página de inicio de sesión
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        );
      },
    );
  }
}
