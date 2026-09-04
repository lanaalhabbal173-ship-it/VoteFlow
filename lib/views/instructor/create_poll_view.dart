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
      Get.snackbar("Warning", "Poll needs at least 2 options");

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

    controller.createPoll(question: questionController.text, options: options);
  }

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
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

                        child: Icon(
                          Icons.arrow_back_ios_new,

                          color: primary,

                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Text(
                      "Create Poll",

                      style: TextStyle(
                        color: darkText,

                        fontSize: 28,

                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Container(
                  height: 90,

                  width: 90,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    shape: BoxShape.circle,
                    border: Border.all(color: primary, width: 2),
                  ),

                  child: Icon(
                    Icons.checklist_rounded,

                    size: 55,

                    color: primary,
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  "Create Interactive Poll",

                  style: TextStyle(
                    color: darkText,

                    fontSize: 30,

                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Ask your students and collect responses",

                  textAlign: TextAlign.center,

                  style: TextStyle(color: darkText.withOpacity(.6)),
                ),

                const SizedBox(height: 35),

                PollTextField(
                  controller: questionController,

                  hint: "Enter your question",

                  icon: Icons.help_outline_rounded,
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Answer Options",

                    style: TextStyle(
                      color: darkText,

                      fontSize: 22,

                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: optionControllers.length,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),

                      child: OptionInputCard(
                        controller: optionControllers[index],

                        hint: "Option ${index + 1}",

                        onDelete: () {
                          removeOption(index);
                        },
                      ),
                    );
                  },
                ),

                OutlinedButton.icon(
                  onPressed: addOption,

                  icon: Icon(Icons.add, color: primary),

                  label: Text("Add Option", style: TextStyle(color: primary)),
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

                      onPressed: controller.isLoading.value ? null : createPoll,

                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "GENERATE POLL CODE",

                              style: TextStyle(
                                color: Colors.white,

                                fontSize: 17,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
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
