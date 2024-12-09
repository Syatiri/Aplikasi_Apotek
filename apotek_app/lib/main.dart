import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apotek_app/app/routes/app_pages.dart';
import 'package:apotek_app/app/routes/app_routes.dart';

void main() {
  Get.put(MasterDataController()); 
  runApp(
    GetMaterialApp(
      title: 'Apotek App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages, 
    ),
  );
}
