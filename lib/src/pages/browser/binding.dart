import 'package:get/get.dart';

import 'controller.dart';

class BrowserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BrowserController());
  }
}
