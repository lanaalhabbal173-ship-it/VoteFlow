import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();

  var isLoading = false.obs;

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final user = await authService.login(email: email, password: password);

      if (user == null) {
        Get.snackbar("Error", "Invalid email or password");

        return;
      }

      if (user.role == "instructor") {
        Get.offAllNamed(AppRoutes.instructor);
      } else {
        Get.offAllNamed(AppRoutes.student);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
