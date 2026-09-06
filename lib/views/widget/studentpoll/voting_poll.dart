import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/student_poll_controller.dart';

class VotingPoll extends StatelessWidget {
  VotingPoll({super.key});

  final StudentPollController controller = Get.find<StudentPollController>();

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  @override
  Widget build(BuildContext context) {
    final poll = controller.currentPoll.value!;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffB8C9E8), Color(0xffEAF1F8)],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offNamed("/student");
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

                  const SizedBox(width: 15),

                  Text(
                    "Live Poll",

                    style: TextStyle(
                      color: darkText,

                      fontSize: 28,

                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // QUESTION
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Question",

                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      poll.question,

                      style: TextStyle(
                        color: darkText,

                        fontSize: 21,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Choose your answer",

                style: TextStyle(
                  color: darkText,

                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 15),

              ...poll.options.map((option) {
                return Obx(() {
                  bool selected = controller.selectedAnswer.value == option;

                  return GestureDetector(
                    onTap: () {
                      controller.selectedAnswer.value = option;
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),

                      margin: const EdgeInsets.only(bottom: 15),

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: selected ? primary : Colors.white,

                        borderRadius: BorderRadius.circular(22),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            selected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,

                            color: selected ? Colors.white : primary,
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Text(
                              option,

                              style: TextStyle(
                                color: selected ? Colors.white : darkText,

                                fontWeight: FontWeight.bold,

                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,

                height: 60,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),

                  onPressed: () {
                    controller.submitVote();
                  },

                  child: const Text(
                    "SUBMIT ANSWER",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
