import 'package:apotek_app/app/modules/home/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green.shade700,  // Ganti warna appbar menjadi hijau
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLogo(),
              const SizedBox(height: 40),
              _emailTextField(),
              const SizedBox(height: 16),
              _passwordTextField(),
              const SizedBox(height: 24),
              _buttonLogin(),
              const SizedBox(height: 30),
              _menuRegistrasi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.green.shade100,  // Ganti warna background logo menjadi hijau muda
          child: const Icon(Icons.local_pharmacy, size: 48, color: Colors.green),
        ),
        const SizedBox(height: 12),
        const Text(
          'Login',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.green,  // Ganti warna teks menjadi hijau
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.green),  // Ganti warna label menjadi hijau
        prefixIcon: Icon(Icons.email, color: Colors.green),  // Ganti warna ikon menjadi hijau
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return Obx(() {
      return TextFormField(
        controller: _passwordController,
        obscureText: !isPasswordVisible.value,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(color: Colors.green),  // Ganti warna label menjadi hijau
          prefixIcon: const Icon(Icons.lock, color: Colors.green),  // Ganti warna ikon menjadi hijau
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
              color: Colors.green,  // Ganti warna ikon mata menjadi hijau
            ),
            onPressed: () {
              isPasswordVisible.value = !isPasswordVisible.value;
            },
          ),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password harus diisi';
          }
          if (value.length < 6) {
            return 'Password minimal 6 karakter';
          }
          return null;
        },
      );
    });
  }

  Widget _buttonLogin() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: Colors.green.shade800, width: 2),  // Border hijau gelap
        backgroundColor: Colors.transparent,  // Latar belakang transparan
        shadowColor: Colors.transparent,  // Menghilangkan bayangan
        elevation: 0,  // Menghilangkan efek elevation
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          setState(() {
            _isLoading = true;
          });
          // Simulate login processing
          Future.delayed(const Duration(seconds: 2), () {
            Get.off(() => const HomeView());
          });
        }
      },
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 44, 117, 47),  // Teks berwarna hijau gelap
              ),
            ),
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: Colors.redAccent, width: 2),  // Border merah
          backgroundColor: Colors.transparent,  // Latar belakang transparan
          shadowColor: Colors.transparent,  // Menghilangkan bayangan
          elevation: 0,  // Menghilangkan efek elevation
        ),
        onPressed: () {
          Get.to(() => const RegisterView());
        },
        child: const Text(
          "Registrasi",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,  // Teks berwarna merah
          ),
        ),
      ),
    );
  }
}
