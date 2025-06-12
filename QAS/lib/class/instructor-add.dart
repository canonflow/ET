class InstructorAdd {
  int instructor_id;
  String instructor_name;

  InstructorAdd({
    required this.instructor_id,
    required this.instructor_name
  });

  factory InstructorAdd.fromJSON(Map<String, dynamic> json) {
    return InstructorAdd(
      instructor_id: json["value"],
      instructor_name: json["label"],
    );
  }
}
