import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/curso.dart';
import 'package:flutter_application_notas_remoto/clases/notasestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PagCursosxAlu extends StatefulWidget {
  final String password;

  const PagCursosxAlu({Key? key, required this.password}) : super(key: key);

  @override
  State<PagCursosxAlu> createState() => _PagCursosxAluState();
}

class _PagCursosxAluState extends State<PagCursosxAlu> {
  List<Curso> doclis = [];
  List<PlanEstudios> lisnota = [];
  String? _selectedCurso;

  @override
  void initState() {
    super.initState();
    getCurso(widget.password); // Cargar lista de cursos al iniciar la página
  }

  // Obtener lista de cursos para el estudiante
  Future<void> getCurso(String password) async {
    final response = await http.get(
      Uri.parse(
          "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta6&codEstudiante=$password"),
    );

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        List<dynamic> liscurso = resp["dato"];
        doclis = liscurso
            .map((item) => Curso(codc: item['codc'], nomc: item['nomc']))
            .toList();
        // Actualizar notas al seleccionar el primer curso automáticamente
        if (doclis.isNotEmpty) {
          _selectedCurso = doclis[0].codc;
          // Llamar a getNotas aquí para mostrar las notas del primer curso automáticamente
          getNotas(widget.password, _selectedCurso!);
        }
      });
    } else {
      print('Error en la carga de cursos: ${response.statusCode}');
    }
  }

  // Obtener notas del estudiante para el curso seleccionado
  Future<void> getNotas(String codEstudiante, String codCurso) async {
    final response = await http.get(
      Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta9&codEstudiante=$codEstudiante&codCurso=$codCurso",
      ),
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['dato'] != null && jsonResponse['dato'].length > 0) {
          List<dynamic> resp = jsonResponse['dato'];
          List<PlanEstudios> notasFiltradas =
              resp.map((json) => PlanEstudios.fromJson(json)).toList();

          setState(() {
            lisnota = notasFiltradas;
          });
        } else {
          print('La respuesta no contiene datos válidos de notas');
        }
      } catch (e) {
        print('Error al decodificar JSON: $e');
      }
    } else {
      print('Error en la carga de notas: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 187, 219, 165),
        foregroundColor: Color.fromARGB(255, 61, 12, 209),
        centerTitle: true,
        title: Text('Cursos Estudiante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedCurso,
              hint: Text(
                'Seleccione curso',
                style: TextStyle(color: Colors.black),
              ),
              onChanged: (newValue) {
                setState(() {
                  _selectedCurso = newValue!;
                  getNotas(widget.password, _selectedCurso!);
                });
              },
              items: doclis.map((Curso curso) {
                return DropdownMenuItem<String>(
                  value: curso.codc,
                  child: Text(
                    '${curso.codc} - ${curso.nomc}',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: lisnota.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 51, 3, 224), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text('user'),
                              leading: ClipOval(
                                child: Image.network(
                                  "http://${Ruta.ip}/ServidorNotas/fotos1/${widget.password}.jpg",
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset('assets/sin_foto.jpg');
                                  },
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 8),
                            Text(
                              'Curso:${doclis[index].nomc} - ${doclis[index].codc}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                            SizedBox(height: 16),
                            Text(
                              'Prof: ${lisnota[index].nomp}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Divider(),
                            Row(
                              children: [
                                _buildNoteItem(
                                    'EC[20%]',
                                    lisnota[index]
                                        .promediocontinuas()
                                        .toStringAsFixed(2)),
                                _buildNoteItem('P1[10%]',
                                    lisnota[index].p1.toStringAsFixed(2)),
                                _buildNoteItem('P2[20%]',
                                    lisnota[index].p2.toStringAsFixed(2)),
                                _buildNoteItem('P3[20%]',
                                    lisnota[index].p3.toStringAsFixed(2)),
                                _buildNoteItem('Ef[30%]',
                                    lisnota[index].p3.toStringAsFixed(2)),
                              ],
                            ),
                            Divider(),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                _buildNoteItem(
                                    'C1', lisnota[index].c1.toStringAsFixed(2)),
                                _buildNoteItem(
                                    'C2', lisnota[index].c2.toStringAsFixed(2)),
                                _buildNoteItem(
                                    'C3', lisnota[index].c3.toStringAsFixed(2)),
                                _buildNoteItem(
                                    'C4', lisnota[index].c4.toStringAsFixed(2)),
                              ],
                            ),
                            Row(
                              children: [
                                _buildNoteItem(
                                    'C5', lisnota[index].c5.toStringAsFixed(2)),
                                _buildNoteItem(
                                    'C6', lisnota[index].c6.toStringAsFixed(2)),
                              ],
                            ),
                            SizedBox(height: 16),
                            Divider(),
                            SizedBox(height: 8),
                            Text(
                                'Promedio: ${lisnota[index].promedioCurso().toStringAsFixed(2)}'),
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
