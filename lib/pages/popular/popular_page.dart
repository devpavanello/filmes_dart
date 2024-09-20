import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart';
import 'package:movie_app/pages/popular/widgets/popular_movie.dart';
import 'package:movie_app/services/api_services.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> moviesFuture;

  @override
  void initState() {
    moviesFuture = apiServices.getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: FutureBuilder<Result>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                            movieId: snapshot.data!.movies[index].id),
                      ),
                    );
                  },
                  child: PopularMovie(movie: snapshot.data!.movies[index]),
                );
              },
            );
          }
          return const Center(child: Text('No data found'));
        },
      ),
    );
  }
}
