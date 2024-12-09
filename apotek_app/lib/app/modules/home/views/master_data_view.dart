import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';
import 'package:apotek_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterDataView extends StatelessWidget {
  final controller = Get.put(MasterDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Master Data")),
      body: Obx(() {
        // Memastikan controller sudah memiliki data obat
        if (controller.obatStock.isEmpty) {
          return Center(child: Text("Tidak ada data obat"));
        }
        return ListView.builder(
          itemCount: controller.obatStock.length,
          itemBuilder: (context, index) {
            var obat = controller.obatStock[index];  // Mengambil data obat
            return ListTile(
              title: Text(obat.name),
              subtitle: Text('Stock: ${obat.stock} | Harga: ${obat.salePrice}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol Edit
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigasi ke halaman EditObatView dengan mengirimkan objek obat
                      Get.toNamed(
                        AppRoutes.editObat,
                        arguments: obat,  // Mengirimkan objek Obat ke halaman EditObat
                      );
                    },
                  ),
                  // Tombol Delete (jika dibutuhkan)
                  // IconButton(
                  //     icon: Icon(Icons.delete),
                  //     onPressed: () => controller.deleteObat(index)),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman AddObatView
          Get.toNamed(AppRoutes.addObat);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
