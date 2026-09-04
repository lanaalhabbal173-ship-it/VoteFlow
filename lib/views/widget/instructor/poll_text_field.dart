import 'package:flutter/material.dart';


class PollTextField extends StatelessWidget {


  final TextEditingController controller;

  final String hint;

  final IconData icon;



  final Color primary =
      const Color(0xff3F8F83);




  const PollTextField({

    super.key,

    required this.controller,

    required this.hint,

    required this.icon,

  });





  @override
  Widget build(BuildContext context) {


    return TextField(


      controller: controller,



      decoration:
      InputDecoration(


        hintText: hint,



        prefixIcon:
        Icon(

          icon,

          color: primary,

        ),




        filled:true,



        fillColor:
        Colors.white.withOpacity(.9),





        border:
        OutlineInputBorder(


          borderRadius:
          BorderRadius.circular(25),



          borderSide:
          BorderSide.none,


        ),




        contentPadding:
        const EdgeInsets.symmetric(

          vertical:20,

        ),



      ),



    );


  }


}