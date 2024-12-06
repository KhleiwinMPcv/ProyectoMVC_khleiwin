class PlanEstudios {
  final String codc;
  final String nomc;
  final String tp;
  final String ht;
  final String hp;
  final String req;

  PlanEstudios({
    required this.codc,
    required this.nomc,
    required this.tp,
    required this.ht,
    required this.hp,
    required this.req,
  });

  // Factory method fromJson
  factory PlanEstudios.fromJson(Map<String, dynamic> json) {
    return PlanEstudios(
      codc: json['codc'] ?? '',
      nomc: json['nomc'] ?? '',
      tp: json['tipo'] ?? '',
      ht: json['ht'] ?? '',
      hp: json['hp'] ?? '',
      req: json['req'] ?? '',
    );
  }

  String cre() {
    return '3';
  }
}
