class PopActor {
  String name;

 PopActor({required this.name});

 factory PopActor.fromJson(Map<String, dynamic> json) {
  return PopActor(
   name: json['person_name'].toString()
  );
 }
}
