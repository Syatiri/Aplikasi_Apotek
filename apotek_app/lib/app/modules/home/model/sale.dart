class Sale {
  final String noFaktur;
  final DateTime tanggal;
  final String obatName;
  final int quantity;
  final double totalPrice;
  final String customer;

  Sale({
    required this.noFaktur,
    required this.tanggal,
    required this.obatName,
    required this.quantity,
    required this.totalPrice,
    required this.customer,
  });

  Map<String, dynamic> toJson() => {
    'noFaktur': noFaktur,
    'tanggal': tanggal.toIso8601String(),
    'obatName': obatName,
    'quantity': quantity,
    'totalPrice': totalPrice,
    'customer': customer,
  };

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    noFaktur: json['noFaktur'],
    tanggal: DateTime.parse(json['tanggal']),
    obatName: json['obatName'],
    quantity: json['quantity'],
    totalPrice: json['totalPrice'],
    customer: json['customer'],
  );
}