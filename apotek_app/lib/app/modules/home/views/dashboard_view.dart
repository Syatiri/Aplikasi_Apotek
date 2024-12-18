import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';
import 'package:apotek_app/app/modules/home/model/customer.dart';
import 'package:apotek_app/app/modules/home/model/sale.dart';
import 'package:apotek_app/app/modules/home/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardView extends GetView<MasterDataController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTable = RxString("");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Data Apotek'),
        actions: [
          Obx(() {
            if (selectedTable.value.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddDialog(selectedTable.value),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildMenuCards(selectedTable),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              switch (selectedTable.value) {
                case "Sales Table":
                  return _buildSalesTable();
                case "Stock Table":
                  return _buildStockTable();
                case "Customers Table":
                  return _buildCustomersTable();
                case "Users Table":
                  return _buildUsersTable();
                default:
                  return const Center(
                    child: Text(
                      "Pilih menu untuk melihat data",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(String tableType) {
    switch (tableType) {
      case "Sales Table":
        _showAddSaleDialog();
        break;
      case "Stock Table":
        _showAddStockDialog();
        break;
      case "Customers Table":
        _showAddCustomerDialog();
        break;
      case "Users Table":
        _showAddUserDialog();
        break;
    }
  }

  void _showAddUserDialog({User? existingUser}) {
    final userIdController =
        TextEditingController(text: existingUser?.userId ?? '');
    final usernameController =
        TextEditingController(text: existingUser?.username ?? '');
    final passwordController =
        TextEditingController(text: existingUser?.password ?? '');
    final roleController =
        TextEditingController(text: existingUser?.role ?? '');

    Get.dialog(
      AlertDialog(
        title: Text(existingUser == null ? 'Tambah User' : 'Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(labelText: 'User ID'),
              enabled: existingUser == null,
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final newUser = User(
                userId: userIdController.text,
                username: usernameController.text,
                password: passwordController.text,
                role: roleController.text,
              );

              if (existingUser == null) {
                controller.addUser(newUser);
              } else {
                controller.updateUser;
              }

              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showAddSaleDialog({Sale? existingSale}) {
    final noFakturController =
        TextEditingController(text: existingSale?.noFaktur ?? '');
    final obatNameController =
        TextEditingController(text: existingSale?.obatName ?? '');
    final quantityController =
        TextEditingController(text: existingSale?.quantity.toString() ?? '');
    final totalPriceController =
        TextEditingController(text: existingSale?.totalPrice.toString() ?? '');
    final customerController =
        TextEditingController(text: existingSale?.customer ?? '');

    Get.dialog(
      AlertDialog(
        title:
            Text(existingSale == null ? 'Tambah Penjualan' : 'Edit Penjualan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: noFakturController,
              decoration: const InputDecoration(labelText: 'Nomor Faktur'),
              enabled: existingSale == null,
            ),
            TextField(
              controller: obatNameController,
              decoration: const InputDecoration(labelText: 'Nama Obat'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah'),
            ),
            TextField(
              controller: totalPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Total Harga'),
            ),
            TextField(
              controller: customerController,
              decoration: const InputDecoration(labelText: 'Nama Pelanggan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final newSale = Sale(
                noFaktur: noFakturController.text,
                tanggal: existingSale?.tanggal ?? DateTime.now(),
                obatName: obatNameController.text,
                quantity: int.parse(quantityController.text),
                totalPrice: double.parse(totalPriceController.text),
                customer: customerController.text,
              );

              if (existingSale == null) {
                controller.addSale(newSale);
              } else {
                controller.updateSale(newSale.noFaktur, newSale);
              }

              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showAddStockDialog() {
    // Implement stock addition dialog
  }

  void _showAddCustomerDialog({Customer? existingCustomer}) {
    final customerIdController =
        TextEditingController(text: existingCustomer?.customerId ?? '');
    final nameController =
        TextEditingController(text: existingCustomer?.name ?? '');
    final phoneController =
        TextEditingController(text: existingCustomer?.phone ?? '');
    final addressController =
        TextEditingController(text: existingCustomer?.address ?? '');

    Get.dialog(
      AlertDialog(
        title: Text(
            existingCustomer == null ? 'Tambah Pelanggan' : 'Edit Pelanggan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: customerIdController,
              decoration: const InputDecoration(labelText: 'ID Pelanggan'),
              enabled: existingCustomer == null,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Telepon'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final newCustomer = Customer(
                customerId: customerIdController.text,
                name: nameController.text,
                phone: phoneController.text,
                address: addressController.text,
              );

              if (existingCustomer == null) {
                controller.addCustomer(newCustomer);
              } else {
                controller.updateCustomer;
              }

              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCards(RxString selectedTable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: [
          _buildCard(
            title: "Sales Table",
            icon: Icons.shopping_cart,
            color: Colors.blue,
            onTap: () => selectedTable.value = "Sales Table",
          ),
          _buildCard(
            title: "Stock Table",
            icon: Icons.inventory,
            color: Colors.green,
            onTap: () => selectedTable.value = "Stock Table",
          ),
          _buildCard(
            title: "Customers Table",
            icon: Icons.people,
            color: Colors.orange,
            onTap: () => selectedTable.value = "Customers Table",
          ),
          _buildCard(
            title: "Users Table",
            icon: Icons.person,
            color: Colors.purple,
            onTap: () => selectedTable.value = "Users Table",
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: color,
        child: SizedBox(
          width: 100,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsersTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.0,
        headingRowHeight: 56.0,
        dataRowHeight: 56.0,
        columns: const [
          DataColumn(
            label:
                Text('User ID', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label:
                Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        rows: controller.users.map((user) {
          return DataRow(
            cells: [
              DataCell(Text(user.userId)),
              DataCell(Text(user.username)),
              DataCell(Text(user.role)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showAddUserDialog(existingUser: user),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteUser(user.userId),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSalesTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.0,
        headingRowHeight: 56.0,
        dataRowHeight: 56.0,
        columns: const [
          DataColumn(
            label: Text('No Faktur',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label:
                Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Nama Obat',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label:
                Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Total Harga',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Pelanggan',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        rows: controller.salesData.map((sale) {
          return DataRow(
            cells: [
              DataCell(Text(sale.noFaktur)),
              DataCell(Text(DateFormat('dd/MM/yyyy').format(sale.tanggal))),
              DataCell(Text(sale.obatName)),
              DataCell(Text(sale.quantity.toString())),
              DataCell(Text(
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                      .format(sale.totalPrice))),
              DataCell(Text(sale.customer)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showAddSaleDialog(existingSale: sale),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteSale(sale.noFaktur),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStockTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.0,
        headingRowHeight: 56.0,
        dataRowHeight: 56.0,
        columns: const [
          DataColumn(
            label: Text('Kode Obat',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Nama Obat',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Stok', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Harga Jual',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        rows: controller.obatStock.map((medicine) {
          return DataRow(
            cells: [
              DataCell(Text(medicine.code)),
              DataCell(Text(medicine.name)),
              DataCell(Text(medicine.stock.toString())),
              DataCell(Text(
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                      .format(medicine.salePrice))),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteStock(medicine.code),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCustomersTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.0,
        headingRowHeight: 56.0,
        dataRowHeight: 56.0,
        columns: const [
          DataColumn(
            label: Text('ID Pelanggan',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label:
                Text('Telepon', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label:
                Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        rows: controller.customers.map((customer) {
          return DataRow(
            cells: [
              DataCell(Text(customer.customerId)),
              DataCell(Text(customer.name)),
              DataCell(Text(customer.phone)),
              DataCell(Text(customer.address)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () =>
                          _showAddCustomerDialog(existingCustomer: customer),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          controller.deleteCustomer(customer.customerId),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // void _showAddCustomerDialog({Customer? existingCustomer}) {
  //   final customerIdController =
  //       TextEditingController(text: existingCustomer?.customerId ?? '');
  //   final nameController =
  //       TextEditingController(text: existingCustomer?.name ?? '');
  //   final phoneController =
  //       TextEditingController(text: existingCustomer?.phone ?? '');
  //   final addressController =
  //       TextEditingController(text: existingCustomer?.address ?? '');

  //   Get.dialog(
  //     AlertDialog(
  //       title: Text(
  //           existingCustomer == null ? 'Tambah Pelanggan' : 'Edit Pelanggan'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: customerIdController,
  //             decoration: const InputDecoration(labelText: 'ID Pelanggan'),
  //             enabled: existingCustomer == null,
  //           ),
  //           TextField(
  //             controller: nameController,
  //             decoration: const InputDecoration(labelText: 'Nama'),
  //           ),
  //           TextField(
  //             controller: phoneController,
  //             keyboardType: TextInputType.phone,
  //             decoration: const InputDecoration(labelText: 'Telepon'),
  //           ),
  //           TextField(
  //             controller: addressController,
  //             decoration: const InputDecoration(labelText: 'Alamat'),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: const Text('Batal'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             final newCustomer = Customer(
  //               customerId: customerIdController.text,
  //               name: nameController.text,
  //               phone: phoneController.text,
  //               address: addressController.text,
  //             );

  //             if (existingCustomer == null) {
  //               controller.addCustomer(newCustomer);
  //             } else {
  //               controller.updateCustomer;
  //             }

  //             Get.back();
  //           },
  //           child: const Text('Simpan'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _showAddStockDialog() {
  //   final codeController = TextEditingController();
  //   final nameController = TextEditingController();
  //   final stockController = TextEditingController();
  //   final salePriceController = TextEditingController();

  //   Get.dialog(
  //     AlertDialog(
  //       title: const Text('Tambah Stok Obat'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: codeController,
  //             decoration: const InputDecoration(labelText: 'Kode Obat'),
  //           ),
  //           TextField(
  //             controller: nameController,
  //             decoration: const InputDecoration(labelText: 'Nama Obat'),
  //           ),
  //           TextField(
  //             controller: stockController,
  //             keyboardType: TextInputType.number,
  //             decoration: const InputDecoration(labelText: 'Stok'),
  //           ),
  //           TextField(
  //             controller: salePriceController,
  //             keyboardType: TextInputType.number,
  //             decoration: const InputDecoration(labelText: 'Harga Jual'),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: const Text('Batal'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             final newObat = Obat(
  //               code: codeController.text,
  //               name: nameController.text,
  //               stock: int.parse(stockController.text),
  //               salePrice: double.parse(salePriceController.text),
  //             );

  //             controller.addObat(newObat);
  //             Get.back();
  //           },
  //           child: const Text('Simpan'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
