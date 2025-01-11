import 'package:flutter/material.dart';

class MiPerfil extends StatelessWidget {
  final List<Map<String, String>> emergencyNumbers = [
    {'number': '911', 'description': 'Central de Emergencias Nacional'},
    {'number': '144', 'description': 'Víctimas de violencia'},
    {'number': '107', 'description': 'Emergencias Médicas'},
    {'number': '100', 'description': 'Bomberos'},
    {'number': '102', 'description': 'La línea de los chicos'},
    {'number': '103', 'description': 'Defensa Civil'},
    {'number': '106', 'description': 'Emergencia Náutica'},
    {'number': '134', 'description': 'Denuncia delitos y extorsiones'},
    {'number': '135', 'description': 'Asistencia al Suicida'},
    {'number': '141', 'description': 'Ayuda Sedronar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Teléfonos de Emergencia'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: emergencyNumbers.length,
          itemBuilder: (context, index) {
            final item = emergencyNumbers[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['number']!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          item['description']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
