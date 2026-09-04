import 'package:get/get.dart';

import '../services/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService authService = AuthService();

  var selectedRole = "student".obs;

  var isLoading = false.obs;

  void changeRole(String role) {
    selectedRole.value = role;

    print("ROLE CHANGED = ${selectedRole.value}");
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.isEmpty) {
      Get.snackbar("Error", "Please enter your name");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Invalid email format");
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;

    try {
      print("START REGISTER");

      final result = await authService.register(
        name: name,

        email: email,

        password: password,

        role: selectedRole.value,
      );

      print("RESULT = $result");

      if (result != null) {
        Get.snackbar("Success", "Account created successfully");

        if (selectedRole.value == "student") {
          print("GO STUDENT");

          Get.offAllNamed("/student");
        }

        if (selectedRole.value == "instructor") {
          print("GO INSTRUCTOR");

          Get.offAllNamed("/instructor");
        }
      } else {
        Get.snackbar("Error", "Registration failed");
      }
    } catch (e) {
      print("ERROR $e");
    }

    // مهم جداً خارج كل شيء
    isLoading.value = false;

    print("LOADING = ${isLoading.value}");
  }
}
