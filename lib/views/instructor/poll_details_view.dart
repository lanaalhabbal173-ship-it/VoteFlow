import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/poll_conroller.dart';

class PollDetailsView extends StatelessWidget {
  PollDetailsView({super.key});

  final PollController controller = Get.find<PollController>();

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB8C9E8), Color(0xffEAF1F8)],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Obx(() {
            final poll = controller.createdPoll.value;

            if (poll == null) {
              return const Center(child: Text("No Poll Found"));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // HEADER
                  Row(
                    children: [
                      GestureDetector(
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

                      const SizedBox(width: 15),

                      Text(
                        controller.isWaiting
                            ? "Waiting Poll"
                            : controller.isActive
                            ? "Live Poll"
                            : controller.isEnded
                            ? "Poll Finished"
                            : "Results Published",

                        style: TextStyle(
                          color: darkText,

                          fontSize: 28,

                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // CODE CARD
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primary, const Color(0xff69B3A8)],
                      ),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Column(
                      children: [
                        const Text(
                          "POLL CODE",

                          style: TextStyle(
                            color: Colors.white70,

                            letterSpacing: 2,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          poll.code,

                          style: const TextStyle(
                            color: Colors.white,

                            fontSize: 40,

                            fontWeight: FontWeight.w900,

                            letterSpacing: 8,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: poll.code));

                            Get.snackbar("Copied", "Code copied");
                          },

                          icon: const Icon(Icons.copy, color: Colors.white),
                        ),

                        ElevatedButton.icon(
                          onPressed: () {
                            Share.share("Join Poll Code: ${poll.code}");
                          },

                          icon: const Icon(Icons.share),

                          label: const Text("SHARE CODE"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

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
                        const Text("Question"),

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

                  const SizedBox(height: 25),

                  // RESULTS ONLY AFTER VOTES
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
                        Text(
                          "Live Results",

                          style: TextStyle(
                            color: darkText,

                            fontSize: 22,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        ...poll.options.map((option) {
                          double percent = controller.getPercentage(option);

                          int votes =
                              int.tryParse(poll.votes[option].toString()) ?? 0;

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(option),

                                  Text(
                                    "${(percent * 100).toStringAsFixed(0)}%",
                                  ),
                                ],
                              ),

                              LinearPercentIndicator(
                                padding: EdgeInsets.zero,

                                lineHeight: 12,

                                percent: percent,

                                progressColor: primary,
                              ),

                              Text("$votes votes"),

                              const SizedBox(height: 15),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // BUTTONS CONTROL
                  if (controller.isWaiting)
                    actionButton("START POLL", primary, () {
                      controller.startPoll(poll.pollId);
                    })
                  else if (controller.isActive)
                    actionButton("END POLL", Colors.red, () {
                      controller.endPoll(poll.pollId);
                    })
                  else if (controller.isEnded)
                    actionButton("SHOW RESULTS TO STUDENTS", primary, () {
                      controller.showResults(poll.pollId);
                    }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget actionButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,

      height: 60,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        onPressed: onTap,

        child: Text(
          text,

          style: const TextStyle(
            color: Colors.white,

            fontSize: 17,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
