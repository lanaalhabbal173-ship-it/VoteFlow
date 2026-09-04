import 'package:flutter/material.dart';
import 'package:polling_app/views/widget/instructor/poll_text_field.dart';




class OptionInputCard extends StatelessWidget {


  final TextEditingController controller;

  final String hint;

  final VoidCallback onDelete;



  const OptionInputCard({

    super.key,

    required this.controller,

    required this.hint,

    required this.onDelete,

  });





  final Color primary =
      const Color(0xff3F8F83);





  @override
  Widget build(BuildContext context) {


    return Row(


      children:[



        Expanded(


          child:
          PollTextField(


            controller:
            controller,


            hint:
            hint,


            icon:
            Icons.radio_button_checked,


          ),


        ),




        const SizedBox(width:8),





        GestureDetector(


          onTap:
          onDelete,



          child:
          Container(


            height:55,


            width:55,



            decoration:
            BoxDecoration(


              color:
              Colors.red.withOpacity(.1),



              shape:
              BoxShape.circle,


            ),




            child:
            const Icon(


              Icons.delete_outline,


              color:
              Colors.red,


            ),


          ),


        )


      ],


    );


  }


}