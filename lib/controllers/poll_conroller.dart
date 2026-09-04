import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/poll_model.dart';
import '../services/poll_service.dart';
import '../routes/app_routes.dart';

class PollController extends GetxController {
  final PollService pollService = PollService();

  var isLoading = false.obs;

  var createdPoll = Rxn<PollModel>();

  var instructorPolls = <PollModel>[].obs;

  StreamSubscription? pollSubscription;

  StreamSubscription? historySubscription;

  // =========================
  // CREATE POLL
  // =========================

  Future<void> createPoll({
    required String question,

    required List<String> options,
  }) async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return;
      }

      PollModel? poll = await pollService.createPoll(
        question: question,

        options: options,

        instructorId: user.uid,
      );

      if (poll != null) {
        createdPoll.value = poll;

        listenToCurrentPoll();
        getInstructorPolls();
        Get.toNamed(AppRoutes.pollDetails);
      }
    } catch (e) {
      print("CREATE ERROR = $e");
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // LIVE UPDATE
  // =========================

  void listenToCurrentPoll() {
    if (createdPoll.value == null) {
      return;
    }

    pollSubscription?.cancel();

    pollSubscription = pollService
        .listenToPoll(createdPoll.value!.pollId)
        .listen((poll) {
          if (poll != null) {
            createdPoll.value = poll;
          }
        });
  }

  // =========================
  // START POLL
  // =========================

  Future<void> startPoll(String pollId) async {
    await pollService.startPoll(pollId);

    Get.snackbar("Started", "Students can vote now");
  }

  // =========================
  // END POLL
  // =========================

  Future<void> endPoll(String pollId) async {
    await pollService.endPoll(pollId);

    Get.snackbar(
      "Poll Ended",

      "Waiting to publish results",

      backgroundColor: Colors.white,
    );
  }

  // =========================
  // SHOW RESULTS
  // =========================

  Future<void> showResults(String pollId) async {
    await pollService.showResults(pollId);

    Get.snackbar(
      "Results Published",

      "Students can see results now",

      backgroundColor: Colors.white,
    );
  }

  // =========================
  // HISTORY
  // =========================

  void getInstructorPolls() {
    historySubscription?.cancel();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    historySubscription = pollService.getInstructorPolls(user.uid).listen((
      polls,
    ) {
      instructorPolls.value = polls;
    });
  }

  // =========================
  // OPEN OLD POLL
  // =========================

  void openPoll(PollModel poll) {
    createdPoll.value = poll;

    listenToCurrentPoll();

    Get.toNamed(AppRoutes.pollDetails);
  }

  // =========================
  // HELPERS
  // =========================

  bool get isWaiting => createdPoll.value?.status == "waiting";

  bool get isActive => createdPoll.value?.status == "active";

  bool get isEnded => createdPoll.value?.status == "ended";

  bool get resultsShown => createdPoll.value?.status == "show_result";

  int get totalVotes {
    if (createdPoll.value == null) {
      return 0;
    }

    return createdPoll.value!.votes.values
        .map((e) => int.tryParse(e.toString()) ?? 0)
        .fold(0, (a, b) => a + b);
  }

  double getPercentage(String option) {
    if (totalVotes == 0) {
      return 0;
    }

    int votes = int.tryParse(createdPoll.value!.votes[option].toString()) ?? 0;

    return votes / totalVotes;
  }

  @override
  void onClose() {
    pollSubscription?.cancel();

    historySubscription?.cancel();

    super.onClose();
  }
}
