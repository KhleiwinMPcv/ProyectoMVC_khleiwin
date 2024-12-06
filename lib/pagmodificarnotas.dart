import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/clases/notasestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:http/http.dart' as http;

class PagModificarNotas extends StatefulWidget {
  final String codE;
  final String codc;
  final List<PlanEstudios> notas;

  const PagModificarNotas({
    required this.codE,
    required this.codc,
    required this.notas,
    Key? key,
  }) : super(key: key);

  @override
  _PagModificarNotasState createState() => _PagModificarNotasState();
}

class _PagModificarNotasState extends State<PagModificarNotas> {
  late List<PlanEstudios> notas;
  final Map<int, Map<String, TextEditingController>> controllers = {};

  @override
  void initState() {
    super.initState();
    // Crear una copia de las notas recibidas
    notas = widget.notas.map((nota) => nota.copyWith()).toList();

    // Inicializar los controladores para cada campo
    for (int i = 0; i < notas.length; i++) {
      controllers[i] = {
        'p1': TextEditingController(text: notas[i].p1.toString()),
        'p2': TextEditingController(text: notas[i].p2.toString()),
        'p3': TextEditingController(text: notas[i].p3.toString()),
        'ef': TextEditingController(text: notas[i].ef.toString()),
        'c1': TextEditingController(text: notas[i].c1.toString()),
        'c2': TextEditingController(text: notas[i].c2.toString()),
        'c3': TextEditingController(text: notas[i].c3.toString()),
        'c4': TextEditingController(text: notas[i].c4.toString()),
        'c5': TextEditingController(text: notas[i].c5.toString()),
        'c6': TextEditingController(text: notas[i].c6.toString()),
      };
    }
  }

  Future<void> guardarNotas() async {
    final url = Uri.parse(
        "http://${Ruta.ip}/ServidorNotas/Controla1.php?tag=consulta11&codEstudiante=${widget.codE}&codCurso=${widget.codc}");

    for (var nota in notas) {
      final response = await http.post(url, body: {
        'codEstudiante': widget.codE,
        'codCurso': widget.codc,
        'p1': nota.p1.toString(),
        'p2': nota.p2.toString(),
        'p3': nota.p3.toString(),
        'ef': nota.ef.toString(),
        'c1': nota.c1.toString(),
        'c2': nota.c2.toString(),
        'c3': nota.c3.toString(),
        'c4': nota.c4.toString(),
        'c5': nota.c5.toString(),
        'c6': nota.c6.toString(),
      });

      if (response.statusCode != 200) {
        print('Error al guardar las notas: ${response.body}');
      } else {
        print('Respuesta del servidor: ${response.body}');
      }
    }

    // Navegar de regreso a la pantalla anterior y pasar los datos actualizados
    Navigator.pop(context, notas);
  }

  Widget buildNotaTextField(int index, String campo) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: campo.toUpperCase(),
      ),
      controller: controllers[index]?[campo],
      onChanged: (text) {
        // Actualizar el valor en la lista de notas
        setState(() {
          double? newValue = double.tryParse(text);
          if (newValue != null) {
            switch (campo) {
              case 'p1':
                notas[index] = notas[index].copyWith(p1: newValue);
                break;
              case 'p2':
                notas[index] = notas[index].copyWith(p2: newValue);
                break;
              case 'p3':
                notas[index] = notas[index].copyWith(p3: newValue);
                break;
              case 'ef':
                notas[index] = notas[index].copyWith(ef: newValue);
                break;
              case 'c1':
                notas[index] = notas[index].copyWith(c1: newValue);
                break;
              case 'c2':
                notas[index] = notas[index].copyWith(c2: newValue);
                break;
              case 'c3':
                notas[index] = notas[index].copyWith(c3: newValue);
                break;
              case 'c4':
                notas[index] = notas[index].copyWith(c4: newValue);
                break;
              case 'c5':
                notas[index] = notas[index].copyWith(c5: newValue);
                break;
              case 'c6':
                notas[index] = notas[index].copyWith(c6: newValue);
                break;
              default:
                break;
            }
          }
        });
      },
    );
  }

  @override
  void dispose() {
    // Liberar los controladores
    controllers.forEach((_, map) {
      map.forEach((_, controller) {
        controller.dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 37, 206),
        foregroundColor: const Color.fromARGB(255, 235, 234, 238),
        title: const Text('Modificar Notas del Estudiante'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Código del Estudiante: ${widget.codE}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Código del curso: ${widget.codc}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Curso: ${notas[index].nomc} (${notas[index].codc})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildNotaTextField(index, 'p1'),
                          buildNotaTextField(index, 'p2'),
                          buildNotaTextField(index, 'p3'),
                          buildNotaTextField(index, 'ef'),
                          buildNotaTextField(index, 'c1'),
                          buildNotaTextField(index, 'c2'),
                          buildNotaTextField(index, 'c3'),
                          buildNotaTextField(index, 'c4'),
                          buildNotaTextField(index, 'c5'),
                          buildNotaTextField(index, 'c6'),
                          const SizedBox(height: 10),
                          Text(
                              'Promedio Continuas: ${notas[index].promediocontinuas()}'),
                          Text(
                              'Promedio del Curso: ${notas[index].promedioCurso()}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 229, 229, 235),
                backgroundColor: Color.fromARGB(255, 9, 11, 156),
                padding: EdgeInsets.all(10),
              ),
              onPressed: guardarNotas,
              child: const Text('Guardar Notas'),
            ),
          ],
        ),
      ),
    );
  }
}
