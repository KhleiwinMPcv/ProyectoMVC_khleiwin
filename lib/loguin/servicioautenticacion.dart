class ServicioCredenciales {
  Future<bool> login(String user, String password) async {
    if ((user == 'administrador' && password == 'ADM001') ||
        (user == 'administrador' && password == 'ADM002') ||
        (user == 'administrador' && password == 'ADM003') ||
        (user == 'administrador' && password == 'ADM004')) {
      return true;
    } else if ((user == '@ramirez' && password == 'PROF001') ||
        (user == '@lopez' && password == 'PROF002') ||
        (user == '@quispe' && password == 'PROF003') ||
        (user == '@piedra' && password == 'PROF004') ||
        (user == '@cardenas' && password == 'PROF005') ||
        (user == '@huaman' && password == 'PROF006')) {
      return true;
    } else if ((user == '2022101028' && password == '1234') ||
        (user == '2022101010' && password == '1234') ||
        (user == '2022101011' && password == '1234') ||
        (user == '2022101012' && password == '1234') ||
        (user == '2022101013' && password == '1234') ||
        (user == '2022101014' && password == '1234') ||
        (user == '2022101015' && password == '1234')) {
      return true;
    } else {
      return false;
    }
  }
}
