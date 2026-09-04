import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/poll_model.dart';
import '../services/poll_service.dart';
import '../routes/app_routes.dart';

class StudentPollController extends GetxController {
  final PollService pollService = PollService();

  var isLoading = false.obs;

  var selectedAnswer = "".obs;

  var currentPoll = Rxn<PollModel>();

  StreamSubscription? pollSubscription;

  // JOIN POLL

  Future<void> joinPoll(String code) async {
    if (code.isEmpty) {
      Get.snackbar("Error", "Enter poll code");

      return;
    }

    try {
      isLoading.value = true;

      PollModel? poll = await pollService.getPollByCode(code);

      if (poll == null) {
        Get.snackbar("Not Found", "Invalid poll code");

        return;
      }

      currentPoll.value = poll;

      startListening();

      Get.toNamed(AppRoutes.studentPoll);
    } catch (e) {
      print("JOIN ERROR = $e");
    } finally {
      isLoading.value = false;
    }
  }

  // LIVE UPDATE

  void startListening() {
    if (currentPoll.value == null) {
      return;
    }

    pollSubscription?.cancel();

    pollSubscription = pollService
        .listenToPoll(currentPoll.value!.pollId)
        .listen((poll) {
          if (poll != null) {
            currentPoll.value = poll;
          }
        });
  }

  // SUBMIT VOTE

  Future<void> submitVote() async {
    if (selectedAnswer.value.isEmpty) {
      Get.snackbar("Choose Answer", "Select an option first");

      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    bool success = await pollService.submitVote(
      pollId: currentPoll.value!.pollId,

      answer: selectedAnswer.value,

      userId: user.uid,
    );

    if (success) {
      Get.snackbar("Success", "Your vote submitted");
    } else {
      Get.snackbar("Error", "You cannot vote now");
    }
  }

  // STATUS HELPERS

  bool get isWaiting => currentPoll.value?.status == "waiting";

  bool get isActive => currentPoll.value?.status == "active";

  bool get isEnded => currentPoll.value?.status == "ended";

  bool get showResults => currentPoll.value?.status == "show_result";

  // RESULTS

  int get totalVotes {
    if (currentPoll.value == null) {
      return 0;
    }

    return currentPoll.value!.votes.values
        .map((e) => int.tryParse(e.toString()) ?? 0)
        .fold(0, (a, b) => a + b);
  }

  double getPercentage(String option) {
    if (totalVotes == 0) {
      return 0;
    }

    int votes = int.tryParse(currentPoll.value!.votes[option].toString()) ?? 0;

    return votes / totalVotes;
  }

  @override
  void onClose() {
    pollSubscription?.cancel();

    super.onClose();
  }
}
