import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import 'controller.dart';

class BrowserPage extends GetView<BrowserController> {
  const BrowserPage({
    Key? key,
    this.appBar,
    this.child,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Stack(
      children: [
        if (child != null) child!,
        controller.obx(
          (data) {
            return Markdown(
              data: data ?? '',
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
            );
          },
          onLoading: const Center(child: RefreshProgressIndicator()),
        ),
      ],
    );
  }
}
