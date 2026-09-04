import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:polling_app/controllers/poll_conroller.dart';

import '../../routes/app_routes.dart';

class InstructorView extends StatefulWidget {
  const InstructorView({super.key});

  @override
  State<InstructorView> createState() => _InstructorViewState();
}

class _InstructorViewState extends State<InstructorView> {
  final PollController controller = Get.put(PollController());

  String instructorName = "Instructor";

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  @override
  void initState() {
    super.initState();

    controller.getInstructorPolls();

    getInstructorName();
  }

  Future<void> getInstructorName() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DatabaseEvent event = await FirebaseDatabase.instance
          .ref("users/$uid")
          .once();

      if (event.snapshot.value != null) {
        Map data = Map<String, dynamic>.from(event.snapshot.value as Map);

        setState(() {
          instructorName = data["name"] ?? "Instructor";
        });
      }
    } catch (e) {
      print("GET INSTRUCTOR NAME ERROR = $e");
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),

                    borderRadius: BorderRadius.circular(35),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),

                        blurRadius: 20,

                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          GestureDetector(
                            onTap: () {
                              showLogoutDialog();
                            },

                            child: Container(
                              height: 45,

                              width: 45,

                              decoration: const BoxDecoration(
                                color: Color(0xffEAF1F8),

                                shape: BoxShape.circle,
                              ),

                              child: Icon(Icons.logout_rounded, color: primary),
                            ),
                          ),

                          Container(
                            height: 65,

                            width: 65,

                            decoration: BoxDecoration(
                              color: primary,

                              shape: BoxShape.circle,
                            ),

                            child: Center(
                              child: Text(
                                instructorName.isNotEmpty
                                    ? instructorName[0].toUpperCase()
                                    : "I",

                                style: const TextStyle(
                                  color: Colors.white,

                                  fontSize: 28,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Welcome Back 👋",

                        style: TextStyle(
                          color: darkText.withOpacity(.6),

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        instructorName,

                        style: TextStyle(
                          color: darkText,

                          fontSize: 30,

                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Create engaging polls for your students",

                        style: TextStyle(color: darkText.withOpacity(.65)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // CREATE POLL CARD
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.createPoll);
                  },

                  child: Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primary, const Color(0xff69B3A8)],
                      ),

                      borderRadius: BorderRadius.circular(35),

                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(.25),

                          blurRadius: 20,

                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Create New Poll",

                              style: TextStyle(
                                color: Colors.white,

                                fontSize: 25,

                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Engage your students instantly",

                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),

                        Container(
                          height: 60,

                          width: 60,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Icon(
                            Icons.add_rounded,

                            size: 35,

                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Text(
                  "My Polls",

                  style: TextStyle(
                    fontSize: 25,

                    fontWeight: FontWeight.w800,

                    color: darkText,
                  ),
                ),

                const SizedBox(height: 15),

                Obx(() {
                  if (controller.instructorPolls.isEmpty) {
                    return Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(25),
                      ),

                      child: const Center(child: Text("No polls yet")),
                    );
                  }

                  return Column(
                    children: controller.instructorPolls.map((poll) {
                      Color statusColor;

                      if (poll.status == "waiting") {
                        statusColor = Colors.orange;
                      } else if (poll.status == "active") {
                        statusColor = Colors.green;
                      } else if (poll.status == "ended") {
                        statusColor = Colors.red;
                      } else {
                        statusColor = Colors.blue;
                      }

                      return GestureDetector(
                        onTap: () {
                          controller.openPoll(poll);
                        },

                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),

                          padding: const EdgeInsets.all(22),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(30),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.05),

                                blurRadius: 15,

                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,

                                      vertical: 6,
                                    ),

                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(.15),

                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Text(
                                      poll.status.toUpperCase(),

                                      style: TextStyle(
                                        color: statusColor,

                                        fontWeight: FontWeight.bold,

                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    poll.code,

                                    style: TextStyle(
                                      color: primary,

                                      fontSize: 18,

                                      fontWeight: FontWeight.bold,

                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              Text(
                                poll.question,

                                maxLines: 2,

                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: darkText,

                                  fontSize: 18,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Row(
                                children: [
                                  Icon(
                                    Icons.people_alt_rounded,

                                    color: primary,

                                    size: 20,
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    "${poll.participants} Students",

                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLogoutDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,

        child: Container(
          padding: const EdgeInsets.all(25),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(30),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.10),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                height: 72,
                width: 72,

                decoration: const BoxDecoration(
                  color: Color(0xffEAF1F8),

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.logout_rounded,

                  color: Color(0xff3F8F83),

                  size: 38,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Logout?",

                style: TextStyle(
                  fontSize: 24,

                  fontWeight: FontWeight.w800,

                  color: Color(0xff183B56),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Are you sure you want to logout\nfrom your account?",

                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xff3F8F83)),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),

                      onPressed: () {
                        Get.back();
                      },

                      child: const Text(
                        "Cancel",

                        style: TextStyle(
                          color: Color(0xff183B56),

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3F8F83),

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),

                      onPressed: () {
                        Get.offAllNamed(AppRoutes.login);
                      },

                      child: const Text(
                        "Logout",

                        style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
