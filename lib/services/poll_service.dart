import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

import '../models/poll_model.dart';


class PollService {


  final FirebaseDatabase _database =
      FirebaseDatabase.instance;



  // =========================
  // GENERATE CODE
  // =========================

  String generateCode(){

    Random random = Random();

    return (100000 + random.nextInt(900000))
        .toString();

  }





  // =========================
  // CREATE POLL
  // =========================

  Future<PollModel?> createPoll({

    required String question,

    required List<String> options,

    required String instructorId,

  }) async {


    try {


      String id =
      DateTime.now()
          .millisecondsSinceEpoch
          .toString();



      String code = generateCode();



      Map<String,dynamic> votes = {};

      for(String option in options){

        votes[option] = 0;

      }




      PollModel poll = PollModel(

        pollId: id,

        question: question,

        code: code,

        instructorId: instructorId,

        options: options,

        createdAt:
        DateTime.now()
            .millisecondsSinceEpoch,


        // مهم
        status: "waiting",


        participants: 0,


        votes: votes,


        voters: {},

      );



      await _database
          .ref("polls/$id")
          .set(
          poll.toJson()
      );



      return poll;



    }catch(e){

      print(
          "CREATE POLL ERROR = $e"
      );

      return null;

    }

  }







  // =========================
  // GET POLL BY CODE
  // =========================

  Future<PollModel?> getPollByCode(
      String code
      ) async {


    try{


      DatabaseEvent event =
      await _database
          .ref("polls")
          .orderByChild("code")
          .equalTo(code)
          .once();



      if(event.snapshot.value == null){

        return null;

      }




      Map data =
      Map<String,dynamic>
          .from(
          event.snapshot.value as Map
      );



      String key =
      data.keys.first;



      return PollModel.fromJson(

          Map<String,dynamic>
              .from(
              data[key]
          )

      );



    }catch(e){

      print(
          "GET POLL ERROR = $e"
      );

      return null;

    }

  }







  // =========================
  // START POLL
  // =========================

  Future<void> startPoll(
      String pollId
      ) async {


    await _database
        .ref(
        "polls/$pollId/status"
    )
        .set(
        "active"
    );


  }







  // =========================
  // END POLL
  // =========================

  Future<void> endPoll(
      String pollId
      ) async {


    await _database
        .ref(
        "polls/$pollId/status"
    )
        .set(
        "ended"
    );


  }







  // =========================
  // SHOW RESULTS TO STUDENTS
  // =========================

  Future<void> showResults(
      String pollId
      ) async {


    await _database
        .ref(
        "polls/$pollId/status"
    )
        .set(
        "show_result"
    );


  }







  // =========================
  // SUBMIT VOTE
  // =========================

  Future<bool> submitVote({

    required String pollId,

    required String answer,

    required String userId,

  }) async {


    try{


      DatabaseReference ref =
      _database.ref(
          "polls/$pollId"
      );



      DatabaseEvent event =
      await ref.once();



      Map data =
      Map<String,dynamic>
          .from(
          event.snapshot.value as Map
      );




      // منع التصويت إذا لم يبدأ

      if(data["status"] != "active"){

        return false;

      }




      Map voters =
      Map<String,dynamic>
          .from(
          data["voters"] ?? {}
      );



      if(voters[userId] == true){

        return false;

      }




      Map votes =
      Map<String,dynamic>
          .from(
          data["votes"] ?? {}
      );




      votes[answer] =
          (votes[answer] ?? 0) + 1;voters[userId] = true;



      await ref.update({

        "votes": votes,

        "voters": voters,


        "participants":
        (data["participants"] ?? 0) + 1,


      });



      return true;



    }catch(e){


      print(
          "VOTE ERROR = $e"
      );


      return false;

    }


  }








  // =========================
  // GET INSTRUCTOR POLLS
  // =========================


  Stream<List<PollModel>> getInstructorPolls(
      String instructorId
      ){


    return _database
        .ref("polls")
        .orderByChild("instructorId")
        .equalTo(instructorId)
        .onValue
        .map((event){



      List<PollModel> polls = [];



      if(event.snapshot.value == null){

        return polls;

      }




      Map data =
      Map<String,dynamic>
          .from(
          event.snapshot.value as Map
      );




      data.forEach((key,value){


        polls.add(
            PollModel.fromJson(
                Map<String,dynamic>
                    .from(value)
            )
        );


      });



      return polls;



    });


  }








  // =========================
  // LIVE LISTEN
  // =========================


  Stream<PollModel?> listenToPoll(
      String pollId
      ){


    return _database
        .ref(
        "polls/$pollId"
    )
        .onValue
        .map((event){


      if(event.snapshot.value == null){

        return null;

      }



      return PollModel.fromJson(

          Map<String,dynamic>
              .from(
              event.snapshot.value as Map
          )

      );


    });


  }



}