class Obat {
  final String code;
  final String name;
  int stock;
  final double salePrice;

  Obat({
    required this.code,
    required this.name,
    required this.stock,
    required this.salePrice,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'stock': stock,
    'salePrice': salePrice,
  };

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
    code: json['code'],
    name: json['name'],
    stock: json['stock'],
    salePrice: json['salePrice'],
  );

   factory Obat.defaultObat() {
    return Obat(
      code: '0000',
      name: 'Nama Obat Tidak Diketahui',
      stock: 0,
      salePrice: 0.0,
    );
  }
}