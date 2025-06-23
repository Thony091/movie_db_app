import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';


final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});



typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {
  
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;


  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]){
    loadNextPage();
  }

  Future<void> loadNextPage() async{
    if ( isLoading ) return;
    isLoading = true;

    currentPage++;
    try {
      final List<Movie> movies = await fetchMoreMovies( page: currentPage );
      if ( mounted ) {
        state = [...state, ...movies];
      }
      
    } finally {
      await Future.delayed(const Duration(milliseconds: 300));
      if ( mounted ) {
        isLoading = false;
      }
    }
    
  }


}

