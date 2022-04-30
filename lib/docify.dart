library docify;

import 'dart:convert';

import 'package:crypto/crypto.dart' show md5;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' show extension, joinAll;
import 'package:yaml/yaml.dart' show loadYaml;

import 'package:docify/src/global/global.dart';
import 'package:docify/src/router/router.dart';
import 'package:docify/src/styles/styles.dart';
import 'package:docify/src/pages/home/model.dart';

class Docify {
  Docify({
    this.root = 'assets/docify',
  });

  final String root;

  Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();

    Global.root = root;

    final data = await rootBundle.loadString(joinAll([root, 'docify.yaml']));
    final Map doc = json.decode(json.encode(loadYaml(data)));
    Global.name = doc['name'] ?? 'Docify';
    Global.icon = doc['icon'] ?? 'logo.png';
    Global.declare = doc['declare'] ?? '';

    final List? center = doc['center'];
      final List<CenterItemModel> temp = [];
    if (center != null) {
      for (Map item in center) {
        final model = CenterItemModel(
          title: item['title'],
          image: item['image'],
          content: item['content'],
        );
        temp.add(model);
      }
    }

    final Map? router = doc['router'];
    if (router == null) return;
    if (router['mode'] == 'hash') {
      setUrlStrategy(const HashUrlStrategy());
    } else {
      setUrlStrategy(PathUrlStrategy());
    }
    final List? routes = router['routes'];
    if (routes == null) return;

    final List<TopNavItemModel> result = [];
    final Map<String, String> routesMap = {};
    for (var route in routes) {
      final model = _parseRoute(route, routesMap);
      result.add(model);
    }

    await AppRouter.initialize(
      cens: temp,
      docs: result,
      docsMap: routesMap,
    );
  }

  TopNavItemModel _parseRoute(Map route, Map routesMap) {
    final path = route['path'];
    String? hash;
    if (path != null && extension(path).endsWith('.md')) {
      hash = md5.convert(utf8.encode(path)).toString();
      routesMap.addIf(!routesMap.containsKey(hash), hash, path);
    }

    List<TopNavItemModel>? children;
    final cData = route['children'];
    if (cData != null) {
      children = [];
      for (var data in cData) {
        children.add(_parseRoute(data, routesMap));
      }
    }

    return TopNavItemModel(
      name: route['name'],
      path: path,
      hash: hash,
      children: children,
    );
  }

  Future<void> run() async {
    await _init();
    runApp(const DocifyView());
  }
}

class DocifyView extends StatelessWidget {
  const DocifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Global.name,
      scrollBehavior: _CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.init,
      getPages: AppRouter.routes,
      defaultTransition: Transition.cupertino,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}

class _CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
