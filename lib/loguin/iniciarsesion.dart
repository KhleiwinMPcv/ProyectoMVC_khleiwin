import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/loguin.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication Example',
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/login': (context) => LoginPage(),
        '/admin_home': (context) => AdministradorHomePage(nombreUsuario: ''),
        '/professor_home': (context) => ProfessorHomePage(nombreUsuario: ''),
        '/estudiante_home': (context) => EstudianteHomePage(nombreUsuario: ''),
      },
    );
  }
}
