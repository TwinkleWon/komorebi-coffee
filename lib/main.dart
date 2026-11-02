import 'bootstrap.dart';
import 'core/config/app_config.dart';

/// Default entrypoint for `flutter run` without `-t`; uses the dev flavor.
void main() => bootstrap(AppConfig.dev);
