import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/models/user_model.dart';
import 'package:test_diversition/services/user_service.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final UserService _userService = UserService();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _profileImageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  User? userToEdit;
  final RxBool _isSubmitting = false.obs;

  @override
  void initState() {
    super.initState();
    userToEdit = Get.arguments as User;
    _fillFormWithUserData();
  }

  void _fillFormWithUserData() {
    if (userToEdit != null) {
      _firstNameController.text = userToEdit!.firstName ?? '';
      _lastNameController.text = userToEdit!.lastName ?? '';
      _emailController.text = userToEdit!.email ?? '';
      _phoneNumberController.text = userToEdit!.phoneNumber ?? '';
      _profileImageController.text = userToEdit!.profileImage ?? '';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _profileImageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _isSubmitting.value = true;
      try {
        final updatedUser = User(
          userId: userToEdit!.userId,
          createdAt: userToEdit!.createdAt,
          username: userToEdit!.username,
          password: userToEdit!.password,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneNumberController.text,
          email: _emailController.text,
          profileImage: _profileImageController.text,
        );
        await _userService.updateUser(userToEdit!.userId!, updatedUser);
        Get.back();
        Get.snackbar(
          'Success',
          'User updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Operation failed: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        _isSubmitting.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _profileImageController,
                  decoration: const InputDecoration(
                    labelText: 'Profile Image URL (Optional)',
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return _isSubmitting.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: _handleSubmit,
                        child: const Text('Update User'),
                      );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
