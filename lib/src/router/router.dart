import 'package:get/get.dart';
import 'package:path/path.dart' show joinAll;

import 'package:docify/src/global/global.dart';
import 'package:docify/src/pages/browser/browser.dart';
import 'package:docify/src/pages/home/home.dart';

class AppRouter {
  static const init = home;

  static const home = '/';
  static const view = '/view';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: view + '/:id',
      page: () => const BrowserPage(),
      binding: BrowserBinding(),
    ),
  ];

  static late final List<CenterItemModel> cenx;
  static late final List<TopNavItemModel> docx;
  static late final Map<String, String> _docsMap;

  static Future<void> initialize({
    required List<CenterItemModel> cens,
    required List<TopNavItemModel> docs,
    required Map<String, String> docsMap,
  }) async {
    cenx = cens;
    docx = docs;
    _docsMap = docsMap;
  }

  static String? doc(String id) => _docsMap[id] == null
      ? null
      : joinAll([Global.root, 'docs', _docsMap[id]!]);
}
