import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ChurlyPage(),
    );
  }
}

class ChurlyPage extends StatelessWidget {
  const ChurlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de las rutas de las imágenes
    final List<String> imagePaths = [
      'lib/img/iconoCobros.png',
      'lib/img/iconoDocumentos.png',
      'lib/img/iconoHijos.png',
      'lib/img/iconoSalud.png',
      'lib/img/iconoTrabajo.png',
      'lib/img/iconoTramites.png',
      'lib/img/iconoTurnos.png',
      'lib/img/iconoVehiculos.png',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Churly - Imagenes")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Número de imágenes por fila
            crossAxisSpacing: 8.0, // Espacio horizontal entre imágenes
            mainAxisSpacing: 8.0, // Espacio vertical entre imágenes
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return Image.asset(
              imagePaths[index],
              fit: BoxFit.cover, // Asegura que las imágenes se ajusten correctamente
            );
          },
        ),
      ),
    );
  }
}
