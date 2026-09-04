import 'package:flutter/material.dart';


class PollStatCard extends StatelessWidget {


  final String value;

  final String title;



  final Color darkText =
      const Color(0xff183B56);



  const PollStatCard({

    super.key,

    required this.value,

    required this.title,

  });





  @override
  Widget build(BuildContext context) {


    return Container(


      padding:
      const EdgeInsets.all(20),



      decoration:
      BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(25),

      ),




      child: Column(

        children:[



          Text(

            value,

            style:
            TextStyle(

              color:darkText,

              fontSize:26,

              fontWeight:
              FontWeight.bold,

            ),

          ),




          Text(title)



        ],


      ),


    );


  }


}