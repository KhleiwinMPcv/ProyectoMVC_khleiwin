import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/pagprofxadministrador.dart';

class AdministradorHomePage extends StatelessWidget {
  final String nombreUsuario;

  AdministradorHomePage({required this.nombreUsuario});

  Future<void> confirmarCerrar(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Cerrar sesión?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Está seguro de que desea cerrar la sesión?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cerrar sesión'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 21, 32, 129),
        backgroundColor: Color.fromARGB(255, 61, 168, 187),
        title: Text('PANEL ADMINISTRADOR'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              confirmarCerrar(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "http://${Ruta.ip}/ServidorNotas/fotos/$nombreUsuario.jpg",
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('assets/sin_foto.jpg');
              },
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              'BIENVENIDO ADMINISTRADOR, $nombreUsuario',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 229, 229, 235),
                backgroundColor: Color.fromARGB(255, 9, 11, 156),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyAppPxadm(password: nombreUsuario)),
                );
              },
              child: const Text('ADMINISTRAR PROF & ALU'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppPxadm extends StatelessWidget {
  final String password;

  const MyAppPxadm({Key? key, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 118, 119, 197),
        title: Text('INFORMACION DE PROFESORES'),
      ),
      body: Pxadministrador(password: password),
    );
  }
}
