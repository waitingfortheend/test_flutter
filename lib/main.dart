import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/controllers/theme_controller.dart';
import 'package:test_diversition/enum/headings.dart';
import 'package:test_diversition/enum/locale_type.enum.dart';
import 'package:test_diversition/generated/locales.g.dart';
import 'package:test_diversition/models/app_setting_model.dart';
import 'package:test_diversition/providers/app_settings/language_provider.dart';
import 'package:test_diversition/screens/home/home.dart';
import 'package:test_diversition/screens/launcher_screen.dart';
import 'package:test_diversition/screens/login/login_screen.dart';
import 'package:test_diversition/screens/register/register_screen.dart';
import 'package:test_diversition/screens/splash_screen.dart';
import 'package:test_diversition/screens/users/user_form_screen.dart';
import 'package:test_diversition/themes/theme.dart';
import 'package:test_diversition/utility/app_local_storage_until.dart';

void main() async {
  appInit();

  runApp(ProviderScope(child: MyApp()));
}

appInit() async {
  Get.put(ThemeController());
  Get.put(AuthController());

  await setupFontAndLang();

  var appSetting = AppSettingModel(FontType.normal, LocaleType.th);
  final dAppSetting = await LocalStorage.getLocalStorage(
    key: AppSettingModel.jsonName,
  );
  if (dAppSetting != null) {
    appSetting = AppSettingModel.fromJson(dAppSetting);
  }

  var langProvi = LanguageProvider();
  Get.updateLocale(
    langProvi.listLocale[appSetting.language] ?? const Locale('th', 'TH'),
  );
}

setupFontAndLang() async {
  var appSetting = AppSettingModel(FontType.normal, LocaleType.th);
  final tempAppSetting = await LocalStorage.getLocalStorage(
    key: AppSettingModel.jsonName,
  );
  if (tempAppSetting != null) {
    appSetting = AppSettingModel.fromJson(tempAppSetting);
  }
  var langProvider = LanguageProvider();

  Get.updateLocale(
    langProvider.listLocale[appSetting.language] ?? const Locale('th', 'TH'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        translationsKeys: AppTranslation.translations,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/splash',
        locale: Get.locale,
        localizationsDelegates: const [DefaultWidgetsLocalizations.delegate],
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/launcher', page: () => const LauncherScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => const RegisterScreen()),
          GetPage(name: '/edit_user', page: () => const UserFormScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          // GetPage(name: '/language', page: () => const ChangeLanguageScreen()),
        ],
      ),
    );
  }
}
