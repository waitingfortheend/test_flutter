import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
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
