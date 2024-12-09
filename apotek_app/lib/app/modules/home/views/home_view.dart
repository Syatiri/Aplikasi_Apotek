import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apotek_app/app/routes/app_routes.dart';
import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Apotek'),
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildMenuCard(
            icon: Icons.dashboard,
            title: 'Dashboard',
            color: Colors.blue,
            onTap: () => Get.toNamed(AppRoutes.dashboard),
          ),
          _buildMenuCard(
            icon: Icons.add,
            title: 'Add Obat',
            color: Colors.red,
            onTap: () => Get.toNamed(AppRoutes.addObat),
          ),
          _buildMenuCard(
            icon: Icons.update,
            title: 'Update Obat',
            color: Colors.green,
            onTap: () => _showObatSelectionDialog(context),
          ),
          _buildMenuCard(
            icon: Icons.shopping_cart,
            title: 'Transaksi',
            color: Colors.orange,
            onTap: () => Get.toNamed(AppRoutes.transaksi),
          ),
          _buildMenuCard(
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.grey,
            onTap: () => Get.offAllNamed(AppRoutes.login),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pemilihan obat
  void _showObatSelectionDialog(BuildContext context) {
    final controller = Get.find<MasterDataController>();

    if (controller.obatStock.isEmpty) {
      Get.snackbar(
        'Data Kosong',
        'Belum ada data obat untuk diubah',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Obat untuk Diubah'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.obatStock.length,
            itemBuilder: (context, index) {
              final obat = controller.obatStock[index];
              return ListTile(
                title: Text(obat.name),
                subtitle: Text('Kode: ${obat.code}, Stok: ${obat.stock}'),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.editObat, arguments: obat);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat menu kartu
  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
