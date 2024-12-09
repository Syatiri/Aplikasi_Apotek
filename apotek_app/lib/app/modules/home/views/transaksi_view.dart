import 'package:apotek_app/app/modules/home/model/customer.dart';
import 'package:apotek_app/app/modules/home/model/sale.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/master_data_controller.dart';

class TransactionForm extends StatelessWidget {
  final MasterDataController controller = Get.find();

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController customerAddressController = TextEditingController();
  final TextEditingController obatNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final RxBool isProcessing = false.obs; // Flag untuk menghindari transaksi dua kali

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Data Customer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Customer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: customerPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: customerAddressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Data Transaksi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: obatNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Obat',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => ElevatedButton(
                  onPressed: isProcessing.value
                      ? null
                      : () async {
                          isProcessing.value = true;
                          try {
                            final String customerName =
                                customerNameController.text.trim();
                            final String customerPhone =
                                customerPhoneController.text.trim();
                            final String customerAddress =
                                customerAddressController.text.trim();
                            final String obatName =
                                obatNameController.text.trim();
                            final int quantity = int.tryParse(
                                    quantityController.text.trim()) ??
                                0;

                            // Validasi input
                            if (customerName.isEmpty ||
                                customerPhone.isEmpty ||
                                customerAddress.isEmpty ||
                                obatName.isEmpty ||
                                quantity <= 0) {
                              throw Exception('Semua field harus diisi dengan benar');
                            }

                            // Validasi atau tambahkan customer baru
                            final existingCustomer = controller.customers.firstWhere(
                              (customer) => customer.name == customerName,
                              orElse: () => Customer(
                                customerId: DateTime.now().millisecondsSinceEpoch.toString(),
                                name: customerName,
                                phone: customerPhone,
                                address: customerAddress,
                              ),
                            );

                            if (!controller.customers.contains(existingCustomer)) {
                              controller.addCustomer(existingCustomer);
                            }

                            // Cek dan ambil harga obat
                            double totalPrice;
                            try {
                              totalPrice = controller.getObatPrice(obatName) * quantity;
                            } catch (e) {
                              Get.snackbar('Error', e.toString());
                              return; // Stop transaksi jika error pada harga
                            }

                            // Buat transaksi baru
                            final sale = Sale(
                              noFaktur: DateTime.now().millisecondsSinceEpoch.toString(),
                              tanggal: DateTime.now(),
                              obatName: obatName,
                              quantity: quantity,
                              totalPrice: totalPrice,
                              customer: customerName,
                            );

                            // Tambahkan transaksi menggunakan controller
                            controller.addSale(sale);

                            // Tampilkan notifikasi sukses
                            Get.snackbar('Sukses', 'Transaksi berhasil ditambahkan');

                            // Kembali ke halaman Home
                            Get.offAllNamed('/home'); // Mengarahkan langsung ke halaman Home
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          } finally {
                            isProcessing.value = false;
                          }
                        },
                  child: isProcessing.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Simpan Transaksi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
