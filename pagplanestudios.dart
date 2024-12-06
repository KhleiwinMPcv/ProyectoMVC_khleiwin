import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/ciclo.dart';
import 'package:flutter_application_notas_remoto/clases/planestudios.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PagPlanEstudios extends StatefulWidget {
  final String password;

  const PagPlanEstudios({Key? key, required this.password}) : super(key: key);

  @override
  State<PagPlanEstudios> createState() => _PagPlanEstudiosState();
}

class _PagPlanEstudiosState extends State<PagPlanEstudios> {
  List<Ciclo> doclis = [];
  List<PlanEstudios> lisnota = [];
  String? _selectedCiclo;

  @override
  void initState() {
    super.initState();
    getCiclo(); // Cargar lista de ciclos al iniciar la página
  }

  // Obtener lista de ciclos
  Future<void> getCiclo() async {
    final response = await http.get(
      Uri.parse("http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta14"),
    );

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        List<dynamic> lisciclo = resp["dato"];
        doclis = lisciclo.map((item) => Ciclo(cic: item['ciclo'])).toList();
        // Actualizar notas al seleccionar el primer ciclo automáticamente
        if (doclis.isNotEmpty) {
          _selectedCiclo = doclis[0].cic;
          getPlan(_selectedCiclo!);
        }
      });
    } else {
      print('Error en la carga de ciclos: ${response.statusCode}');
    }
  }

  // Obtener datos del plan de estudios para el ciclo seleccionado
  Future<void> getPlan(String codCiclo) async {
    final response = await http.get(
      Uri.parse(
          "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta15&codCiclo=$codCiclo"),
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['dato'] != null && jsonResponse['dato'].length > 0) {
          List<dynamic> resp = jsonResponse['dato'];
          List<PlanEstudios> planes =
              resp.map((json) => PlanEstudios.fromJson(json)).toList();

          setState(() {
            lisnota = planes;
          });
        } else {
          print('La respuesta no contiene datos válidos de planes de estudio');
        }
      } catch (e) {
        print('Error al decodificar JSON: $e');
      }
    } else {
      print('Error en la carga de datos: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Color.fromARGB(255, 174, 187, 61),
        title: Text('Plan de Estudios'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: _selectedCiclo,
                hint: Text('Seleccione ciclo'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCiclo = newValue!;
                    getPlan(_selectedCiclo!);
                  });
                },
                items: doclis.map((Ciclo ciclo) {
                  return DropdownMenuItem<String>(
                    value: ciclo.cic,
                    child: Text('${ciclo.cic}'),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              lisnota.isEmpty
                  ? Center(
                      child: Text('Seleccione un ciclo para cargar los cursos'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lisnota.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Código: ${lisnota[index].codc}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Asignatura: ${lisnota[index].nomc}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('Tipo: ${lisnota[index].tp}'),
                                SizedBox(height: 8),
                                Text('HT: ${lisnota[index].ht}'),
                                SizedBox(height: 8),
                                Text('HP: ${lisnota[index].hp}'),
                                SizedBox(height: 8),
                                Text('CRD: ${lisnota[index].cre()}'),
                                SizedBox(height: 8),
                                Text('Prerrequisitos: ${lisnota[index].req}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 16),
              Text(
                'INDICACIONES\n'
                '- TIPO: Asignatura Obligatoria (O) o Electiva (E).\n'
                '- HT: HORAS DE TEORIA requeridas por la asignatura.\n'
                '- HP: HORAS DE PRACTICA requeridas por la asignatura.\n'
                '- CRD: CRÉDITOS correspondientes a la asignatura.',
                style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
