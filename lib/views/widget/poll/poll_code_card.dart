import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';


class PollCodeCard extends StatelessWidget {


  final String code;


  final Color primary =
      const Color(0xff3F8F83);



  const PollCodeCard({

    super.key,

    required this.code,

  });





  @override
  Widget build(BuildContext context) {


    return Container(


      width: double.infinity,


      padding: const EdgeInsets.all(25),



      decoration: BoxDecoration(


        gradient: LinearGradient(


          colors:[

            primary,

            const Color(0xff69B3A8),

          ],


        ),



        borderRadius:
        BorderRadius.circular(35),


      ),





      child: Column(



        children:[



          const Text(

            "POLL CODE",

            style: TextStyle(

              color: Colors.white70,

              letterSpacing:2,

            ),

          ),




          const SizedBox(height:10),




          Row(

            mainAxisAlignment:
            MainAxisAlignment.center,


            children:[



              Text(

                code,

                style: const TextStyle(

                  color: Colors.white,

                  fontSize:40,

                  fontWeight:FontWeight.w900,

                  letterSpacing:8,

                ),

              ),





              IconButton(

                onPressed:(){


                  Clipboard.setData(

                    ClipboardData(

                      text: code,

                    ),

                  );


                  Get.snackbar(

                    "Copied",

                    "Poll code copied",

                  );


                },

                icon: const Icon(

                  Icons.copy,

                  color: Colors.white,

                ),

              )

            ],

          ),






          const SizedBox(height:15),





          ElevatedButton.icon(

            style: ElevatedButton.styleFrom(

              backgroundColor: Colors.white,

              foregroundColor: primary,

            ),



            onPressed:(){


              Share.share(

                "Join my Poll using code: $code",

              );


            },


            icon:
            const Icon(Icons.share),



            label:
            const Text("SHARE CODE"),


          )




        ],


      ),


    );


  }


}