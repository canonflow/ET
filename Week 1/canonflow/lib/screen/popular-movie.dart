import 'dart:convert';

import 'package:canonflow/class/popmovie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PopularMovie extends StatefulWidget {
  const PopularMovie({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopularMovieState();
  }
}

String _temp = 'waiting API respond…';
 Future<String> fetchData() async {
  final response = await http
    .get(Uri.parse("https://ubaya.xyz/flutter/160422041/movielist.php"));
  if (response.statusCode == 200) {
   return response.body;
  } else {
   throw Exception('Failed to read API');
  }
 }


class _PopularMovieState extends State<PopularMovie> {

  List<PopMovie> PMs = [];

  bacaData() {
    Future<String> data = fetchData();
    data.then((val) {
      Map json = jsonDecode(val);
      for (var mov in json['data']) {
        PopMovie pm = PopMovie.fromJson(mov);
        PMs.add(pm);
      }

      setState(() {
        _temp = PMs[2].overview;
      });
    });
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
        title: const Text('Popular Movie') 
      ),
      body: ListView(
        children:  <Widget>[
          // Text(_temp)
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: DaftarPopMovie(PMs),
          )
        ]
      )
    );
  }

  Widget DaftarPopMovie(popMovs) {
    if (popMovs != null) {
      return ListView.builder(
        itemCount: popMovs.length,
        itemBuilder: (BuildContext context, int index) {
          // return Text(popMovs[index].title.toString());
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                popMovs[index].url != ""
                ? Column(
                  children: [
                     const SizedBox(height: 4), 
                     Container(
                      width: 300,
                      height: 200,
                      alignment: Alignment(0, 0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(popMovs[index].url),
                          fit: BoxFit.cover
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                    ),
                    // Image.network(recipe.recipes[i].photo),
                    const SizedBox(height: 12),
                    Text(
                      popMovs[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 53, 72, 82)
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      popMovs[index].overview,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                  ],
                )
                : ListTile(
                    leading: const Icon(Icons.movie, size: 30),
                    title: Text(popMovs[index].title),
                    subtitle: Text(popMovs[index].overview),
                  ),

                SizedBox(height: 8)
              ],
            ),
          );
        }
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
