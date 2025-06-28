import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/presentation/pages/movies/components/components_container.dart';


import '../../../domain/domain.dart';
import '../../presentation.dart';

class MoviePage extends ConsumerStatefulWidget {
  static const name = 'movie-page';
  final String movieId;

  const MoviePage({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MoviePage> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    final appTextTheme = Theme.of(context).textTheme;
    final appColorTheme = Theme.of(context).colorScheme;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(int.parse(widget.movieId)));

    if (movie == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Scaffold(
      backgroundColor: appColorTheme.secondary,
      body: Stack(
        children: [
          // 📌 Imagen de fondo con degradado
          PosterWidget(movie: movie),

          // 📌 Contenedor de contenido con imagen y título
          Positioned(
            top: MediaQuery.of(context).size.height * 0.27,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: appColorTheme.secondary,
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image & Title
                  ImageAndTitleWidget(
                    movie: movie, 
                    appTextTheme: appTextTheme
                  ),

                  const SizedBox(height: 30),

                  // 🎭 Genres
                  GenresWidget(
                    movie: movie, 
                    appColorTheme: appColorTheme
                  ),

                  const SizedBox(height: 10),

                  // Tabs "About Movie" y "Reviews"
                  CustomTabView(appColorTheme: appColorTheme, movie: movie),
                ],
              ),
            ),
          ),

          // 📌 Botones en la parte inferior
          BottomButtonsWidget(
            isFavoriteFuture: isFavoriteFuture, 
            ref: ref, 
            movie: movie, 
            appColorTheme: appColorTheme
          ),
        ],
      ),
    );
  }
}
