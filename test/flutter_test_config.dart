import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the bundled display font so golden images show real Latin glyphs.
/// Other text falls back to the test font, which keeps goldens stable across
/// machines.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final loader = FontLoader('DMSerifDisplay')
    ..addFont(rootBundle.load('assets/fonts/DMSerifDisplay-Regular.ttf'));
  await loader.load();
  await testMain();
}
