import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/pagboletaCA.dart';
import 'package:flutter_application_notas_remoto/pagplanestudios.dart';
import 'package:flutter_application_notas_remoto/pagcursosxalu.dart';
import 'package:flutter_application_notas_remoto/pagpagosporalu.dart';

class EstudianteHomePage extends StatelessWidget {
  final String nombreUsuario;

  EstudianteHomePage({required this.nombreUsuario});

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
        title: Text('Panel estudiante'),
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
              "http://${Ruta.ip}/ServidorNotas/fotos1/$nombreUsuario.jpg",
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('assets/sin_foto.jpg');
              },
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text(
              'Bienvenido estudiante, $nombreUsuario',
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
                          PagCursosxAlu(password: nombreUsuario)),
                );
              },
              child: const Text('BOLETA POR CURSO'),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 228, 228, 235),
                backgroundColor: Color.fromARGB(255, 131, 12, 47),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          pagBoletaCA.PagBoletaCA(password: nombreUsuario)),
                );
              },
              child: const Text('BOLETA NOTAS'),
            ),
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
                          PagPagosPorAlu(password: nombreUsuario)),
                );
              },
              child: const Text('PAGOS'),
            ),
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
                          PagPlanEstudios(password: nombreUsuario)),
                );
              },
              child: const Text('PLAN ACADÉMICO'),
            ),
          ],
        ),
      ),
    );
  }
}
