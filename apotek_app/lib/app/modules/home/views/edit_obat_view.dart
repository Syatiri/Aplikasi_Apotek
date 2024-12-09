import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apotek_app/app/modules/home/model/obat.dart';
import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';

class EditObatView extends StatefulWidget {
  const EditObatView({Key? key}) : super(key: key);

  @override
  _EditObatViewState createState() => _EditObatViewState();
}

class _EditObatViewState extends State<EditObatView> {
  late Obat obat;
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ambil data Obat yang dikirim lewat arguments
    obat = Get.arguments;
    _codeController.text = obat.code;
    _nameController.text = obat.name;
    _stockController.text = obat.stock.toString();
    _priceController.text = obat.salePrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Obat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Kode Obat',
                  border: OutlineInputBorder(),
                ),
                enabled: false, // Kode obat tidak bisa diubah
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Obat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama obat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Stok harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga Jual',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga jual tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga jual harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedObat = Obat(
                      code: obat.code,
                      name: _nameController.text,
                      stock: int.parse(_stockController.text),
                      salePrice: double.parse(_priceController.text),
                    );
                    
                    // Debug log untuk memeriksa data yang dikirim
                    print('Updated Obat: ${updatedObat.name}, ${updatedObat.stock}, ${updatedObat.salePrice}');
                    
                    // Perbarui data obat menggunakan controller
                    Get.find<MasterDataController>().updatedObat(obat.code, updatedObat);
                    
                    // Kembali ke halaman sebelumnya dan tampilkan snackbar
                    Get.back();
                    Get.snackbar(
                      'Sukses',
                      'Data obat berhasil diperbarui',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: const Text('Simpan Perubahan'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
