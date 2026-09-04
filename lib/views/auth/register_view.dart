import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final RegisterController controller = Get.put(RegisterController());

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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

              left: -70,

              child: bubble(const Color(0xff8FA8D8), 230),
            ),

            Positioned(
              bottom: -70,

              right: -50,

              child: bubble(const Color(0xffF3E9C9), 220),
            ),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,

                  vertical: 20,
                ),

                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    // CHECKLIST LOGO
                    Container(
                      height: 90,

                      width: 90,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        shape: BoxShape.circle,

                        border: Border.all(
                          color: const Color(0xff3F8F83),

                          width: 2,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.12),

                            blurRadius: 20,

                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.checklist_rounded,

                        size: 55,

                        color: Color(0xff3F8F83),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "Create Account",

                      style: TextStyle(
                        fontSize: 32,

                        fontWeight: FontWeight.w800,

                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Join Polling Class Community",

                      style: TextStyle(
                        fontSize: 16,

                        color: darkText.withOpacity(.65),
                      ),
                    ),

                    const SizedBox(height: 35),

                    buildField(
                      controller: nameController,

                      hint: "Full Name",

                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 15),

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

                    const SizedBox(height: 15),

                    buildField(
                      controller: confirmPasswordController,

                      hint: "Confirm Password",

                      icon: Icons.verified_user_outlined,

                      obscure: true,
                    ),

                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Text(
                        "Choose your role",

                        style: TextStyle(
                          fontSize: 20,

                          fontWeight: FontWeight.bold,

                          color: darkText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: RoleCard(
                              title: "Instructor",

                              icon: Icons.school_outlined,

                              selected:
                                  controller.selectedRole.value == "instructor",

                              onTap: () {
                                controller.changeRole("instructor");
                              },
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: RoleCard(
                              title: "Student",

                              icon: Icons.person_outline,

                              selected:
                                  controller.selectedRole.value == "student",

                              onTap: () {
                                controller.changeRole("student");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Obx(
                      () => SizedBox(
                        width: double.infinity,

                        height: 60,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),

                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  await controller.register(
                                    name: nameController.text.trim(),

                                    email: emailController.text.trim(),

                                    password: passwordController.text,

                                    confirmPassword:
                                        confirmPasswordController.text,
                                  );
                                },

                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "CREATE ACCOUNT",

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
                  ],
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

        fillColor: Colors.white.withOpacity(.9),

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

class RoleCard extends StatelessWidget {
  final String title;

  final IconData icon;

  final bool selected;

  final VoidCallback onTap;

  const RoleCard({
    super.key,

    required this.title,

    required this.icon,

    required this.selected,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        height: 120,

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff3F8F83)
              : Colors.white.withOpacity(.7),

          borderRadius: BorderRadius.circular(25),

          border: Border.all(
            color: selected ? const Color(0xff3F8F83) : const Color(0xff3F8F83),

            width: 1.5,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              icon,

              size: 35,

              color: selected ? Colors.white : const Color(0xff3F8F83),
            ),

            const SizedBox(height: 12),

            Text(
              title,

              style: TextStyle(
                fontWeight: FontWeight.bold,

                fontSize: 16,

                color: selected ? Colors.white : const Color(0xff183B56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
