import 'package:test_diversition/providers/app_settings/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseProvider {
  static final languageProvider = ChangeNotifierProvider(
    (ref) => LanguageProvider(),
  );
}
