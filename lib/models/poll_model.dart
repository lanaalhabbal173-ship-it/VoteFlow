class PollModel {
  final String pollId;

  final String question;

  final String code;

  final String instructorId;

  final List<String> options;

  final int createdAt;

  final String status;

  final int participants;

  final Map<String, dynamic> votes;

  final Map<String, dynamic> voters;

  PollModel({
    required this.pollId,

    required this.question,

    required this.code,

    required this.instructorId,

    required this.options,

    required this.createdAt,

    required this.status,

    required this.participants,

    required this.votes,

    required this.voters,
  });

  Map<String, dynamic> toJson() {
    return {
      "pollId": pollId,

      "question": question,

      "code": code,

      "instructorId": instructorId,

      "options": options,

      "createdAt": createdAt,

      "status": status,

      "participants": participants,

      "votes": votes,

      "voters": voters,
    };
  }

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      pollId: json["pollId"] ?? "",

      question: json["question"] ?? "",

      code: json["code"] ?? "",

      instructorId: json["instructorId"] ?? "",

      options: List<String>.from(json["options"] ?? []),

      createdAt: json["createdAt"] ?? 0,

      status: json["status"] ?? "waiting",

      participants: json["participants"] ?? 0,

      votes: Map<String, dynamic>.from(json["votes"] ?? {}),

      voters: Map<String, dynamic>.from(json["voters"] ?? {}),
    );
  }
}
