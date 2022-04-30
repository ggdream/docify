import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:docify/src/router/router.dart';

class BrowserController extends GetxController with StateMixin<String> {
  final String? id = Get.parameters['id'];

  @override
  void onInit() {
    super.onInit();
    _net();
  }

  Future<void> _net() async {
    change(null, status: RxStatus.loading());
    if (id == null) {
      Get.offAllNamed(AppRouter.home);
      return;
    }

    final path = AppRouter.doc(id!);
    if (path == null) {
      change(null, status: RxStatus.empty());
      return;
    }

    try {
      final data = await rootBundle.loadString(path);
      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
