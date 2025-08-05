import 'package:get/get.dart';
import 'package:test_diversition/models/user_model.dart';
import 'package:test_diversition/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var currentUser = Rx<User?>(null);

  Future<bool> register({
    required String username,
    required String password,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImage,
  }) async {
    try {
      isLoading(true);
      final newUser = User(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        profileImage: profileImage,
      );
      await _authService.registerUser(newUser);
      Get.snackbar(
        'Success',
        'Registration successful! Please login.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      isLoading(true);
      final user = await _authService.loginUser(username, password);
      if (user != null) {
        currentUser.value = user;
        isLoggedIn(true);
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Invalid username or password.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid username or password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    isLoggedIn(false);
    currentUser.value = null;
    Get.snackbar(
      'Logged Out',
      'You have been logged out.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
