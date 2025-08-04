import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/controllers/theme_controller.dart';
import 'package:test_diversition/screens/home/home.dart';
import 'package:test_diversition/screens/launcher_screen.dart';
import 'package:test_diversition/screens/login/login_screen.dart';
import 'package:test_diversition/screens/register/register_screen.dart';
import 'package:test_diversition/screens/splash_screen.dart';
import 'package:test_diversition/screens/users/user_form_screen.dart';
import 'package:test_diversition/themes/theme.dart';

void main() {
  Get.put(ThemeController());
  Get.put(AuthController());
  runApp(const MyApp());
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
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/launcher', page: () => const LauncherScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => const RegisterScreen()),
          GetPage(name: '/edit_user', page: () => const UserFormScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
        ],
      ),
    );
  }
}
