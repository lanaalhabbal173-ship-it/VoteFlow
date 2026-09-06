import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/student_poll_controller.dart';

class WaitingPoll extends StatelessWidget {
  WaitingPoll({super.key});

  final StudentPollController controller = Get.find<StudentPollController>();

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffB8C9E8), Color(0xffEAF1F8)],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,
        ),
      ),

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,

                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },

                  child: Container(
                    height: 45,

                    width: 45,

                    decoration: const BoxDecoration(
                      color: Colors.white,

                      shape: BoxShape.circle,
                    ),

                    child: Icon(Icons.arrow_back_ios_new, color: primary),
                  ),
                ),
              ),

              const Spacer(),

              Container(
                height: 120,

                width: 120,

                decoration: BoxDecoration(
                  color: Colors.white,

                  shape: BoxShape.circle,

                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                ),

                child: Icon(
                  Icons.hourglass_top_rounded,

                  size: 65,

                  color: primary,
                ),
              ),

              const SizedBox(height: 35),

              Text(
                "Waiting for instructor",

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: darkText,

                  fontSize: 28,

                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "The poll has not started yet.\nPlease wait until your instructor starts it.",

                textAlign: TextAlign.center,

                style: TextStyle(color: darkText.withOpacity(.6), fontSize: 16),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(25),
                ),

                child: Column(
                  children: [
                    Text(
                      "Poll Code",

                      style: TextStyle(color: darkText.withOpacity(.6)),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      controller.currentPoll.value!.code,

                      style: TextStyle(
                        color: primary,

                        fontSize: 32,

                        fontWeight: FontWeight.w900,

                        letterSpacing: 6,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
