import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polling_app/views/widget/studentpoll/ended_poll.dart';
import 'package:polling_app/views/widget/studentpoll/result_poll.dart';
import 'package:polling_app/views/widget/studentpoll/voting_poll.dart';
import 'package:polling_app/views/widget/studentpoll/waiting_poll.dart';

import '../../controllers/student_poll_controller.dart';





class StudentPollView extends StatelessWidget {


  StudentPollView({super.key});



  final StudentPollController controller =
      Get.find<StudentPollController>();




  @override
  Widget build(BuildContext context) {



    return Scaffold(



      body:

      Obx(() {



        final poll =
        controller.currentPoll.value;



        if(poll == null){


          return const Center(

            child:
            Text(
                "No Poll Found"
            ),

          );


        }







        // WAITING


        if(controller.isWaiting){


          return WaitingPoll();



        }






        // VOTING


        if(controller.isActive){


          return VotingPoll();



        }







        // FINISHED BUT HIDDEN


        if(controller.isEnded){


          return EndedPoll();



        }








        // SHOW RESULTS


        if(controller.showResults){


          return ResultPoll();



        }







        return const SizedBox();



      }),


    );

  }


}