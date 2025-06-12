import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:qas_160422041_et/class/course.dart';
import 'package:qas_160422041_et/class/instructor-add.dart';
import 'package:qas_160422041_et/detail.dart';
import 'package:qas_160422041_et/main.dart';

class EditCourse extends StatefulWidget {
  int courseId;
  EditCourse({super.key, required this.courseId});

  @override
  EditCourseState createState() {
    return EditCourseState();
  }
}

class EditCourseState extends State<EditCourse> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameCont = TextEditingController();
  TextEditingController _codeCont = TextEditingController();
  TextEditingController _descriptionCont = TextEditingController();


  Course? _course;
  Widget comboGenre = Text('tambah instructor');

  Future<String> fetchData() async {
    final response = await http
        .post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/qas/detail_course.php"),
        body: {
          'course_id': widget.courseId.toString()
        }
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to read API");
    }
  }

  Future<List> daftarGenre() async {
    Map json;
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/qas/instructorlist.php"),
        body: {'movie_id': widget.courseId.toString()}
    );

    if (response.statusCode == 200) {
      print(response.body);
      json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception('Failed to read API');
    }
  }


  void generateComboInstructor() {
    List<InstructorAdd> instructors;
    var data = daftarGenre();
    data.then((value) {
      instructors = List<InstructorAdd>
          .from(value.map((i) {
        return InstructorAdd.fromJSON(i);})
      );
      setState(() {
        comboGenre = DropdownButton(
            dropdownColor: Colors.grey[100],
            hint: const Text("tambah genre"),
            isDense: false,
            items: instructors.map((gen) {
              return DropdownMenuItem(
                value: gen.instructor_id,
                child: Column(children: <Widget>[
                  Text(gen.instructor_name, overflow: TextOverflow.visible),
                ]),
              );
            }).toList(),
            onChanged: (value) {
              // addGenre(value);
            }
        );
      });
    });
  }

  // void addGenre(genre_id) async {
  //   final response = await http.post(
  //       Uri.parse("https://ubaya.xyz/flutter/160422041/addmoviegenre.php"),
  //       body: {'genre_id': genre_id.toString(), 'movie_id': widget.movieID.toString()
  //       });
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     Map json = jsonDecode(response.body);
  //     if (json['result'] == 'success') {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Sukses menambah genre')));
  //       setState(() {
  //         bacaData();
  //       });
  //     }
  //   } else {
  //     throw Exception('Failed to read API');
  //   }
  // }

  // void deleteGenre(genre_id) async {
  //   print(genre_id);
  //   final response = await http.post(
  //       Uri.parse("https://ubaya.xyz/flutter/160422041/deletemoviegenre.php"),
  //       body: {'genre_id': genre_id.toString(), 'movie_id': widget.movieID.toString()
  //       });
  //
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     Map json = jsonDecode(response.body);
  //     if (json['result'] == 'success') {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Sukses menghapus genre')));
  //       setState(() {
  //         bacaData();
  //       });
  //     }
  //   } else {
  //     throw Exception('Failed to read API');
  //   }
  // }


  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      _course = Course.fromJson(json['data']);
      // print(_pm!.genres!);
      setState(() {
        _nameCont.text = _course!.name;
        _codeCont.text = _course!.code;
        _descriptionCont.text = _course!.description;
        // generateComboGenre();
      });
    });
  }

  void submit() async {
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/qas/update_course.php"),
        body: {
          'name': _course!.name,
          'code': _course!.code,
          'description': _course!.description,
          'course_id': this.widget.courseId.toString()
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses mengubah Data')));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: "Flutter Demo")), // replace with your actual screen widget
              (route) => false, // remove all previous routes
        );
      }
    } else {
      throw Exception('Failed to read API');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Popular Movie"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        _course?.name = value;
                      },
                      controller: _nameCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'nama harus diisi';
                        }
                        return null;
                      },
                    )
                ),

                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Code',
                      ),
                      onChanged: (value) {
                        _course!.code = value;
                      },
                      controller: _codeCont,
                      validator: (value) {
                        if (value == null) {
                          return 'Code website salah';
                        }
                        return null;
                      },
                    )
                ),

                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      onChanged: (value) {
                        _course!.description = value;
                      },
                      controller: _descriptionCont,
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 6,
                    )
                ),
                const SizedBox(height: 20),

                // Padding(padding: EdgeInsets.all(10), child: Text('Genre:')),
                // if(_pm != null)
                //   Padding(
                //       padding: EdgeInsets.all(10),
                //       child: ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: _pm!.genres!.length ?? 0,
                //           itemBuilder: (BuildContext ctxt, int index) {
                //             // return Text(_pm!.genres![index]['genre_name']);
                //             return Padding(
                //                 padding: EdgeInsets.symmetric(vertical: 2),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     Text(_pm!.genres![index]['genre_name']),
                //                     ElevatedButton(
                //                       onPressed: () {
                //                         deleteGenre(_pm!.genres![index]['genre_id']);
                //                       },
                //                       child: Text("Delete"),
                //                     ),
                //                   ],
                //                 )
                //             );
                //           }
                //       )
                //   ),

                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: comboGenre
                ),

                ElevatedButton(
                  onPressed: () {
                    var state = _formKey.currentState;
                    if (state == null || !state.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap Isian diperbaiki')));
                    } else {
                      submit();
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}

