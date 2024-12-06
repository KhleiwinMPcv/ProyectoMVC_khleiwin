import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/curso.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';
import 'package:flutter_application_notas_remoto/pagadministrarnotasE.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CnotasP extends StatefulWidget {
  final String password;

  const CnotasP({Key? key, required this.password}) : super(key: key);

  @override
  State<CnotasP> createState() => _CnotasPState();
}

class _CnotasPState extends State<CnotasP> {
  List<Curso> doclis = [];
  List<dynamic> lisnota = [];
  String _selectedvalue = "";
  String _selectedCodE = "";

  // Método para obtener la lista de cursos
  Future<void> getCurso(String password) async {
    final url = Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta7&codProfesor=$password");

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
  Future<void> getNotas(String id) async {
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
    getCurso(widget.password); // Llama a getCurso con el usuario recibido
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
              value: _selectedvalue.isEmpty ? null : _selectedvalue,
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
            Expanded(
              child: ListView.builder(
                itemCount: lisnota.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        "http://${Ruta.ip}/ServidorNotas/fotos1/${lisnota[index]['codE']}.jpg",
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/sin_foto.jpg');
                        },
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                        '${lisnota[index]['codE']}- ${lisnota[index]['nomE']}'),
                    subtitle: Text("Código: ${lisnota[index]['codE']}"),
                    trailing: ElevatedButton.icon(
                      icon: Icon(Icons.note),
                      label: Text('Ver Nota'),
                      onPressed: () {
                        setState(() {
                          _selectedCodE = lisnota[index]['codE'];
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyNota(
                              codc: _selectedvalue,
                              codE: _selectedCodE,
                              nombreUsuario: widget.password,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
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
    );
  }
}
