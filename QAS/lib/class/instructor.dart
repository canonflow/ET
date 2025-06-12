class Instructor {
  int id;
  String displayName;
  String fullName;
  String expertise;
  String yearOfExperience;

  Instructor({
    required this.id,
    required this.displayName,
    required this.fullName,
    required this.expertise,
    required this.yearOfExperience,
  }) {
    this.id = id;
    this.displayName = displayName;
    this.fullName = fullName;
    this.expertise = expertise;
    this.yearOfExperience = yearOfExperience;
  }

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] as int,
      displayName: json['display_name'],
      fullName: json['full_name'],
      expertise: json['expertise'],
      yearOfExperience: json['year_of_experience']
    );
  }
}