import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/student_poll_controller.dart';

class JoinPollView extends StatefulWidget {
  const JoinPollView({super.key});

  @override
  State<JoinPollView> createState() => _JoinPollViewState();
}

class _JoinPollViewState extends State<JoinPollView> {
  final StudentPollController controller = Get.put(StudentPollController());

  final TextEditingController codeController = TextEditingController();

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
          child: Stack(
            children: [
              Positioned(
                top: -70,

                left: -60,

                child: bubble(const Color(0xff8FA8D8), 220),
              ),

              Positioned(
                bottom: -70,

                right: -50,

                child: bubble(const Color(0xffF3E9C9), 220),
              ),

              SingleChildScrollView(
                padding: const EdgeInsets.all(25),

                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,

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

                          child: Icon(
                            Icons.arrow_back_ios_new,

                            size: 20,

                            color: primary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

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
                      "Join Poll",

                      style: TextStyle(
                        fontSize: 32,

                        fontWeight: FontWeight.w800,

                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      "Enter the code shared by your instructor",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: darkText.withOpacity(.65),

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 35),

                    Container(
                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),

                        borderRadius: BorderRadius.circular(35),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),

                            blurRadius: 20,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          const Text(
                            "Poll Code",

                            style: TextStyle(
                              fontSize: 18,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextField(
                            controller: codeController,

                            keyboardType: TextInputType.number,

                            maxLength: 6,

                            textAlign: TextAlign.center,

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],

                            style: TextStyle(
                              fontSize: 30,

                              letterSpacing: 12,

                              fontWeight: FontWeight.bold,

                              color: darkText,
                            ),

                            decoration: InputDecoration(
                              counterText: "",

                              hintText: "000000",

                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,

                                letterSpacing: 12,
                              ),

                              filled: true,

                              fillColor: const Color(0xffF5F8FC),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),

                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,

                            height: 60,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),

                                elevation: 0,
                              ),

                              onPressed: () {
                                if (codeController.text.length != 6) {
                                  Get.snackbar(
                                    "Invalid Code",

                                    "Please enter a 6 digit poll code",

                                    backgroundColor: Colors.red.shade100,

                                    colorText: Colors.red.shade900,
                                  );

                                  return;
                                }

                                controller.joinPoll(codeController.text);
                              },

                              child: const Text(
                                "JOIN POLL",

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
                  ],
                ),
              ),
            ],
          ),
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
