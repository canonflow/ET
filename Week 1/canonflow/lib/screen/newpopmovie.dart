import 'package:canonflow/class/popmovie.dart';
import 'package:canonflow/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewPopMovie extends StatefulWidget {
  const NewPopMovie({super.key});

  @override
  State<NewPopMovie> createState() => _NewPopMovieState();
}

class _NewPopMovieState extends State<NewPopMovie> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _homepage = "";
  String _overview = "";
  final _controllerDate = TextEditingController();
  int _runtime = 0;
  String _url = "";

  Future<bool> validateImage(String imageUrl) async {
    http.Response res;

    try {
      res = await http.get(Uri.parse(imageUrl));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) return false;

    Map<String, dynamic> data = res.headers;

    if (
      data['content-type'] == 'image/jpeg' || 
      data['content-type'] == 'image/png' || 
      data['content-type'] == 'image/gif'
    ) {
      return true;
    }

    return false;
  }

  void submit() async {
    final response = await http
      .post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/newmovie.php"),
        body: {
          'title': _title,
          'overview': _overview,
          'homepage': _homepage,
          'release_date': _controllerDate.text,
          'runtime': _runtime.toString(),
          'url': _url
        }
      );

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          if (!mounted) return;

          ScaffoldMessenger
            .of(context)
            .showSnackBar(SnackBar(
              content: Text("Sukses menambah data!")
            ));
        } else {
          ScaffoldMessenger
            .of(context)
            .showSnackBar(SnackBar(
              content: Text("Gagal menambah data!")
            ));
          throw Exception("Failed to read API!");
        }
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Popular Movie"),
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
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    _title = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul harus diisi';
                    }
                    return null;
                  },
                )
              ),
        
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Website',
                  ),
                  onChanged: (value) {
                    _homepage = value;
                  },
                  validator: (value) {
                    if (value == null || !Uri.parse(value).isAbsolute) {
                      return 'alamat website salah';
                    }
                    return null;
                  },
                )
              ),
        
              Padding(
                padding: EdgeInsets.all(10), 
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Overview',
                  ),
                  onChanged: (value) {
                    _overview = value;
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value!.length < 10) {
                      return 'panjang minimal 10 karakter';
                    }
                    return null;
                  },
                )
              ),
        
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Release Date',
                        ),
                      controller: _controllerDate,
                      )
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2200))
                          .then((value) {
                        setState(() {
                          _controllerDate.text =
                            value.toString().substring(0, 10);
                        });
                        });
                      },
                      child: Icon(
                        Icons.calendar_today_sharp,
                        color: Colors.white,
                        size: 24.0,
                      )
                    )
                  ],
                )
              ),
        
        
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Runtime',
                  ),
                  onChanged: (value) {
                    _runtime = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'runtime salah';
                    }
                    return null;
                  },
                   inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                  ],
                )
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'URL',
                  ),
                  onChanged: (value) {
                    validateImage(value)
                      .then((val) {
                        if (val) {
                          setState(() {
                            _url = value;
                          });
                        }
                      });
                  },
                )
              ),
              
              _url.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.network(_url),
                ) :
                SizedBox.shrink(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Harap Isian diperbaiki')));
                    } else {
                      submit();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}