import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

// Provider para manejar la película seleccionada
final searchedMovieProvider = StateProvider<Movie?>((ref) => null);

// Provider para manejar las sugerencias de búsqueda
final movieSuggestionsProvider = StateProvider<List<Movie>>((ref) => []);

class SearchBarWidget extends ConsumerStatefulWidget {
  final TextEditingController controller;

  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      ref.read(movieSuggestionsProvider.notifier).state = [];
      return;
    }

    final movies = await ref.read(movieRepositoryProvider).searchMovies(query);

    // Actualiza el estado con las sugerencias encontradas
    ref.read(movieSuggestionsProvider.notifier).state = movies;
  }

  void _selectMovie(Movie movie) {
    widget.controller.text = movie.title; // ✅ Rellena el input con la película seleccionada
    ref.read(searchedMovieProvider.notifier).state = movie; // ✅ Guarda la película en el estado
    ref.read(movieSuggestionsProvider.notifier).state = []; // ✅ Oculta la lista de sugerencias
  }

  void _confirmSearch() {
    final selectedMovie = ref.read(searchedMovieProvider);
    if (selectedMovie != null) {
      context.push('/home/movie/${selectedMovie.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final movieSuggestions = ref.watch(movieSuggestionsProvider) ;
    final selectedMovie = ref.watch(searchedMovieProvider);
    final isButtonDisabled = selectedMovie == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: _searchMovies,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Colors.white
                  ),
                  hintText: "Search Here ...",
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.15),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 30),
            SizedBox(
              width: 55,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonDisabled
                      ? Colors.white.withValues(alpha: 0.1) // 🔴 Desactivado si no hay película seleccionada
                      : Colors.white.withValues(alpha: 0.15),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: isButtonDisabled ? null : _confirmSearch, // ✅ Solo funciona si hay película seleccionada
                child: const Center(
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // 📌 Lista de sugerencias de películas
        if (movieSuggestions.isNotEmpty)
          ConstrainedBox(
            constraints: BoxConstraints( maxHeight: MediaQuery.of(context).size.height * 0.45),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                shrinkWrap: true, // ✅ Evita que la lista crezca indefinidamente
                itemCount: movieSuggestions.length,
                itemBuilder: (context, index) {
                  final movie = movieSuggestions[index];
                  return GestureDetector(
                    onTap: () => _selectMovie(movie), 
                    child: FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), 
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.16,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage(
                                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                                  image: movie.posterPath.isEmpty
                                      ? const AssetImage('assets/images/no-image.jpg') as ImageProvider
                                      : NetworkImage(movie.posterPath),
                                  height: 100,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/no-image.jpg',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title, 
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: movie.title.length > 30
                                        ? 13
                                        : 16,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  ( movie.overview.length > 100 )
                                    ? Text( '${movie.overview.substring(0,100)}...', 
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ) 
                                      )
                                    : Text( movie.overview.isEmpty
                                          ? 'No overview available' 
                                          : movie.overview,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ) 
                                      ),
                                ]
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
