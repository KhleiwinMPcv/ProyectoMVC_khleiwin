class Pago {
  final String cuota;
  final double monto;
  final String descuento;
  final String fecha;

  Pago(
      {required this.cuota,
      required this.monto,
      required this.descuento,
      required this.fecha});

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      cuota: json['cuota'],
      monto: double.parse(json['monto'].toString()),
      descuento: json['descuento'] ?? '',
      fecha: json['fecha'],
    );
  }
  double des() {
    switch (descuento) {
      case "Descuento por pronto":
        return 0.10 * monto;
      default:
        return 0;
    }
  }

  double pagoTotal(List<Pago> pagos) {
    double total = 0;
    for (var pago in pagos) {
      total += pago.monto;
    }
    return total - des();
  }
}
