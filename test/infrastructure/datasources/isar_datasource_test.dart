// test/datasources/isar_datasource_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:movie_db_app/domain/domain.dart';
import 'package:movie_db_app/infrastructure/datasources/isar_datasource.dart';

void main() {
  // Inicialización de Isar para el entorno de pruebas
  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  late Isar isar;
  late IsarDatasource datasource;

  // Se ejecuta antes de CADA prueba individual
  setUp(() async {
    // Abrimos una nueva instancia de Isar en memoria para cada prueba
    // El 'name' único asegura que cada test tenga su propia DB aislada
    isar = await Isar.open(
      [MovieSchema],
      directory: '', // Usar un directorio vacío para DB en memoria
      name: DateTime.now().toIso8601String(),
    );
    datasource = IsarDatasource(isar);
  });

  // Se ejecuta después de CADA prueba individual
  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });

  // Película de prueba que usaremos en varios tests
  final testMovie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'An overview',
    // ... completa con los demás campos requeridos
    adult: false,
    backdropPath: '',
    genreIds: [],
    originalLanguage: 'en',
    originalTitle: 'Test Movie',
    popularity: 10,
    posterPath: '',
    releaseDate: DateTime.now(),
    video: false,
    voteAverage: 5,
    voteCount: 100,
  );

  group('IsarDatasource Tests', () {

    test('toggleFavorite debe añadir una película si no existe', () async {
      // ACT: Llama al método para añadir la película
      await datasource.toggleFavorite(testMovie);

      // ASSERT: Verifica que la película ahora está en la base de datos
      final movieInDb = await isar.movies.get(testMovie.id);
      expect(movieInDb, isNotNull);
      expect(movieInDb!.title, 'Test Movie');

      // También prueba el método isMovieFavorite
      final isFavorite = await datasource.isMovieFavorite(testMovie.id);
      expect(isFavorite, isTrue);
    });

    test('toggleFavorite debe eliminar una película si ya existe', () async {
      // ARRANGE: Primero, inserta la película en la DB
      await isar.writeTxn(() => isar.movies.put(testMovie));

      // ACT: Llama al método toggleFavorite para eliminarla
      await datasource.toggleFavorite(testMovie);

      // ASSERT: Verifica que la película ya no está en la base de datos
      final movieInDb = await isar.movies.get(testMovie.id);
      expect(movieInDb, isNull);

      // También prueba el método isMovieFavorite
      final isFavorite = await datasource.isMovieFavorite(testMovie.id);
      expect(isFavorite, isFalse);
    });

    // test('loadMovies debe retornar la lista de películas favoritas', () async {
    //   // ARRANGE: Inserta varias películas
    //   final movie2 = Movie.fromJson(testMovie.toJson()..['id'] = 2);
    //   await isar.writeTxn(() async {
    //     await isar.movies.put(testMovie);
    //     await isar.movies.put(movie2);
    //   });
      
    //   // ACT
    //   final favoriteMovies = await datasource.loadMovies();

    //   // ASSERT
    //   expect(favoriteMovies.length, 2);
    //   expect(favoriteMovies.any((m) => m.id == 1), isTrue);
    //   expect(favoriteMovies.any((m) => m.id == 2), isTrue);
    // });

    //  test('loadMovies debe respetar el límite (limit) y el desplazamiento (offset)', () async {
    //   // ARRANGE: Inserta 3 películas
    //   final movie2 = Movie.fromJson(testMovie.toJson()..['id'] = 2);
    //   final movie3 = Movie.fromJson(testMovie.toJson()..['id'] = 3);
    //   await isar.writeTxn(() async {
    //     await isar.movies.put(testMovie);
    //     await isar.movies.put(movie2);
    //     await isar.movies.put(movie3);
    //   });
      
    //   // ACT: Pide solo 1 película, saltándose la primera
    //   final favoriteMovies = await datasource.loadMovies(limit: 1, offset: 1);

    //   // ASSERT
    //   expect(favoriteMovies.length, 1);
    //   expect(favoriteMovies.first.id, 2); // Debería ser la segunda película
    // });

  });
}