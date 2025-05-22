import 'package:canonflow/class/popmovie.dart';
import 'package:canonflow/main.dart';
import 'package:canonflow/screen/popular-movie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DetailPop extends StatefulWidget {
  int movieID;
  DetailPop({super.key, required this.movieID});
  @override
  State<StatefulWidget> createState() {
    return _DetailPopState();
  }
}
class _DetailPopState extends State<DetailPop> {

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.xyz/flutter/160422041/detailmovie.php"),
      body: {'id': widget.movieID.toString()}
    );
    if (response.statusCode == 200) {
        return response.body;
    } else {
        throw Exception('Failed to read API');
    }
   }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      setState(() {});
    });
  }

  deleteMovie() async {
    final response = await http
      .post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/deletemovie.php"),
        body: {
          'movie_id': widget.movieID.toString()
        }
      );

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        if (json['result'] == 'success') {
          if (!mounted) return;

          ScaffoldMessenger
            .of(context)
            .showSnackBar(SnackBar(
              content: Text("Sukses menghapus data!")
            ));

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage(title: "Flutter Demo")), // replace with your actual screen widget
            (route) => false, // remove all previous routes
          );
        } else {
          ScaffoldMessenger
            .of(context)
            .showSnackBar(SnackBar(
              content: Text("Gagal menghapus data!")
            ));
          throw Exception("Failed to read API!");
        }
      }
  }


  PopMovie? _pm;

  Widget tampilData() {
    if (_pm == null) {
      return const CircularProgressIndicator();
    }
    return Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Text(_pm!.title, style: const TextStyle(fontSize: 25)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(_pm!.overview, style: const TextStyle(fontSize: 15))
          ),
          const Padding(
            padding: EdgeInsets.all(10), 
            child: Text("Genre:")
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _pm?.genres?.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Text(_pm?.genres?[index]['genre_name']);
              }
            )
          ),
          const Padding(
            padding: EdgeInsets.all(10), 
            child: Text("Cast(s):")
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _pm?.casts?.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Text(_pm?.casts?[index]);
              }
            )
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                deleteMovie();
              },
              child: Text('Hapus'),
            ),
          ),
        ]
      )
    );
  }


  @override
  void initState() {
    super.initState();
    bacaData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail of Popular Movie'),
      ),
      body: ListView(
        children: <Widget>[
          tampilData()
        ]
      )
    );
  }
}
