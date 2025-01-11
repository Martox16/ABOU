import 'package:flutter/material.dart';
import 'dart:async'; // Importa dart:async para usar Timer
import 'inicio.dart'; // Importa el archivo inicio.dart
import 'MisVehiculos.dart'; // Importa MisVehiculos.dart
import 'package:local_auth/local_auth.dart'; // Importa local_auth para la autenticación biométrica

void main() {
  runApp(MyAppMain());
}

class MyAppMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'miArgentina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => BiometricAuth(), // Cambiar para que la primera pantalla sea la de autenticación biométrica
        '/inicio': (context) => HomePage(), // Ruta a HomePage
        '/misVehiculos': (context) => MisVehiculos(), // Ruta a MisVehiculos
        // Agrega otras rutas según sea necesario
      },
    );
  }
}

class BiometricAuth extends StatefulWidget {
  @override
  _BiometricAuthState createState() => _BiometricAuthState();
}

class _BiometricAuthState extends State<BiometricAuth> {
  final LocalAuthentication _localAuth = LocalAuthentication(); // Inicializa la clase de autenticación
  bool _isAuthenticated = false; // Para saber si la autenticación fue exitosa

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  // Método para intentar la autenticación biométrica
  Future<void> _authenticate() async {
    try {
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Por favor, autentíquese con su huella digital',
        options: AuthenticationOptions(stickyAuth: true),
      );
      setState(() {
        _isAuthenticated = isAuthenticated;
      });

      if (_isAuthenticated) {
        // Si la autenticación es exitosa, navega a la siguiente página
        Navigator.pushReplacementNamed(context, '/inicio');
      } else {
        // Si la autenticación falla, muestra un mensaje o realiza alguna acción
        // Aquí podrías agregar un mensaje de error o volver a intentar
      }
    } catch (e) {
      print("Error al autenticar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isAuthenticated
            ? CircularProgressIndicator() // Muestra un indicador de carga mientras autentica
            : Text('Autenticación en proceso...'), // Mensaje mientras espera
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Crea un temporizador para navegar automáticamente después de 4 segundos
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/inicio'); // Usa la ruta nombrada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/img/PantallaCarga.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // Puedes agregar un indicador de carga aquí si lo necesitas
          // o simplemente dejar la imagen
        ),
      ),
    );
  }
}
