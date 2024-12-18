import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';
import 'package:apotek_app/app/modules/home/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final roles = ['Pegawai', 'Kasir'];
  String? selectedRole;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final MasterDataController controller = Get.find<MasterDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
        backgroundColor: Colors.green.shade700, // Ganti warna appbar menjadi hijau
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Form Register User',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green), // Ganti warna teks menjadi hijau
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 16),
                  _buildRoleDropdown(),
                  const SizedBox(height: 24),
                  _buildSaveButton(), // Tombol Simpan tetap transparan
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for email field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green), // Ganti warna label menjadi hijau
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2), // Ganti border fokus menjadi hijau
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade300),
        ),
      ),
    );
  }

  // Password field with visibility toggle
  Widget _buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.green),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.green,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade300),
        ),
      ),
    );
  }

  // Confirm password field with visibility toggle
  Widget _buildConfirmPasswordField() {
    return TextField(
      controller: confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.green),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.green,
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        labelText: 'Confirm Password',
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade300),
        ),
      ),
    );
  }

  // Role dropdown
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Role',
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(),
      ),
      items: roles
          .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedRole = value;
        });
      },
      value: selectedRole,
    );
  }

  // Save button with transparent background
  Widget _buildSaveButton() {
    return Center(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            final email = emailController.text.trim();
            final password = passwordController.text.trim();
            final confirmPassword = confirmPasswordController.text.trim();
            final role = selectedRole;

            if (email.isEmpty || password.isEmpty || role == null) {
              Get.snackbar('Error', 'Semua field harus diisi');
              return;
            }

            if (password.length < 6 || confirmPassword.length < 6) {
              Get.snackbar('Error', 'Password dan konfirmasi password harus minimal 6 karakter');
              return;
            }

            if (password != confirmPassword) {
              Get.snackbar('Error', 'Password dan konfirmasi password tidak cocok');
              return;
            }

            if (controller.findUserByUsername(email) != null) {
              Get.snackbar('Error', 'Email sudah digunakan');
              return;
            }

            final newUser = User(
              userId: DateTime.now().millisecondsSinceEpoch.toString(),
              username: email,
              password: password,
              role: role,
            );

            controller.addUser(newUser);
            Get.snackbar('Success', 'User berhasil ditambahkan');

            // Reset form
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
            setState(() {
              selectedRole = null;
            });

            // Navigate to login page
            Get.offAllNamed('/login');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            backgroundColor: Colors.transparent, // Tombol transparan
            side: const BorderSide(color: Colors.green, width: 2), // Border hijau
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut melengkung
            ),
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(color: Colors.black), // Warna teks hijau
          ),
        ),
      ),
    );
  }
}
