import 'package:flutter/material.dart';

class PollOptionCard extends StatelessWidget {
  final String option;

  final bool selected;

  final VoidCallback onTap;

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  const PollOptionCard({
    super.key,

    required this.option,

    required this.selected,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        margin: const EdgeInsets.only(bottom: 14),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: selected ? primary : Colors.white,

          borderRadius: BorderRadius.circular(22),
        ),

        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,

              color: selected ? Colors.white : primary,
            ),

            const SizedBox(width: 15),

            Text(
              option,

              style: TextStyle(
                color: selected ? Colors.white : darkText,

                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
