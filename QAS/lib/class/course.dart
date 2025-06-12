import 'package:qas_160422041_et/class/instructor.dart';

class Course {
  int id;
  String name;
  String code;
  String description;
  String thumbnail;
  List? instructors;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.thumbnail,
    this.instructors
  }) {
    this.id = id;
    this.name = name;
    this.code = code;
    this.description = description;
    this.thumbnail = thumbnail;
    this.instructors = instructors;
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'] as int,
        name: json['name'],
        code: json['code'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        instructors: json['instructors']
    );
  }
}