class PopMovie {
  int id;
  String title;
  String overview;
  String voteAverage;
  String url;

 PopMovie({required this.id, required this.title, required this.overview, required this.voteAverage, required this.url });

 factory PopMovie.fromJson(Map<String, dynamic> json) {
  return PopMovie(
   id: json['movie_id'] as int,
   title: json['title'] as String,
   overview: json['overview'] as String,
   voteAverage: json['vote_average'] != null ? json['vote_average'].toString() : '0.0',
   url: json["url"] != null ? json["url"].toString() : ""
  );
 }
}
