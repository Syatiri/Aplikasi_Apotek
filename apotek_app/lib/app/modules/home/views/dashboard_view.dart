import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardView extends GetView<MasterDataController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menyimpan pilihan tabel saat ini
    final selectedTable = RxString("");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Apotek'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildMenuCards(selectedTable),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              // Menampilkan tabel berdasarkan pilihan
              switch (selectedTable.value) {
                case "Sales Table":
                  return _buildSalesTable();
                case "Stock Table":
                  return _buildStockTable();
                case "Customers Table":
                  return _buildCustomersTable();
                case "Users Table": // Tambahkan pilihan User
                   return _buildUsersTable();
                default:
                  return const Center(
                    child: Text(
                      "Pilih menu untuk melihat data",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCards(RxString selectedTable) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Wrap(
      spacing: 16.0, // Jarak horizontal antar kartu
      runSpacing: 16.0, // Jarak vertikal antar kartu
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
          onTap: () => selectedTable.value = "Users Table", // Tambahkan pilihan User
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

Widget _buildSalesTable() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columnSpacing: 16.0,
      headingRowHeight: 56.0,
      dataRowHeight: 56.0,
      columns: const [
        DataColumn(
          label: Text('No Faktur', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Nama Obat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Total Harga', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
      rows: controller.salesData.map((sale) {
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>((states) {
            return Colors.blue.shade50; // Background color for rows
          }),
          cells: [
            DataCell(Text(sale.noFaktur)),
            DataCell(Text(DateFormat('dd/MM/yyyy').format(sale.tanggal))),
            DataCell(Text(sale.obatName)),
            DataCell(Text(sale.quantity.toString())),
            DataCell(Text(controller.currencyFormat.format(sale.totalPrice))),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteSale(sale.noFaktur),
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
          label: Text('Kode Obat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Nama Obat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Stok', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Harga Jual', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
      rows: controller.obatStock.map((medicine) {
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>((states) {
            return Colors.green.shade50; // Background color for rows
          }),
          cells: [
            DataCell(Text(medicine.code)),
            DataCell(Text(medicine.name)),
            DataCell(Text(medicine.stock.toString())),
            DataCell(Text(controller.currencyFormat.format(medicine.salePrice))),
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

Widget _buildUsersTable() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columnSpacing: 16.0,
      headingRowHeight: 56.0,
      dataRowHeight: 56.0,
      columns: const [
        DataColumn(
          label: Text('ID User', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Username', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
      rows: controller.users.map((user) {
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>((states) {
            return Colors.purple.shade50; // Background color for rows
          }),
          cells: [
            DataCell(Text(user.userId)),
            DataCell(Text(user.username)),
            DataCell(Text(user.role)),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteUser(user.userId),
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
          label: Text('ID Pelanggan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Telepon', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        DataColumn(
          label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
      rows: controller.customers.map((customer) {
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>((states) {
            return Colors.orange.shade50; // Background color for rows
          }),
          cells: [
            DataCell(Text(customer.customerId)),
            DataCell(Text(customer.name)),
            DataCell(Text(customer.phone)),
            DataCell(Text(customer.address)),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteCustomer(customer.customerId),
              ),
            ),
          ],
        );
      }).toList(),
    ),
  );
}
}
