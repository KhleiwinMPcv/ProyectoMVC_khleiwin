class PlanEstudios {
  final String codc;
  final String nomc;
  final String nomp;
  double p1;
  double p2;
  double p3;
  double ef;
  double c1;
  double c2;
  double c3;
  double c4;
  double c5;
  double c6;

  PlanEstudios({
    required this.codc,
    required this.nomc,
    required this.nomp,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.ef,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  // Factory method fromJson
  factory PlanEstudios.fromJson(Map<String, dynamic> json) {
    return PlanEstudios(
      codc: json['codc'] ?? '',
      nomc: json['nomc'] ?? '',
      nomp: json['nomp'] ?? '',
      p1: double.parse(json['p1'].toString()),
      p2: double.parse(json['p2'].toString()),
      p3: double.parse(json['p3'].toString()),
      ef: double.parse(json['ef'].toString()),
      c1: double.parse(json['c1'].toString()),
      c2: double.parse(json['c2'].toString()),
      c3: double.parse(json['c3'].toString()),
      c4: double.parse(json['c4'].toString()),
      c5: double.parse(json['c5'].toString()),
      c6: double.parse(json['c6'].toString()),
    );
  }

  // Método para copiar con nuevos valores
  PlanEstudios copyWith({
    double? p1,
    double? p2,
    double? p3,
    double? ef,
    double? c1,
    double? c2,
    double? c3,
    double? c4,
    double? c5,
    double? c6,
  }) {
    return PlanEstudios(
      codc: this.codc,
      nomc: this.nomc,
      nomp: this.nomp,
      p1: p1 ?? this.p1,
      p2: p2 ?? this.p2,
      p3: p3 ?? this.p3,
      ef: ef ?? this.ef,
      c1: c1 ?? this.c1,
      c2: c2 ?? this.c2,
      c3: c3 ?? this.c3,
      c4: c4 ?? this.c4,
      c5: c5 ?? this.c5,
      c6: c6 ?? this.c6,
    );
  }

  double promediocontinuas() {
    return (c1 + c2 + c3 + c4 + c5 + c6) / 6;
  }

  double promedioCurso() {
    return (p1 * 0.1 +
        p2 * 0.2 +
        p3 * 0.2 +
        promediocontinuas() * 0.2 +
        ef * 0.3);
  }
}
