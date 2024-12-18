import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart'
    as controllers;
import 'package:apotek_app/app/modules/home/views/register_view.dart';
import 'package:apotek_app/app/modules/home/views/transaksi_view.dart';
import 'package:get/get.dart';
import 'package:apotek_app/app/routes/app_routes.dart';
import '../modules/splash_screen/view/splash_screen.dart';
import '../modules/home/views/login_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/dashboard_view.dart';
import '../modules/home/views/add_obat_view.dart';
import '../modules/home/views/edit_obat_view.dart';
import '../modules/home/bindings/master_data_binding.dart';

class AppPages {
  static final pages = [
    // Halaman Splash Screen
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    // Halaman Login
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
    ),
    // Halaman Home
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        // Gunakan alias untuk MasterDataController
        Get.lazyPut(() => controllers.MasterDataController());
      }),
    ),
    // Halaman utama Master Data (Dashboard)
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: MasterDataBinding(),
    ),
    // Halaman untuk menambah Obat
    GetPage(
      name: AppRoutes.addObat,
      page: () => AddObatView(),
      binding: MasterDataBinding(),
    ),
    // Halaman untuk mengedit Obat
    GetPage(
      name: AppRoutes.editObat,
      page: () => const EditObatView(),
      binding: MasterDataBinding(),
    ),
    GetPage(
      name: AppRoutes.transaksi,
      page: () => TransactionForm(),
      binding: MasterDataBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: MasterDataBinding(),
    ),
  ];
}
