import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/pago.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PagPagosPorAlu extends StatefulWidget {
  final String password; // Recibe el password

  PagPagosPorAlu({required this.password});

  @override
  _PagPagosPorAluState createState() => _PagPagosPorAluState();
}

class _PagPagosPorAluState extends State<PagPagosPorAlu> {
  List<Pago> _pagos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPagos(widget.password); // Carga los pagos al inicializar
  }

  Future<void> _fetchPagos(String password) async {
    setState(() {
      _isLoading = true;
      _pagos = []; // Limpiar resultados anteriores
    });

    try {
      final response = await http.get(Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta13&codEstudiante=$password",
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['dato'] != null && (data['dato'] as List).isNotEmpty) {
          final List<Pago> fetchedPagos = (data['dato'] as List)
              .map((pago) => Pago.fromJson(pago))
              .toList();

          setState(() {
            _pagos = fetchedPagos;
          });
        } else {
          _showDialog('El alumno no tiene pagos registrados');
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
        title: Text('CONSULTA PAGOS '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _pagos.isEmpty
                    ? Text('El alumno no tiene pagos registrados')
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var pago in _pagos)
                                Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cuota: ${pago.cuota}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                            'Monto: ${pago.monto.toStringAsFixed(2)}'),
                                        SizedBox(height: 8),
                                        Text(
                                            'Descuento considerado: ${pago.des().toStringAsFixed(2)}'),
                                        Text(
                                            'Fecha vencimiento: ${pago.fecha}'),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(height: 8),
                              Text(
                                  'Pago total: ${_pagos.isEmpty ? 0 : _pagos[0].pagoTotal(_pagos).toStringAsFixed(2)}'),
                            ],
                          ),
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
}
