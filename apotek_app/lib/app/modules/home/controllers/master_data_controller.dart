import 'package:apotek_app/app/modules/home/model/customer.dart';
import 'package:apotek_app/app/modules/home/model/obat.dart';
import 'package:apotek_app/app/modules/home/model/sale.dart';
import 'package:apotek_app/app/modules/home/model/user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MasterDataController extends GetxController {
  final salesData = <Sale>[].obs;
  final obatStock = <Obat>[].obs;
  final customers = <Customer>[].obs;
  final users = <User>[].obs; // Tambahkan daftar user
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() {
    // Initialize with sample data
    obatStock.addAll([
      Obat(
        code: 'M001',
        name: 'Paracetamol',
        stock: 50,
        salePrice: 1000,
      ),
      Obat(
        code: 'M002',
        name: 'Amoxicillin',
        stock: 30,
        salePrice: 15000,
      ),
    ]);

    salesData.addAll([
      Sale(
        noFaktur: 'F123',
        tanggal: DateTime.now(),
        obatName: 'Paracetamol',
        quantity: 2,
        totalPrice: 2000,
        customer: 'John Doe',
      ),
    ]);

    customers.addAll([
      Customer(
        customerId: 'C001',
        name: 'John Doe',
        phone: '081234567890',
        address: 'Jl. Merdeka No. 1',
      ),
    ]);

    // Tambahkan data user awal
    users.addAll([
      User(
        userId: 'U001',
        username: 'admin',
        password: 'admin123',
        role: 'Admin',
      ),
      User(
        userId: 'U002',
        username: 'kasir1',
        password: 'kasir123',
        role: 'Kasir',
      ),
    ]);
  }

  void addObat(Obat obat) {
    obatStock.add(obat);
    update();
  }

  double getObatPrice(String obatName) {
    try {
      final obat = obatStock.firstWhere(
        (med) => med.name == obatName,
        orElse: () => throw Exception('Obat tidak ditemukan'),
      );
      return obat.salePrice;
    } catch (e) {
      // Jika obat tidak ditemukan, lempar exception
      throw Exception('Harga obat tidak ditemukan');
    }
  }

  void addSale(Sale sale) {
    try {
      // Validasi keberadaan obat
      final obat = obatStock.firstWhere(
        (med) => med.name == sale.obatName,
        orElse: () => throw Exception('Obat tidak ditemukan'),
      );

      // Validasi stok obat
      if (obat.stock < sale.quantity) {
        throw Exception('Stok obat tidak mencukupi');
      }

      // Kurangi stok obat
      obat.stock -= sale.quantity;
      obatStock.refresh();

      // Tambahkan transaksi ke daftar
      salesData.add(sale);

      // Notifikasi berhasil
      Get.snackbar('Sukses', 'Transaksi berhasil ditambahkan');
    } catch (e) {
      // Tangani error
      Get.snackbar('Error', e.toString());
      rethrow; // Lempar kembali untuk ditangani lebih lanjut jika diperlukan
    }
  }

  void updateSale(String noFaktur, Sale updatedSale) {
    try {
      final index = salesData.indexWhere((sale) => sale.noFaktur == noFaktur);

      if (index != -1) {
        final obat = obatStock.firstWhere(
          (med) => med.name == updatedSale.obatName,
          orElse: () => throw Exception('Obat tidak ditemukan'),
        );

        final oldSale = salesData[index];
        final difference = updatedSale.quantity - oldSale.quantity;

        if (obat.stock < difference) {
          throw Exception('Stok obat tidak mencukupi untuk pembaruan');
        }

        obat.stock -= difference;
        obatStock.refresh();

        salesData[index] = updatedSale;
        salesData.refresh();

        Get.snackbar('Sukses', 'Transaksi berhasil diperbarui');
      } else {
        throw Exception('Transaksi dengan no faktur $noFaktur tidak ditemukan');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  void updatedObat(String code, Obat updatedObat) {
    final index = obatStock.indexWhere((obat) => obat.code == code);
    if (index != -1) {
      obatStock[index] = updatedObat;
      obatStock.refresh();
    }
  }

  void addCustomer(Customer customer) {
    customers.add(customer);
    update();
  }

  void updateCustomer(String customerId, Customer updatedCustomer) {
    try {
      final index =
          customers.indexWhere((customer) => customer.customerId == customerId);
      if (index != -1) {
        customers[index] = updatedCustomer;
        customers.refresh(); // Memperbarui daftar pelanggan
        Get.snackbar('Sukses', 'Data pelanggan berhasil diperbarui');
      } else {
        throw Exception('Pelanggan dengan ID $customerId tidak ditemukan');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void deleteSale(String noFaktur) {
    salesData.removeWhere((sale) => sale.noFaktur == noFaktur);
    update(); // Memperbarui UI
  }

  void deleteStock(String code) {
    obatStock.removeWhere((medicine) => medicine.code == code);
    update();
  }

  void deleteCustomer(String customerId) {
    customers.removeWhere((customer) => customer.customerId == customerId);
    update();
  }

  void addUser(User user) {
    users.add(user);
    update();
  }

  void updateUser(String userId, User updatedUser) {
    final index = users.indexWhere((user) => user.userId == userId);
    if (index != -1) {
      users[index] = updatedUser;
      users.refresh();
    }
  }

  void deleteUser(String userId) {
    users.removeWhere((user) => user.userId == userId);
    update();
  }

  User? findUserByUsername(String username) {
    return users.firstWhereOrNull((user) => user.username == username);
  }
}
