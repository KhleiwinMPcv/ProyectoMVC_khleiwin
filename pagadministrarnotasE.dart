import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/notasestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/pagcursosxprof.dart';
import 'package:flutter_application_notas_remoto/pagmodificarnotas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyNota extends StatefulWidget {
  final String codE;
  final String codc;
  final String nombreUsuario;

  const MyNota(
      {required this.codE,
      required this.codc,
      required this.nombreUsuario,
      Key? key})
      : super(key: key);

  @override
  _MyNotaState createState() => _MyNotaState();
}

class _MyNotaState extends State<MyNota> {
  List<PlanEstudios> notas = [];

  @override
  void initState() {
    super.initState();
    obtenerNotas();
  }

  Future<void> obtenerNotas() async {
    final url = Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta9&codEstudiante=${widget.codE}&codCurso=${widget.codc}");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        var resp = jsonDecode(response.body);
        List<dynamic> lista = resp["dato"];
        notas = lista.map((item) => PlanEstudios.fromJson(item)).toList();
      });
    } else {
      print('Error en la carga de notas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 37, 206),
        foregroundColor: Color.fromARGB(255, 235, 234, 238),
        title: Text('Notas del Estudiante'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Código del Estudiante: ${widget.codE}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Código del curso: ${widget.codc}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Curso: ${notas[index].nomc} (${notas[index].codc})',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('P1: ${notas[index].p1.toStringAsFixed(2)}'),
                          Text('P2: ${notas[index].p2.toStringAsFixed(2)}'),
                          Text('P3: ${notas[index].p3.toStringAsFixed(2)}'),
                          Text('EF: ${notas[index].ef.toStringAsFixed(2)}'),
                          Text('C1: ${notas[index].c1.toStringAsFixed(2)}'),
                          Text('C2: ${notas[index].c2.toStringAsFixed(2)}'),
                          Text('C3: ${notas[index].c3.toStringAsFixed(2)}'),
                          Text('C4: ${notas[index].c4.toStringAsFixed(2)}'),
                          Text('C5: ${notas[index].c5.toStringAsFixed(2)}'),
                          Text('C6: ${notas[index].c6.toStringAsFixed(2)}'),
                          Divider(),
                          Text(
                              'Promedio Continuas: ${notas[index].promediocontinuas().toStringAsFixed(2)}'),
                          Text(
                              'Promedio Curso: ${notas[index].promedioCurso().toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0),
                backgroundColor: Color.fromARGB(255, 187, 179, 61),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PagModificarNotas(
                        codE: widget.codE, codc: widget.codc, notas: notas),
                  ),
                );
                if (result != null && result is List<PlanEstudios>) {
                  setState(() {
                    notas = result;
                  });
                }
              },
              child: Text('MODIFICAR NOTAS'),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0),
                backgroundColor: Color.fromARGB(255, 187, 179, 61),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CnotasP(password: widget.nombreUsuario)),
                );
              },
              icon: Icon(Icons.arrow_back),
              label: Text('RETORNAR'),
            ),
          ],
        ),
      ),
    );
  }
}
