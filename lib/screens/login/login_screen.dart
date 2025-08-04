import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/widgets/random_shape_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Stack(
        children: [
          Positioned.fill(
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: RandomShapeAnimation(size: Get.width * 0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  Gap(16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return _authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              bool success = await _authController.login(
                                _usernameController.text,
                                _passwordController.text,
                              );
                              if (success) {
                                Get.offAllNamed('/launcher');
                              }
                            }
                          },
                          child: const Text('Login'),
                        );
                  }),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    child: Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
