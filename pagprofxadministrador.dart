import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/profesor.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';
import 'package:flutter_application_notas_remoto/pagcursosprofesoradm.dart';
import 'package:http/http.dart' as http;

class Pxadministrador extends StatefulWidget {
  final String password;

  const Pxadministrador({Key? key, required this.password}) : super(key: key);

  @override
  State<Pxadministrador> createState() => _PxadministradorState();
}

class _PxadministradorState extends State<Pxadministrador> {
  List<Profesor>? profesores;

  // Obtener datos del profesor
  Future<void> getProfesor(String password) async {
    final response = await http.get(
      Uri.parse(
          "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta8&codAdministrador=$password"),
    );

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        // Verificar si resp es una lista
        if (resp['dato'] is List) {
          profesores = (resp['dato'] as List)
              .map((data) => Profesor.fromJson(data))
              .toList();
        } else {
          // Manejar el caso donde resp no es una lista (esto dependerá de cómo es la respuesta exacta del servidor)
          profesores = [Profesor.fromJson(resp['dato'])];
        }
      });
    } else {
      print('Error en la carga de datos');
    }
  }

  @override
  void initState() {
    super.initState();
    getProfesor(widget
        .password); // Llamar a getProfesor con el código de administrador recibido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 82, 187, 61),
        title: Text('PROFESORES'),
      ),
      body: profesores == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: profesores!.length,
              itemBuilder: (context, index) {
                final profesor = profesores![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "http://${Ruta.ip}/ServidorNotas/fotos/${profesor.codp}.jpg",
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset('assets/sin_foto.jpg');
                            },
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          Text('Código Profesor: ${profesor.codp}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Código Especialidad: ${profesor.code}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Nombre: ${profesor.nomp}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Celular: ${profesor.celular}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Dirección: ${profesor.direccp}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Grado: ${profesor.grado}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Años de contrato: ${profesor.anios}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Especialidad: ${profesor.especialidad()}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          ElevatedButton.icon(
                            icon: Icon(Icons.note),
                            label: Text('Ver cursos'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PagCursosProfesorAdm(
                                    codp: profesor.codp,
                                    adminPassword: widget.password,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: ElevatedButton(
        style: TextButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Color.fromARGB(255, 82, 187, 61),
          padding: EdgeInsets.all(10),
        ),
        onPressed: () {
          // Volver a la pantalla de inicio según el tipo de usuario
          if (widget.password.startsWith('A')) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdministradorHomePage(
                  nombreUsuario: widget.password,
                ),
              ),
            );
          } else if (widget.password.startsWith('P')) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfessorHomePage(
                  nombreUsuario: widget.password,
                ),
              ),
            );
          } else if (widget.password.length == 10) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EstudianteHomePage(
                  nombreUsuario: widget.password,
                ),
              ),
            );
          }
        },
        child: Text('MENÚ PRINCIPAL'),
      ),
    );
  }
}
