import 'package:flutter/material.dart';
import 'dart:async'; // Importa dart:async para usar Timer
import 'inicio.dart'; // Importa el archivo inicio.dart
import 'MisVehiculos.dart'; // Importa MisVehiculos.dart

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
        '/': (context) => SplashPage(), // Ruta a SplashPage
        '/inicio': (context) => HomePage(), // Ruta a HomePage
        '/misVehiculos': (context) => MisVehiculos(), // Ruta a MisVehiculos
        // Agrega otras rutas según sea necesario
      },
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
