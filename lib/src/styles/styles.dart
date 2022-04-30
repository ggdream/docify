import 'package:flex_color_scheme/flex_color_scheme.dart';

class AppTheme {
  static const _scheme = FlexScheme.deepPurple;

  static final light = FlexThemeData.light(
    scheme: _scheme,
    appBarElevation: .4,
  );
  static final dark = FlexThemeData.dark(
    scheme: _scheme,
    appBarElevation: .4,
  );
}
