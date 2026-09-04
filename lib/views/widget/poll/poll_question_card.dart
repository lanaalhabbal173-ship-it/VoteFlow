import 'package:flutter/material.dart';


class PollQuestionCard extends StatelessWidget {


  final String question;



  final Color darkText =
      const Color(0xff183B56);



  const PollQuestionCard({

    super.key,

    required this.question,

  });





  @override
  Widget build(BuildContext context) {


    return Container(


      width: double.infinity,


      padding:
      const EdgeInsets.all(22),



      decoration:
      BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(30),

      ),





      child: Column(


        crossAxisAlignment:
        CrossAxisAlignment.start,


        children:[



          const Text(

            "Question",

            style:
            TextStyle(

              color: Colors.grey,

            ),

          ),




          const SizedBox(height:10),




          Text(

            question,

            style:

            TextStyle(

              color: darkText,

              fontSize:21,

              fontWeight:FontWeight.bold,

            ),

          )



        ],


      ),


    );


  }


}