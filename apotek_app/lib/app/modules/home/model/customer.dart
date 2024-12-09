class Customer {
  final String customerId;
  final String name;
  final String phone;
  final String address;

  Customer({
    required this.customerId,
    required this.name,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'name': name,
    'phone': phone,
    'address': address,
  };

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json['customerId'],
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
  );
}
