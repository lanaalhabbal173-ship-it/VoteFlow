import 'package:flutter/material.dart';

class PollQuestionCard extends StatelessWidget {
  final String question;

  final Color darkText = const Color(0xff183B56);

  const PollQuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),

        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Question",

            style: TextStyle(
              color: darkText.withOpacity(.55),

              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            question,

            style: TextStyle(
              color: darkText,

              fontSize: 20,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
