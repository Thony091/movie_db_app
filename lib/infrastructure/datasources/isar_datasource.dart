import 'package:isar/isar.dart';

import '../../domain/domain.dart';

class IsarDatasource extends LocalStorageDatasource {
  
  late Isar db;
  IsarDatasource(this.db);
  
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar =  db;

    final Movie? isFavoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    
    final isar =  db;

    final favoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    if ( favoriteMovie != null ) {
      // Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync( favoriteMovie.isarId! ));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));

  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    
    final isar =  db;

    return isar.movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }

}