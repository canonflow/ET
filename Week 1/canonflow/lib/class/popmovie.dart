class PopMovie {
  int id;
  String title;
  String overview;
  String? homepage;
  String? release_date;
  int? runtime;
  String voteAverage;
  String url;
  List? genres;
  List? casts;
  List? scenes;

 PopMovie({
  required this.id, 
  required this.title, 
  required this.overview,
  required this.voteAverage, 
  required this.url,
  this.genres,
  this.casts,
  this.homepage,
  this.release_date,
  this.runtime,
  this.scenes
});

 factory PopMovie.fromJson(Map<String, dynamic> json) {
  return PopMovie(
   id: json['movie_id'] as int,
   title: json['title'] as String,
   overview: json['overview'] as String,
   voteAverage: json['vote_average'] != null ? json['vote_average'].toString() : '0.0',
   url: json["url"] != null ? json["url"].toString() : "",
   genres: json['genres'],
   casts: json['casts'],
   homepage: json['homepage'],
   release_date: json['release_date'],
   runtime: json['runtime'] as int,
   scenes: json['scenes']
  );
 }
}
