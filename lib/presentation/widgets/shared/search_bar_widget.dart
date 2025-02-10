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
    ref.read(movieSuggestionsProvider.notifier).state = movies ?? [];
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
    final movieSuggestions = ref.watch(movieSuggestionsProvider) ?? [];
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
                  fillColor: Colors.white.withOpacity(0.15),
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
                      ? Colors.white.withOpacity(0.1) // 🔴 Desactivado si no hay película seleccionada
                      : Colors.white.withOpacity(0.15),
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
            constraints: BoxConstraints( maxHeight: MediaQuery.of(context).size.height * 0.5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                shrinkWrap: true, // ✅ Evita que la lista crezca indefinidamente
                itemCount: movieSuggestions.length,
                itemBuilder: (context, index) {
                  final movie = movieSuggestions[index];
                  return ListTile(
                    title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                    onTap: () => _selectMovie(movie), // ✅ Selecciona la película al hacer clic
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
