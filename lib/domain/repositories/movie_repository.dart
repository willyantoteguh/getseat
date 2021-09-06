part of 'repository.dart';

class MovieRepository {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=money&page=$page";

    client ??= http.Client();

    // try {} catch (error) {
    //   print(error);
    //   http.ClientException("message");
    // }
    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results']; // hanya ambil data result saja dari API
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'japanese';
        break;
      case 'id':
        language = 'indonesia';
        break;
      case 'ko':
        language = 'korea';
        break;
      case 'en':
        language = 'english';
        break;
    }

    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .take(8)
        .toList();
  }

  static Future<List<Movie>> searchMovies(String query,
      {http.Client client}) async {
    final String url =
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=money&page=1";
    client ??= http.Client();

    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results']; // hanya ambil data result saja dari API
    return result.map((e) => Movie.fromJson(e)).where((e) {
      final nameMovieLower = e.title.toLowerCase();

      final searchLower = query.toLowerCase();

      return nameMovieLower.contains(searchLower);
    }).toList();
  }
}
