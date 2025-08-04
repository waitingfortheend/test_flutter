import 'package:get/get.dart';
import 'package:test_diversition/themes/theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = true.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme,
    );
  }
}
