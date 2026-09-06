import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> scaleAnimation;

  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,

      duration: const Duration(seconds: 2),
    );

    scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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

              child: bubble(const Color(0xff8FA8D8), 230),
            ),

            Positioned(
              bottom: -70,

              right: -50,

              child: bubble(const Color(0xffF3E9C9), 220),
            ),

            Center(
              child: FadeTransition(
                opacity: fadeAnimation,

                child: ScaleTransition(
                  scale: scaleAnimation,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
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
                      const SizedBox(height: 30),

                      const Text(
                        "VoteFlow",

                        style: TextStyle(
                          fontSize: 34,

                          fontWeight: FontWeight.w800,
                          color: Color(0xff183B56),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Real-time Classroom polling ",

                        style: TextStyle(fontSize: 16, color: Colors.black54),
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

  Widget bubble(Color color, double size) {
    return Container(
      height: size,

      width: size,

      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
