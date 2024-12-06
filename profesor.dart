class Profesor {
  final String codp;
  final String code;
  final String nomp;
  final String celular;
  final String direccp;
  final String grado;
  final String anios;

  Profesor({
    required this.codp,
    required this.code,
    required this.nomp,
    required this.celular,
    required this.direccp,
    required this.grado,
    required this.anios,
  });

  factory Profesor.fromJson(Map<String, dynamic> json) {
    return Profesor(
      codp: json['codp'] ?? '',
      code: json['code'] ?? '',
      nomp: json['nomp'] ?? '',
      celular: json['tp'] ?? '',
      direccp: json['dp'] ?? '',
      grado: json['gp'] ?? '',
      anios: json['acp'] ?? '',
    );
  }

  String especialidad() {
    switch (code) {
      case "ESP001":
        return "Ingeniería de Software";
      case "ESP002":
        return "Bases de Datos y Programación";
      case "ESP003":
        return "Programación";
      case "ESP004":
        return "Algorítmica";
      case "ESP005":
        return "Ingeniería de Sistemas";
      default:
        return "Estadística";
    }
  }
}
