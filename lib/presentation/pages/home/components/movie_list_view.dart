import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/domain/entities/movie.dart';
import 'package:movie_db_app/presentation/presentation.dart';

class MovieListView extends ConsumerWidget {

  final List<Movie> moviesProvider;

  const MovieListView({
    super.key, 
    required this.moviesProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView.builder(
      itemCount: moviesProvider.length,
      itemBuilder: (context, index) {
        return MovieItem(
          movie: moviesProvider[index]
        );
      },
    );
  }
}