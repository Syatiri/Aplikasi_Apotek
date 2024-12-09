import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apotek_app/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  // Navigasi ke halaman berikutnya (Login)
  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash tampil selama 2 detik
    if (mounted) {
      Get.offAllNamed(AppRoutes.login); // Ganti ke halaman Login dan hapus riwayat
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 141, 227),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau teks selamat datang
            Text(
              'Welcome to Apotek App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                letterSpacing: 2.0,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Animasi loading
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
