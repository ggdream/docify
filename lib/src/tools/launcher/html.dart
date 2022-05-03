// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

Future<void> launch(String url) async => js.context.callMethod(
      'open',
      [url, '_blank'],
    );
