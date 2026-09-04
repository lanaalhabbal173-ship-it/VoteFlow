import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../routes/app_routes.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  String studentName = "Student";

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  @override
  void initState() {
    super.initState();

    getStudentName();
  }

  Future<void> getStudentName() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DatabaseEvent event = await FirebaseDatabase.instance
          .ref("users/$uid")
          .once();

      if (event.snapshot.value != null) {
        Map data = Map<String, dynamic>.from(event.snapshot.value as Map);

        setState(() {
          studentName = data["name"] ?? "Student";
        });
      }
    } catch (e) {
      print("GET NAME ERROR = $e");
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
                    color: Colors.white.withOpacity(.85),

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

                              decoration: BoxDecoration(
                                color: const Color(0xffEAF1F8),

                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.logout_rounded,

                                color: Color(0xff3F8F83),
                              ),
                            ),
                          ),

                          Container(
                            height: 65,

                            width: 65,
                            decoration: const BoxDecoration(
                              color: Color(0xff3F8F83),

                              shape: BoxShape.circle,
                            ),

                            child: Center(
                              child: Text(
                                studentName.isNotEmpty
                                    ? studentName[0].toUpperCase()
                                    : "S",

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
                        "Hello 👋",

                        style: TextStyle(
                          color: darkText.withOpacity(.6),

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        studentName,

                        style: TextStyle(
                          color: darkText,

                          fontSize: 30,

                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Ready to join your class polls?",

                        style: TextStyle(color: darkText.withOpacity(.65)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Quick Actions",

                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: actionCard(
                        Icons.poll_rounded,

                        "Join Poll",

                        "Enter code",

                        true,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: actionCard(
                        Icons.history_rounded,

                        "History",

                        "Your answers",

                        false,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // JOIN POLL CARD
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.joinPoll);
                  },

                  child: Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff3F8F83), Color(0xff69B3A8)],
                      ),

                      borderRadius: BorderRadius.circular(35),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),

                          blurRadius: 20,

                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Container(
                          height: 70,

                          width: 70,

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.25),

                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.qr_code_scanner_rounded,

                            size: 40,

                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Have a Poll Code?",

                          style: TextStyle(
                            color: Colors.white,

                            fontSize: 26,

                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Enter the code shared by your instructor",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white.withOpacity(.85),

                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 25),

                        Container(
                          width: double.infinity,

                          height: 55,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Center(
                            child: Text(
                              "JOIN NOW",

                              style: TextStyle(
                                color: Color(0xff3F8F83),

                                fontSize: 17,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "Your Activity",

                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                infoCard(
                  Icons.assignment_turned_in_outlined,

                  "Participate in polls",

                  "Share your opinion with your class",
                ),

                infoCard(
                  Icons.analytics_outlined,

                  "Track your responses",

                  "Review your previous activities",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget actionCard(IconData icon, String title, String subtitle, bool active) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: active ? const Color(0xff3F8F83) : Colors.white,

        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 15),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(
            icon,

            size: 35,

            color: active ? Colors.white : const Color(0xff3F8F83),
          ),

          const SizedBox(height: 15),

          Text(
            title,

            style: TextStyle(
              fontWeight: FontWeight.bold,

              color: active ? Colors.white : const Color(0xff183B56),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,

            style: TextStyle(
              color: active ? Colors.white70 : Colors.grey,

              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 15),
        ],
      ),

      child: Row(
        children: [
          Container(
            height: 55,

            width: 55,

            decoration: const BoxDecoration(
              color: Color(0xffEAF1F8),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: Color(0xff3F8F83)),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,

                    color: Color(0xff183B56),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,

                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
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
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                height: 70,

                width: 70,

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

                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Are you sure you want to logout?",

                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },

                      child: const Text("Cancel"),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3F8F83),
                      ),

                      onPressed: () {
                        Get.offAllNamed(AppRoutes.login);
                      },

                      child: const Text(
                        "Logout",

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
}
