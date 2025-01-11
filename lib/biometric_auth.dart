import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> _authenticate() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        return false; // Si no se pueden usar biométricos
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Por favor, verifica tu identidad',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      return authenticated;
    } catch (e) {
      print('Error al autenticar: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authenticate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return HomePage(); // Si la autenticación es exitosa, navega a HomePage
          } else {
            return Scaffold(
              body: Center(
                child: Text('Autenticación fallida.'),
              ),
            );
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
