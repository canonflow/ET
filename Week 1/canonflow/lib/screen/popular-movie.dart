import 'dart:convert';

import 'package:canonflow/class/cart.dart';
import 'package:canonflow/class/popmovie.dart';
import 'package:canonflow/screen/detailpop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


String _txtcari = "";

class PopularMovie extends StatefulWidget {
  const PopularMovie({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopularMovieState();
  }
}

String _temp = 'waiting API respond…';
 Future<String> fetchData() async {
  // final response = await http
  //   .get(Uri.parse("https://ubaya.xyz/flutter/160422041/movielist.php"));
  final response = await http
    .post(
      Uri.parse("https://ubaya.xyz/flutter/160422041/movielist.php"),
      body: {
        'cari': _txtcari
      }
    );
  if (response.statusCode == 200) {
   return response.body;
  } else {
   throw Exception('Failed to read API');
  }
 }


class _PopularMovieState extends State<PopularMovie> {

  List<PopMovie> PMs = [];
  final dbHelper = DatabaseHelper.instance;

  void addCart(movie_id, title) async {
    Map<String, dynamic> row = {
      'movie_id': movie_id,
      'title': title,
      'jumlah': 1
    };

    await dbHelper.addCart(row);

    if (!mounted) return;

    ScaffoldMessenger
      .of(context)
      .showSnackBar(
        SnackBar(
          content: Text('Sukses manambah barang')
        )
      );
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((val) {
      Map json = jsonDecode(val);
      if (json['result'] == "success") {
        for (var mov in json['data']) {
          PopMovie pm = PopMovie.fromJson(mov);
          PMs.add(pm);
        }
      } else {
        PMs.clear();
      }

      setState(() {
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
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              labelText: 'Judul mengandung kata:',
            ),
            onFieldSubmitted: (value) {
              _txtcari = value;
              PMs.clear();
              bacaData();
            },
          ),
          SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: PMs.length > 0 ? DaftarPopMovie(PMs) : Text('Tidak ada data'),
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "popular-movie-add");
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> get myPFB {
    return <Widget>[
      ElevatedButton(
        onPressed: () {}, 
        child: const Icon(Icons.skip_previous),
      ),
      ElevatedButton(
        onPressed: () {}, 
        child: const Icon(Icons.skip_next)
      )
    ];
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
                    GestureDetector(
                      child: Text(
                        popMovs[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color.fromARGB(255, 53, 72, 82)
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPop(movieID: PMs[index].id),
                          ),
                        );
                      }),
                    const SizedBox(height: 14),
                    Text(
                      popMovs[index].overview,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: () {
                        addCart(PMs[index].id, PMs[index].title);
                      },
                      child: Text("Add to cart")
                    ),
                    const SizedBox(height: 4),
                  ],
                )
                : ListTile(
                    leading: const Icon(Icons.movie, size: 30),
                    title: GestureDetector(
                      child: Text(PMs[index].title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPop(movieID: PMs[index].id),
                          ),
                        );
                      }),
                    // subtitle: Text(popMovs[index].overview),
                    subtitle: Column(
                      children: [
                        Text(PMs[index].overview),
                        ElevatedButton(
                          onPressed: () {
                            addCart(PMs[index].id, PMs[index].title);
                          },
                          child: Text("Add to cart")
                        )
                      ]
                    ),
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
