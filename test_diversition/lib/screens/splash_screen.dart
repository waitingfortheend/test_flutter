import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/providers/base_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initProvider();
    _checkLoginStatus();
  }

  void _initProvider() async {
    await ref.read(BaseProvider.languageProvider).load();
    // await ref.read(BaseProvider.fontTypeProvider).load();
  }

  void _checkLoginStatus() async {
    final AuthController authController = Get.find<AuthController>();
    await Future.delayed(Duration.zero);

    authController.isLoggedIn.listen((isLoggedIn) {
      if (isLoggedIn) {
        Get.offAllNamed('/launcher');
      } else {
        Get.offAllNamed('/login');
      }
    });

    if (authController.isLoggedIn.value) {
      Get.offAllNamed('/launcher');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
