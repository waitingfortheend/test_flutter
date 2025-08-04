import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
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
            title: const Text('Logout'),
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
