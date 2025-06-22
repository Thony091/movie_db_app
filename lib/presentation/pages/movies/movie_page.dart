import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/helpers/human_formats.dart';
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset(
                      'assets/loaders/bottle-loader.gif',
                      fit: BoxFit.cover,
                    );
                  },
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/no-image.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -90,
                        left: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage(
                            placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                            image: movie.posterPath.isEmpty
                                ? const AssetImage('assets/images/no-image.jpg') as ImageProvider
                                : NetworkImage(movie.posterPath),
                            width: 120,
                            height: 160,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/no-image.jpg',
                                width: 120,
                                height: 160,
                                fit: BoxFit.cover,
                              );
                            },
                          ),                 
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 140, top: 10),
                        child: Text(
                          movie.title,
                          style: appTextTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 🎭 Genres
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 10,
                        children: movie.genreIds.map((genre) {
                          return Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.transparent, 
                              ),
                            ),
                            label: Text(genre),
                            backgroundColor: appColorTheme.primary.withValues(alpha: 0.75),
                            labelStyle: const TextStyle(
                              color: Colors.white,  
                              fontSize: 13,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Tabs "About Movie" y "Reviews"
                  CustomTabView(appColorTheme: appColorTheme, movie: movie),
                ],
              ),
            ),
          ),

          // 📌 Botones en la parte inferior
          Positioned(
            bottom: 25,
            left: 25,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                  label: const Text("Back"),
                ),

                SizedBox(
                  height: 43,
                  width: 43,
                  child: FloatingActionButton(
                    backgroundColor: isFavoriteFuture.when(
                      loading: () => Colors.transparent,
                      data: (isFavorite) => isFavorite
                        ? const Color(0xFF61C19C)
                        : Colors.white.withValues(alpha: 0.15),
                      error: (_, __) => Colors.transparent,
                    ),
                    onPressed: () async { 
                      await ref.watch(favoriteMoviesProvider.notifier).toggleFavorite(movie); 
                      ref.invalidate(isFavoriteProvider(movie.id));
                    }, 
                    child: isFavoriteFuture.when(
                      loading: () => const CircularProgressIndicator(strokeWidth: 2),
                      data: (isFavorite) => isFavorite
                            ? Icon( Icons.bookmark, color: appColorTheme.secondary, size: 23 )
                            : const Icon( Icons.bookmark, color: Colors.white, size: 23, ), 
                      error: (_, __) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabView extends StatelessWidget {
  const CustomTabView({
    super.key,
    required this.appColorTheme,
    required this.movie,
  });

  final ColorScheme appColorTheme;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: appColorTheme.secondary,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0, 
                color: Colors.white, 
              ),
              insets: EdgeInsets.symmetric(horizontal: 0), 
            ),
            tabs: const [
              Tab(text: "About Movie"),
              Tab(text: "Reviews"),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 350,
            child: TabBarView(
              children: [
                // About Movie
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Overviews:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
    
                    // Release Date & Popularity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Release Date:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              HumanFormats.shortDate(movie.releaseDate),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
    
                    const SizedBox(height: 8),
    
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Average Rating:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              HumanFormats.number(movie.voteAverage), 
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
    
                        SizedBox(width: 110),
    
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Rate Count:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              movie.voteCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 0),
    
                      ]
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Popularity: ",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${movie.popularity}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
    
                      ]
                    )
                  ],
                ),
                // Reviews 
                const Center(
                  child: Text(
                    "No reviews available",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}