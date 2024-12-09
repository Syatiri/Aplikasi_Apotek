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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final roles = ['Pegawai', 'Kasir'];
  String? selectedRole; // Role yang dipilih
  bool _isPasswordVisible = false; // State untuk visibilitas password

  final MasterDataController controller = Get.find<MasterDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Form Register User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible, // Tampilkan atau sembunyikan password
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Role',
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
            ),
            const SizedBox(height: 24), // Jarak antara dropdown dan tombol
            Center(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text.trim();
                    final password = passwordController.text.trim();
                    final role = selectedRole;

                    if (username.isEmpty || password.isEmpty || role == null) {
                      Get.snackbar('Error', 'Semua field harus diisi');
                      return;
                    }

                    if (controller.findUserByUsername(username) != null) {
                      Get.snackbar('Error', 'Username sudah digunakan');
                      return;
                    }

                    final newUser = User(
                      userId: DateTime.now().millisecondsSinceEpoch.toString(),
                      username: username,
                      password: password,
                      role: role,
                    );

                    controller.addUser(newUser); // Tambahkan user baru
                    Get.snackbar('Success', 'User berhasil ditambahkan');

                    // Reset form
                    usernameController.clear();
                    passwordController.clear();
                    setState(() {
                      selectedRole = null;
                    });

                    // Navigasi ke halaman login
                    Get.offAllNamed('/login'); // Pindah ke halaman login
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Simpan'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
