import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../controllers/student_poll_controller.dart';



class ResultPoll extends StatelessWidget {


  ResultPoll({super.key});



  final StudentPollController controller =
      Get.find<StudentPollController>();



  final Color primary =
      const Color(0xff3F8F83);



  final Color darkText =
      const Color(0xff183B56);






  @override
  Widget build(BuildContext context) {



    final poll =
    controller.currentPoll.value!;



    return Container(



      decoration:
      const BoxDecoration(



        gradient:
        LinearGradient(



          colors:[

            Color(0xffB8C9E8),

            Color(0xffEAF1F8),

          ],



          begin:
          Alignment.topLeft,



          end:
          Alignment.bottomRight,



        ),



      ),





      child:
      SafeArea(



        child:
        SingleChildScrollView(



          padding:
          const EdgeInsets.all(20),




          child:
          Column(



            crossAxisAlignment:
            CrossAxisAlignment.start,



            children:[





              Row(



                children:[




                  GestureDetector(


                    onTap:(){

                      Get.offAllNamed("/student");

                    },


                    child:
                    Container(



                      height:45,

                      width:45,



                      decoration:
                      const BoxDecoration(



                        color:
                        Colors.white,


                        shape:
                        BoxShape.circle,

                      ),




                      child:
                      Icon(



                        Icons.arrow_back_ios_new,


                        color:
                        primary,


                      ),



                    ),



                  ),





                  const SizedBox(width:15),





                  Text(



                    "Poll Results",



                    style:
                    TextStyle(



                      color:
                      darkText,



                      fontSize:
                      28,



                      fontWeight:
                      FontWeight.w800,



                    ),



                  )



                ],



              ),






              const SizedBox(height:30),








              // RESULT STATUS CARD


              Container(



                width:
                double.infinity,



                padding:
                const EdgeInsets.all(20),



                decoration:
                BoxDecoration(



                  color:
                  Colors.white,



                  borderRadius:
                  BorderRadius.circular(25),



                ),




                child:
                Row(



                  children:[



                    Container(



                      padding:
                      const EdgeInsets.all(12),



                      decoration:
                      BoxDecoration(



                        color:
                        primary.withOpacity(.1),



                        shape:
                        BoxShape.circle,



                      ),



                      child:
                      Icon(



                        Icons.check_circle,



                        color:
                        primary,



                        size:
                        30,



                      ),



                    ),






                    const SizedBox(width:15),






                    Expanded(



                      child:
                      Text(



                        "Results are now visible",



                        style:
                        TextStyle(



                          color:
                          darkText,fontSize:
                          17,



                          fontWeight:
                          FontWeight.bold,



                        ),



                      ),



                    )



                  ],



                ),



              ),







              const SizedBox(height:25),







              // QUESTION


              Container(



                width:
                double.infinity,



                padding:
                const EdgeInsets.all(22),



                decoration:
                BoxDecoration(



                  color:
                  Colors.white,



                  borderRadius:
                  BorderRadius.circular(30),



                ),





                child:
                Column(



                  crossAxisAlignment:
                  CrossAxisAlignment.start,



                  children:[



                    const Text(



                      "Question",



                      style:
                      TextStyle(



                        color:
                        Colors.grey,



                      ),



                    ),





                    const SizedBox(height:10),





                    Text(



                      poll.question,



                      style:
                      TextStyle(



                        color:
                        darkText,



                        fontSize:
                        20,



                        fontWeight:
                        FontWeight.bold,



                      ),



                    )



                  ],



                ),



              ),








              const SizedBox(height:25),








              Text(



                "Final Results",



                style:
                TextStyle(



                  color:
                  darkText,



                  fontSize:
                  23,



                  fontWeight:
                  FontWeight.w800,



                ),



              ),







              const SizedBox(height:15),








              Container(



                padding:
                const EdgeInsets.all(20),



                decoration:
                BoxDecoration(



                  color:
                  Colors.white,



                  borderRadius:
                  BorderRadius.circular(30),



                ),






                child:
                Column(



                  children:[




                    ...poll.options.map((option){



                      double percent =
                      controller.getPercentage(option);




                      int votes =

                      int.tryParse(

                          poll.votes[option]
                              .toString()

                      ) ?? 0;





                      return Column(



                        crossAxisAlignment:
                        CrossAxisAlignment.start,



                        children:[





                          Row(



                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,



                            children:[



                              Expanded(



                                child:
                                Text(



                                  option,



                                  style:
                                  TextStyle(



                                    color:
                                    darkText,



                                    fontWeight:
                                    FontWeight.bold,



                                  ),



                                ),



                              ),





                              Text(



                                "${(percent*100).toStringAsFixed(0)}%",



                                style:
                                TextStyle(color:
                                  primary,



                                  fontWeight:
                                  FontWeight.bold,



                                ),



                              )



                            ],



                          ),







                          const SizedBox(height:10),







                          LinearPercentIndicator(



                            padding:
                            EdgeInsets.zero,



                            lineHeight:
                            14,



                            percent:
                            percent,



                            barRadius:
                            const Radius.circular(20),



                            backgroundColor:
                            const Color(0xffEAF1F8),



                            progressColor:
                            primary,



                          ),






                          const SizedBox(height:5),






                          Text(



                            "$votes votes",



                            style:
                            const TextStyle(



                              color:
                              Colors.grey,



                              fontSize:
                              13,



                            ),



                          ),






                          const SizedBox(height:20),




                        ],



                      );



                    })



                  ],



                ),



              ),








              const SizedBox(height:20),







              Container(



                width:
                double.infinity,



                padding:
                const EdgeInsets.all(20),



                decoration:
                BoxDecoration(



                  color:
                  primary,



                  borderRadius:
                  BorderRadius.circular(25),



                ),





                child:
                Column(



                  children:[



                    const Text(



                      "Total Votes",



                      style:
                      TextStyle(



                        color:
                        Colors.white70,



                      ),



                    ),






                    Text(



                      "${controller.totalVotes}",



                      style:
                      const TextStyle(



                        color:
                        Colors.white,



                        fontSize:
                        32,



                        fontWeight:
                        FontWeight.w900,



                      ),



                    )



                  ],



                ),



              )





            ],



          ),



        ),



      ),



    );

  }


}