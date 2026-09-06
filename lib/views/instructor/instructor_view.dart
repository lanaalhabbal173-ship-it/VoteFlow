import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../controllers/poll_conroller.dart';
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
      print("GET NAME ERROR $e");
    }
  }

  void showDeleteDialog(poll) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,

        child: Container(
          padding: const EdgeInsets.all(25),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(30),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                height: 70,

                width: 70,

                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.1),

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.delete_outline,

                  color: Colors.red,

                  size: 40,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Delete Poll?",

                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),

              const SizedBox(height: 10),

              const Text(
                "Are you sure you want to delete this poll?",

                textAlign: TextAlign.center,

                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },

                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),

                      onPressed: () {
                        Get.back();

                        controller.deletePoll(poll.pollId);
                      },

                      child: const Text(
                        "Delete",

                        style: TextStyle(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB8C9E8), Color(0xffF5F8FC)],

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
                // HEADER CARD
                Container(
                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(35),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),

                        blurRadius: 25,

                        offset: const Offset(0, 12),
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

                              decoration: BoxDecoration(
                                color: const Color(0xffEAF1F8),

                                borderRadius: BorderRadius.circular(15),
                              ),

                              child: Icon(Icons.logout_rounded, color: primary),
                            ),
                          ),

                          Container(
                            height: 65,

                            width: 65,

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primary, const Color(0xff69B3A8)],
                              ),

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

                                  fontWeight: FontWeight.w800,
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
                          color: darkText.withOpacity(.55),

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        instructorName,

                        style: TextStyle(
                          color: darkText,

                          fontSize: 32,

                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Manage your polls and interact with students",

                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // CREATE POLL BUTTON CARD
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.createPoll);
                  },

                  child: Container(
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
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Create New Poll",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                "Start a live classroom interaction",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 55,
                          width: 55,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          child: Icon(
                            Icons.add_rounded,
                            color: primary,
                            size: 30,
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
                    color: darkText,

                    fontSize: 26,

                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 15),

                // POLLS LIST
                Obx(() {
                  if (controller.instructorPolls.isEmpty) {
                    return Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(30),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Column(
                        children: [
                          Icon(Icons.poll_outlined, size: 50, color: primary),

                          const SizedBox(height: 15),

                          Text(
                            "No polls created yet",

                            style: TextStyle(
                              color: darkText,

                              fontWeight: FontWeight.bold,

                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: controller.instructorPolls.map((poll) {
                      Color statusColor;

                      String statusText;

                      IconData statusIcon;

                      switch (poll.status) {
                        case "waiting":
                          statusColor = Colors.orange;

                          statusText = "WAITING";

                          statusIcon = Icons.schedule_rounded;

                          break;

                        case "active":
                          statusColor = Colors.green;

                          statusText = "LIVE NOW";

                          statusIcon = Icons.circle;

                          break;

                        case "ended":
                          statusColor = Colors.red;

                          statusText = "ENDED";

                          statusIcon = Icons.stop_circle_outlined;

                          break;

                        default:
                          statusColor = Colors.blue;

                          statusText = poll.status.toUpperCase();

                          statusIcon = Icons.info_outline;
                      }

                      return GestureDetector(
                        onTap: () {
                          controller.openPoll(poll);
                        },

                        onLongPress: () {
                          showDeleteDialog(poll);
                        },

                        child: Container(
                          margin: const EdgeInsets.only(bottom: 18),

                          padding: const EdgeInsets.all(22),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(32),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.06),

                                blurRadius: 20,

                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              // TOP ROW
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,

                                      vertical: 7,
                                    ),

                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(.12),

                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Row(
                                      children: [
                                        Icon(
                                          statusIcon,

                                          size: 12,

                                          color: statusColor,
                                        ),

                                        const SizedBox(width: 6),

                                        Text(
                                          statusText,

                                          style: TextStyle(
                                            color: statusColor,

                                            fontWeight: FontWeight.w800,

                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        poll.code,

                                        style: TextStyle(
                                          color: primary,

                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,

                                          letterSpacing: 2,
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      Container(
                                        height: 32,

                                        width: 32,

                                        decoration: BoxDecoration(
                                          color: primary.withOpacity(.1),

                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),

                                        child: Icon(
                                          Icons.copy_rounded,

                                          size: 16,

                                          color: primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 22),

                              Text(
                                poll.question,

                                maxLines: 2,

                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: darkText,

                                  fontSize: 19,

                                  fontWeight: FontWeight.w900,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Row(
                                children: [
                                  Expanded(
                                    child: infoBox(
                                      Icons.people_alt_rounded,

                                      "${poll.participants}",

                                      "Students",
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: infoBox(
                                      Icons.how_to_vote_rounded,

                                      "${poll.votes.values.fold(0, (a, b) => a + (b as int))}",

                                      "Votes",
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              Container(
                                width: double.infinity,

                                height: 45,

                                decoration: BoxDecoration(
                                  color: primary,

                                  borderRadius: BorderRadius.circular(18),
                                ),

                                child: const Center(
                                  child: Text(
                                    "View Poll  →",

                                    style: TextStyle(
                                      color: Colors.white,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoBox(IconData icon, String value, String title) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xffF5F8FA),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Icon(icon, color: primary, size: 22),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                value,

                style: TextStyle(color: darkText, fontWeight: FontWeight.bold),
              ),

              Text(
                title,

                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
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
                color: Colors.black.withOpacity(.1),

                blurRadius: 25,

                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                height: 75,

                width: 75,

                decoration: BoxDecoration(
                  color: primary.withOpacity(.12),

                  shape: BoxShape.circle,
                ),

                child: Icon(Icons.logout_rounded, color: primary, size: 40),
              ),

              const SizedBox(height: 20),

              Text(
                "Logout?",

                style: TextStyle(
                  color: darkText,

                  fontSize: 25,

                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Are you sure you want to logout\nfrom your account?",

                textAlign: TextAlign.center,

                style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primary),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: () {
                        Get.back();
                      },

                      child: Text(
                        "Cancel",

                        style: TextStyle(
                          color: darkText,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,

                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
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
