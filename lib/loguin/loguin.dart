import 'package:flutter/material.dart';
import 'package:flutter_application_notas_remoto/loguin/Ruta.dart';
import 'package:flutter_application_notas_remoto/loguin/menuadministrador.dart';
import 'package:flutter_application_notas_remoto/loguin/menuestudiante.dart';
import 'package:flutter_application_notas_remoto/loguin/menuprofesor.dart';
import 'package:flutter_application_notas_remoto/loguin/servicioautenticacion.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  void _login(BuildContext context) async {
    String user = _userController.text.trim();
    String password = _passwordController.text.trim();

    bool loggedIn = await ServicioCredenciales().login(user, password);

    if (loggedIn) {
      if (password.startsWith('A')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AdministradorHomePage(nombreUsuario: password),
          ),
        );
      } else if (password.startsWith('P')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessorHomePage(nombreUsuario: password),
          ),
        );
      } else if (user.length == 10) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EstudianteHomePage(nombreUsuario: user),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Usuario o contraseña incorrectos'),
            actions: <Widget>[
              TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 21, 32, 129),
                  backgroundColor: Color.fromARGB(255, 61, 168, 187),
                  padding: EdgeInsets.all(10),
                ),
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 37, 206),
        foregroundColor: Color.fromARGB(255, 235, 234, 238),
        title: Text('INICIAR SESIÓN'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Widget para mostrar la foto de perfil o una imagen predeterminada
            ImageWidget(userController: _userController),
            SizedBox(height: 20.0),
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 0, 0, 0),
                backgroundColor: Color.fromARGB(255, 61, 126, 187),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                _login(context);
              },
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final TextEditingController userController;

  const ImageWidget({Key? key, required this.userController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "http://${Ruta.ip}/ServidorNotas/fotos1/${userController.text.trim()}.jpg";

    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            'assets/sin_foto.jpg', // Ruta de la imagen predeterminada
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
