import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PollResultsSection extends StatelessWidget {
  final List<String> options;

  final int Function(String option) getVotes;

  final double Function(String option) getPercentage;

  final Color primary = const Color(0xff3F8F83);

  final Color darkText = const Color(0xff183B56);

  const PollResultsSection({
    super.key,

    required this.options,

    required this.getVotes,

    required this.getPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Live Results",

            style: TextStyle(
              color: darkText,

              fontSize: 22,

              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 20),

          ...options.map((option) {
            double percent = getPercentage(option);

            int votes = getVotes(option);

            return Container(
              margin: const EdgeInsets.only(bottom: 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Expanded(
                        child: Text(
                          option,

                          style: TextStyle(
                            color: darkText,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        "${(percent * 100).toStringAsFixed(0)}%",

                        style: TextStyle(
                          color: primary,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  LinearPercentIndicator(
                    padding: EdgeInsets.zero,

                    lineHeight: 13,

                    percent: percent,

                    barRadius: const Radius.circular(20),

                    backgroundColor: const Color(0xffEAF1F8),

                    progressColor: primary,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "$votes votes",

                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
