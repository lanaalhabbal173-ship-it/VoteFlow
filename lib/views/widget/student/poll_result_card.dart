import 'package:flutter/material.dart';


class PollResultCard extends StatelessWidget {


  final String option;


  final double percentage;


  final int votes;



  final Color primary =
      const Color(0xff3F8F83);



  final Color darkText =
      const Color(0xff183B56);




  const PollResultCard({

    super.key,

    required this.option,

    required this.percentage,

    required this.votes,

  });






  @override
  Widget build(BuildContext context) {



    return Container(


      margin:
      const EdgeInsets.only(
          bottom:15
      ),



      padding:
      const EdgeInsets.all(18),



      decoration:
      BoxDecoration(


        color:
        Colors.white,


        borderRadius:
        BorderRadius.circular(20),


      ),




      child:
      Column(



        crossAxisAlignment:
        CrossAxisAlignment.start,



        children:[




          Row(


            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,



            children:[



              Text(


                option,


                style:
                TextStyle(


                  color:
                  darkText,


                  fontWeight:
                  FontWeight.bold,


                  fontSize:16,


                ),


              ),





              Text(


                "${(percentage * 100).toStringAsFixed(0)}%",



                style:
                TextStyle(


                  color:
                  primary,


                  fontWeight:
                  FontWeight.bold,


                ),


              )



            ],


          ),





          const SizedBox(height:10),






          LinearProgressIndicator(


            value:
            percentage,


            minHeight:
            10,


            color:
            primary,


            backgroundColor:
            Colors.grey.shade200,


          ),





          const SizedBox(height:8),





          Text(


            "$votes Votes",



            style:
            TextStyle(


              color:
              darkText.withValues(alpha: .6),


              fontSize:14,


            ),


          )



        ],


      ),


    );


  }


}