import 'package:flutter/material.dart';

import 'package:flutter_application_notas_remoto/clases/notasestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';

import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class pagBoletaCA extends StatefulWidget {
  final String password;

  const pagBoletaCA.PagBoletaCA({Key? key, required this.password})
      : super(key: key);

  @override
  _pagBoletaCAState createState() => _pagBoletaCAState();
}

class _pagBoletaCAState extends State<pagBoletaCA> {
  List<PlanEstudios> _notas = [];
  bool _isLoading = false;

  Future<void> _fetchNotas(String password) async {
    setState(() {
      _isLoading = true;
      _notas = []; // Limpiar resultados anteriores
    });

    try {
      final response = await http.get(Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/controla1.php?tag=consulta10&codEstudiante=$password",
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['dato'] != null && (data['dato'] as List).isNotEmpty) {
          final List<PlanEstudios> fetchedPagos = (data['dato'] as List)
              .map((pago) => PlanEstudios.fromJson(pago))
              .toList();

          setState(() {
            _notas = fetchedPagos;
          });
        } else {
          _showDialog('no hay pagos registrados o pendientes');
        }
      } else {
        print('Error en la carga de datos');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
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
        centerTitle: true,
        foregroundColor: Color.fromARGB(255, 228, 228, 235),
        backgroundColor: Color.fromARGB(255, 131, 12, 47),
        title: Text('BOLETA NOTAS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 21, 32, 129),
                  backgroundColor: Color.fromARGB(255, 61, 168, 187),
                  padding: EdgeInsets.all(10),
                ),
                onPressed: () {
                  _fetchNotas(widget.password);
                },
                child: Text(' VER BOLETA NOTAS'),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _notas.isEmpty
                    ? Text('presione "VER BOLETA DE NOTAS" para vizulaizar')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _notas.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 51, 3, 224),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'Curso: ${_notas[index].nomc} COD: ${_notas[index].codc}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(height: 16),
                                      Text(
                                        'Prof: ${_notas[index].nomp}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Divider(),
                                      Row(
                                        children: [
                                          _buildNoteItem(
                                              'EC[20%]',
                                              _notas[index]
                                                  .promediocontinuas()
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'P1[10%]',
                                              _notas[index]
                                                  .p1
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'P2[20%]',
                                              _notas[index]
                                                  .p2
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'P3[20%]',
                                              _notas[index]
                                                  .p3
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'Ef[30%]',
                                              _notas[index]
                                                  .ef
                                                  .toStringAsFixed(2)),
                                        ],
                                      ),
                                      Divider(),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          _buildNoteItem(
                                              'C1',
                                              _notas[index]
                                                  .c1
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'C2',
                                              _notas[index]
                                                  .c2
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'C3',
                                              _notas[index]
                                                  .c3
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'C4',
                                              _notas[index]
                                                  .c4
                                                  .toStringAsFixed(2)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _buildNoteItem(
                                              'C5',
                                              _notas[index]
                                                  .c5
                                                  .toStringAsFixed(2)),
                                          _buildNoteItem(
                                              'C6',
                                              _notas[index]
                                                  .c6
                                                  .toStringAsFixed(2)),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Divider(),
                                      SizedBox(height: 8),
                                      Text(
                                        'Promedio: ${_notas[index].promedioCurso().toStringAsFixed(2)}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}
