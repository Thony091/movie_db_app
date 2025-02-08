import '../domain.dart';

abstract class MoviesDatasource {

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });
  
  Future<Movie> getMovieById( String id );

  Future<List<Movie>> searchMovies( String query );

}