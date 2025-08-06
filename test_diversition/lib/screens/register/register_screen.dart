import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_diversition/controllers/auth_controller.dart';
import 'package:test_diversition/generated/locales.g.dart';
import 'package:test_diversition/models/user_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = Get.find<AuthController>();

  final PageController _pageController = PageController();
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();
  bool validStep1 = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _profileImageController = TextEditingController();

  final _phoneNumberFormatter = MaskTextInputFormatter(
    mask: '###-###-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final RxBool _isSubmitting = false.obs;

  final RxBool _hasMinLength = false.obs;
  final RxBool _hasUppercase = false.obs;
  final RxBool _hasLowercase = false.obs;
  final RxBool _hasSpecialCharacter = false.obs;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _profileImageController.text = "https://picsum.photos/200";
  }

  @override
  void dispose() {
    _pageController.dispose();
    _usernameController.dispose();
    _passwordController.removeListener(_validatePassword);
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _profileImageController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;
    _hasMinLength.value = password.length >= 8;
    _hasUppercase.value = password.contains(RegExp(r'[A-Z]'));
    _hasLowercase.value = password.contains(RegExp(r'[a-z]'));
    _hasSpecialCharacter.value = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );
  }

  Future<void> _handleSubmit() async {
    if (!validStep1) {
      // Get.snackbar(
      //   'Error',
      //   'Please complete Step 1 correctly!',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      return;
    }
    if (!_formKeyStep2.currentState!.validate()) {
      // Get.snackbar(
      //   'Error',
      //   'Please complete Step 2 correctly!',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      return;
    }

    bool isPasswordValid =
        _hasMinLength.value &&
        _hasUppercase.value &&
        _hasLowercase.value &&
        _hasSpecialCharacter.value;

    if (!isPasswordValid) {
      Get.snackbar(
        'Error',
        'Password does not meet all requirements.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isSubmitting.value = true;
    try {
      final newUser = User(
        username: _usernameController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberFormatter.unmaskText(
          _phoneNumberController.text,
        ),
        profileImage: _profileImageController.text,
      );
      await _authController.register(
        username: newUser.username!,
        password: newUser.password!,
        firstName: newUser.firstName,
        lastName: newUser.lastName,
        email: newUser.email,
        phoneNumber: newUser.phoneNumber,
        profileImage: newUser.profileImage,
      );
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSubmitting.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.register.tr)),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKeyStep1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.username_hint.tr,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              validStep1 = false;
                              return 'Please enter a username';
                            }
                            if (value.length < 5) {
                              return 'Username must be at least 5 characters long.';
                            }
                            if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                              return 'Username can only contain English letters and numbers.';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        TextFormField(
                          controller: _passwordController,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.password_hint.tr,
                          ),
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            bool isValid =
                                _hasMinLength.value &&
                                _hasUppercase.value &&
                                _hasLowercase.value &&
                                _hasSpecialCharacter.value;
                            if (!isValid) {
                              return 'Password does not meet requirements below.';
                            }
                            return null;
                          },
                        ),
                        const Gap(10),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildValidationRow(
                                LocaleKeys.at_least_8.tr,
                                _hasMinLength.value,
                              ),
                              const Gap(16),
                              _buildValidationRow(
                                LocaleKeys.upperAZ.tr,
                                _hasUppercase.value,
                              ),
                              const Gap(16),
                              _buildValidationRow(
                                LocaleKeys.lowerAZ.tr,
                                _hasLowercase.value,
                              ),
                              const Gap(16),
                              _buildValidationRow(
                                LocaleKeys.contain_special.tr,
                                _hasSpecialCharacter.value,
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKeyStep1.currentState != null &&
                                _formKeyStep1.currentState!.validate()) {
                              validStep1 = true;
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          child: Text(LocaleKeys.next.tr),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKeyStep2,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.user_first_name.tr,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.user_last_name.tr,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.user_Email.tr,
                            hintText: 'Enter Email ###@email.com',
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a pattern email';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        TextFormField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.user_phone_number.tr,
                            hintText: 'Enter Phone Number (###-###-####)',
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [_phoneNumberFormatter],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            if (_phoneNumberFormatter.unmaskText(value).length <
                                10) {
                              return 'Phone number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        TextFormField(
                          controller: _profileImageController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.user_profile_img.tr,
                          ),
                          keyboardType: TextInputType.url,
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Text(LocaleKeys.back.tr),
                            ),
                            Obx(() {
                              return _isSubmitting.value
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                    onPressed: _handleSubmit,
                                    child: Text(LocaleKeys.register.tr),
                                  );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 16,
        ),
        const Gap(8),
        Expanded(
          child: Text(
            text,
            softWrap: true,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.red,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
