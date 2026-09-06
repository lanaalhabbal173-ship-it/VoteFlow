import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:polling_app/views/widget/instructor/option_input_card.dart';
import 'package:polling_app/views/widget/instructor/poll_text_field.dart';

import '../../controllers/poll_conroller.dart';

class CreatePollView extends StatefulWidget {
  const CreatePollView({super.key});

  @override
  State<CreatePollView> createState() => _CreatePollViewState();
}

class _CreatePollViewState extends State<CreatePollView> {
  final PollController controller = Get.put(PollController());

  final TextEditingController questionController = TextEditingController();

  List<TextEditingController> optionControllers = [
    TextEditingController(),

    TextEditingController(),
  ];

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  void addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  void removeOption(int index) {
    if (optionControllers.length <= 2) {
      Get.snackbar(
        "Warning",

        "Poll needs at least 2 options",

        backgroundColor: Colors.white,
      );

      return;
    }

    setState(() {
      optionControllers[index].dispose();

      optionControllers.removeAt(index);
    });
  }

  void createPoll() {
    List<String> options = optionControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    controller.createPoll(
      question: questionController.text.trim(),

      options: options,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF5F8FC), Color(0xffE8F3F1)],

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
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

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),

                              blurRadius: 15,
                            ),
                          ],
                        ),

                        child: Icon(
                          Icons.arrow_back_ios_new,

                          size: 20,

                          color: darkText,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Text(
                      "Create Poll",

                      style: TextStyle(
                        color: darkText,

                        fontSize: 28,

                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // HERO CARD
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primary, const Color(0xff69B3A8)],
                    ),

                    borderRadius: BorderRadius.circular(32),

                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(.25),

                        blurRadius: 20,

                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              "Create Interactive Poll",

                              style: TextStyle(
                                color: Colors.white,

                                fontSize: 23,

                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              "Ask questions and engage your students instantly",

                              style: TextStyle(
                                color: Colors.white70,

                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 60,

                        width: 60,

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Icon(
                          Icons.poll_rounded,

                          color: primary,

                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // QUESTION CARD
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),

                        blurRadius: 20,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,

                            width: 40,

                            decoration: BoxDecoration(
                              color: primary.withOpacity(.12),

                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Icon(
                              Icons.help_outline_rounded,

                              color: primary,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            "Your Question",

                            style: TextStyle(
                              color: darkText,

                              fontSize: 20,

                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      PollTextField(
                        controller: questionController,

                        hint: "Enter your question",

                        icon: Icons.edit_rounded,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // OPTIONS TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "Answer Options",

                      style: TextStyle(
                        color: darkText,

                        fontSize: 22,

                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,

                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: primary.withOpacity(.12),

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        "${optionControllers.length} Options",

                        style: TextStyle(
                          color: primary,

                          fontSize: 12,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // OPTIONS
                ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: optionControllers.length,

                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(25),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.04),

                            blurRadius: 15,

                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          Container(
                            height: 55,

                            width: 55,

                            margin: const EdgeInsets.only(left: 12),

                            decoration: BoxDecoration(
                              color: primary.withOpacity(.12),

                              borderRadius: BorderRadius.circular(18),
                            ),

                            child: Center(
                              child: Text(
                                "${index + 1}",

                                style: TextStyle(
                                  color: primary,

                                  fontSize: 20,

                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: OptionInputCard(
                              controller: optionControllers[index],

                              hint: "Option ${index + 1}",

                              onDelete: () {
                                removeOption(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 5),

                // ADD OPTION
                GestureDetector(
                  onTap: addOption,

                  child: Container(
                    height: 55,

                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: primary.withOpacity(.08),

                      borderRadius: BorderRadius.circular(20),

                      border: Border.all(color: primary.withOpacity(.4)),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, color: primary),

                        const SizedBox(width: 8),

                        Text(
                          "Add Another Option",

                          style: TextStyle(
                            color: primary,

                            fontWeight: FontWeight.bold,

                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // CREATE BUTTON
                Obx(
                  () => SizedBox(
                    width: double.infinity,

                    height: 62,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,

                        elevation: 8,

                        shadowColor: primary.withOpacity(.3),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),

                      onPressed: controller.isLoading.value ? null : createPoll,

                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.rocket_launch_rounded,

                                  color: Colors.white,
                                ),

                                SizedBox(width: 10),

                                Text(
                                  "GENERATE POLL CODE",

                                  style: TextStyle(
                                    color: Colors.white,

                                    fontSize: 17,

                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    questionController.dispose();

    for (var c in optionControllers) {
      c.dispose();
    }

    super.dispose();
  }
}
