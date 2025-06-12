import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qas_160422041_et/class/course.dart';
import 'package:qas_160422041_et/edit.dart';
import 'package:qas_160422041_et/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  int courseId;
  DetailScreen({super.key, required this.courseId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  Course? _course = null;
  Future<void> bacaCourse() async {
    final response = await http
        .post(Uri.parse("https://ubaya.xyz/flutter/160422041/qas/detail_course.php"),
        body: {
          "course_id": widget.courseId.toString()
        });

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      setState(() {
        _course = Course.fromJson(json['data']);
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    bacaCourse();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Detail Course")
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_course!.name),
                Text(_course!.code),
                Text(_course!.description),
                SizedBox(height: 20),
                Text("Instructors:"),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _course?.instructors?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(_course?.instructors?[index]["display_name"]);
                        }
                    )
                ),
                SizedBox(height: 22),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCourse(courseId: this.widget.courseId),
                        )
                    );
                  },
                  child: Text("EDIT")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
