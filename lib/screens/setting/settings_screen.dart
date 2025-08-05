import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/controllers/theme_controller.dart';
import 'package:test_diversition/generated/locales.g.dart';
import 'package:test_diversition/screens/setting/change_language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.setting_title.tr)),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: Text(LocaleKeys.dark_mode.tr),
              secondary: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              value: themeController.isDarkMode.value,
              onChanged: (bool value) {
                themeController.toggleTheme();
              },
            ),
          ),
          ListTile(
            title: Text(LocaleKeys.change_language.tr),
            leading: const Icon(Icons.language),
            onTap: () {
              Get.to(ChangeLanguageScreen());
            },
          ),
          ListTile(
            title: Text(LocaleKeys.logout.tr),
            leading: const Icon(Icons.logout),
            onTap: () {
              authController.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
