import 'package:apotek_app/app/modules/home/controllers/master_data_controller.dart';
import 'package:get/get.dart';

class MasterDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterDataController());
  }
}
