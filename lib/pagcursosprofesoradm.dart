import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/curso.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/pagadministrarnotasE1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PagCursosProfesorAdm extends StatefulWidget {
  final String codp;
  final String adminPassword;

  const PagCursosProfesorAdm(
      {Key? key, required this.codp, required this.adminPassword})
      : super(key: key);

  @override
  State<PagCursosProfesorAdm> createState() => _PagCursosProfesorAdmState();
}

class _PagCursosProfesorAdmState extends State<PagCursosProfesorAdm> {
  List<Curso> doclis = [];
  List<dynamic> lisnota = [];
  String? _selectedvalue;
  String? _selectedCodE;

  // Método para obtener la lista de cursos
  Future<void> getCurso(String codp) async {
    final url = Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta7&codProfesor=$codp");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        List<dynamic> liscurso = resp["dato"];
        doclis = liscurso
            .map((item) => Curso(codc: item['codc'], nomc: item['nomc']))
            .toList();
      });
    } else {
      print('Error en la carga de datos');
    }
  }

  // Método para obtener la lista de notas
  Future<void> getNotas(String? id) async {
    if (id == null) {
      return;
    }

    final url = Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta12&codCurso=$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        lisnota = resp["dato"];
      });
    } else {
      print('Error en la carga de datos');
    }
  }

  @override
  void initState() {
    super.initState();
    getCurso(
        widget.codp); // Llama a getCurso con el código del profesor recibido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 37, 206),
        foregroundColor: Color.fromARGB(255, 235, 234, 238),
        centerTitle: true,
        title: Text('ALUMNOS POR CURSO'),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedvalue,
              hint: Text('Seleccione curso'),
              onChanged: (valor) {
                setState(() {
                  _selectedvalue = valor!;
                  getNotas(_selectedvalue);
                });
              },
              items: doclis.map((item) {
                return DropdownMenuItem<String>(
                  value: item.codc,
                  child: Text(item.nomc),
                );
              }).toList(),
            ),
            if (_selectedvalue != null && _selectedvalue!.isNotEmpty)
              DropdownButton<String>(
                value: _selectedCodE,
                hint: Text('Seleccione COD estudiante'),
                onChanged: (valor) {
                  setState(() {
                    _selectedCodE = valor!;
                  });
                },
                items: lisnota.map((item) {
                  return DropdownMenuItem<String>(
                    value: item['codE'],
                    child: Text(item['codE']),
                  );
                }).toList(),
              ),
            SizedBox(height: 16.0),
            if (_selectedCodE != null && _selectedCodE!.isNotEmpty)
              ElevatedButton.icon(
                icon: Icon(Icons.notes),
                label: Text('Gestionar notas'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PagAdministrarNotasE(
                        codE: _selectedCodE!,
                        codc: _selectedvalue!,
                        nombreUsuario: widget.adminPassword,
                        prof: widget.codp,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Color.fromARGB(255, 25, 37, 206),
      ),
    );
  }
}
