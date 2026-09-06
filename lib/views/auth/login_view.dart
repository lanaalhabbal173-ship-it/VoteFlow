import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../routes/app_routes.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB8C9E8), Color(0xffEAF1F8)],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,
          ),
        ),

        child: Stack(
          children: [
            Positioned(
              top: -80,

              left: -60,

              child: bubble(const Color(0xff8FA8D8), 220),
            ),

            Positioned(
              bottom: -80,

              right: -50,

              child: bubble(const Color(0xffF3E9C9), 220),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),

                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // APP LOGO
                      Container(
                        height: 110,

                        width: 110,

                        padding: const EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(30),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.12),

                              blurRadius: 20,

                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),

                          child: Image.asset(
                            "assets/images/app_logo.png",

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Welcome Back",

                        style: TextStyle(
                          fontSize: 32,

                          fontWeight: FontWeight.w800,

                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Login to continue your journey",

                        style: TextStyle(
                          fontSize: 16,

                          color: darkText.withValues(alpha: .65),
                        ),
                      ),

                      const SizedBox(height: 35),

                      buildField(
                        controller: emailController,

                        hint: "Email Address",

                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 15),

                      buildField(
                        controller: passwordController,

                        hint: "Password",

                        icon: Icons.lock_outline,

                        obscure: true,
                      ),

                      const SizedBox(height: 30),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,

                          height: 60,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,

                              elevation: 0,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),

                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    controller.login(
                                      email: emailController.text.trim(),

                                      password: passwordController.text,
                                    );
                                  },

                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Login",

                                    style: TextStyle(
                                      color: Colors.white,

                                      fontSize: 18,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },

                        child: Text(
                          "Create New Account",

                          style: TextStyle(
                            color: primary,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool obscure = false,
  }) {
    return TextField(
      controller: controller,

      obscureText: obscure,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: Icon(icon, color: primary),

        filled: true,

        fillColor: Colors.white.withValues(alpha: .9),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),

          borderSide: BorderSide.none,
        ),

        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  Widget bubble(Color color, double size) {
    return Container(
      height: size,

      width: size,

      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
