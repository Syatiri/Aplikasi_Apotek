import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apotek_app/app/routes/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apotek Dashboard'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildMenuCard(
              icon: Icons.list_alt,
              title: 'Master Data',
              color: Colors.blue,
              onTap: () => Get.toNamed(
                  AppRoutes.dashboard), // Pastikan rute ini tersedia
            ),
            _buildMenuCard(
              icon: Icons.shopping_cart,
              title: 'Transaksi',
              color: Colors.green,
              onTap: () => Get.toNamed(AppRoutes.transaksi),
            ),
            _buildMenuCard(
              icon: Icons.receipt,
              title: 'Laporan',
              color: Colors.orange,
              onTap: () =>
                  Get.toNamed(AppRoutes.laporan), // Tambahkan rute laporan
            ),
            _buildMenuCard(
              icon: Icons.logout,
              title: 'Logout',
              color: Colors.red,
              onTap: () => _showLogoutConfirmation(context),
            ),
          ],
        ),
      ),
    );
  }

  // Metode untuk menampilkan konfirmasi logout
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika logout di sini
              // Misalnya: hapus token, clear session, dll.
              Get.offAllNamed(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
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
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            const SizedBox(height: 10),
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
