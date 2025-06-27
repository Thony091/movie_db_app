import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_db_app/domain/entities/movie.dart';
import 'package:movie_db_app/infrastructure/infrastructure.dart';

import '../../mocks/mock_dio_client.mocks.dart';

void main() {
  group('Test Api MovieDB Datasource', (){

    late MoviedbDatasourceImpl dataSource;
    late MockDio mockDio;

    setUp((){
      mockDio = MockDio();
      dataSource = MoviedbDatasourceImpl(mockDio,);
    });
    
    //* --- Test Api MovieDB Datasource ---
    group('Debe recibir respuesta de MockApi', (){

      final mockApiResponse = {
        "page": 1,
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path1.jpg",
            "genre_ids": [28, 12],
            "id": 123,
            "original_language": "en",
            "original_title": "Popular Movie 1",
            "overview": "Overview 1",
            "popularity": 100.0,
            "poster_path": "/poster1.jpg",
            "release_date": "2023-01-01",
            "title": "Popular Movie 1",
            "video": false,
            "vote_average": 8.5,
            "vote_count": 1000
          }
        ],
        "total_pages": 1,
        "total_results": 1
      };

      //* --- Caso de Éxito ---
      test('Debe retornar una lista de peliculas populares cuando la respuesta es 200(éxito)', () async {
        // 1. ARRANGE: Prepara el mock para que responda a la llamada esperada.
        when(mockDio.get(
          '/movie/popular', 
          queryParameters: anyNamed('queryParameters'),
        ))
          .thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/movie/popular'),
            data: mockApiResponse, 
            statusCode: 200
          ));
        // 2. ACT: Llama al método que estás probando.
        final result = await dataSource.getPopular(page: 1);
        // 3. ASSERT: Verifica que el resultado es el esperado.
        expect(result, isA<List<Movie>>());
        expect(result.length, 1);
        expect(result.isNotEmpty, true);
        expect(result.isEmpty, false);
        expect(result.first.title, 'Popular Movie 1');
      });
      //* --- Caso de Falla ---
      test('Deberia lanzar una excepción si la llamada a la API(popular) falla', () async {
        when(mockDio.get(
          '/movie/popular', 
          queryParameters: {'page': 1}
        ))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: '/movie/popular'),
            response: Response(
              requestOptions: RequestOptions(path: '/movie/popular'),
              statusCode: 404,
              statusMessage: 'Not Found'
            )
          ));

        final call = dataSource.getPopular(page: 1);
        expect(() => call, throwsA(isA<Exception>()));
      });

      //* --- Caso de Éxito ---
      test('Debe retornar una lista de peliculas top rated cuando la respuesta es 200(éxito)', () async {
        when(mockDio.get(
          '/movie/top_rated', 
          queryParameters: anyNamed('queryParameters'),
        ))
          .thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/movie/top_rated'),
            data: mockApiResponse, 
            statusCode: 200
          ));

        final result = await dataSource.getTopRated(page: 1);
        expect(result, isA<List<Movie>>());
        expect(result.length, 1);
        expect(result.isNotEmpty, true);
        expect(result.isEmpty, false);
        expect(result.first.title, 'Popular Movie 1');

      });

      //* --- Caso de Falla ---
      test('Deberia lanzar una excepción si la llamada a la API(top rated) falla', () async {
        when(mockDio.get(
          '/movoie/top_rated',
          queryParameters: {'page': 1}
        ))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: '/movie/top_rated'), 
            response: Response(
              requestOptions: RequestOptions(path: '/movie/top_rated'), 
              statusCode: 404, 
              statusMessage: 'Not Found'
            )
          ));

        final call = dataSource.getTopRated(page: 1);
        expect(()=> call, throwsA(isA<Exception>));
      });

    });

    //* --- Test getMovieById para detalles de una película ---
    group('Test getMovieById para detalles de una película', () {
      const movieId = '123';

      final mockMovieDetailsResponse = {
        "adult": false,
        "backdrop_path": "/backdrop.jpg",
        "belongs_to_collection": null,
        "budget": 150000000,
        "genres": [
          {"id": 28, "name": "Action"},
          {"id": 12, "name": "Adventure"}
        ],
        "homepage": "https://www.testmovie.com",
        "id": 123,
        "imdb_id": "tt1234567",
        "original_language": "en",
        "original_title": "Test Movie Details",
        "overview": "An amazing test movie.",
        "popularity": 150.0,
        "poster_path": "/poster.jpg",
        "production_companies": [
          {"id": 1, "logo_path": null, "name": "Test Studios", "origin_country": "US"}
        ],
        "production_countries": [
          {"iso_3166_1": "US", "name": "United States of America"}
        ],
        "release_date": "2023-01-01",
        "revenue": 500000000,
        "runtime": 120,
        "spoken_languages": [
          {"english_name": "English", "iso_639_1": "en", "name": "English"}
        ],
        "status": "Released",
        "tagline": "A test tagline.",
        "title": "Test Movie Details",
        "video": false,
        "vote_average": 9.0,
        "vote_count": 2000
      };

      //* --- Caso de Éxito ---
      test('debe retornar un objeto Movie cuando la respuesta es 200 (éxito)', () async {
        when(mockDio.get('/movie/$movieId'))
          .thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/movie/$movieId'),
            data: mockMovieDetailsResponse,
            statusCode: 200,
          ));
        
        final result = await dataSource.getMovieById(movieId);

        expect(result, isA<Movie>());
        expect(result.id, 123);
        expect(result.title, 'Test Movie Details');
      });

      //* --- Caso de Falla ---
      test('debe lanzar una excepción cuando el código de estado no es 200', () async {
        when(mockDio.get('/movie/$movieId'))
          .thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/movie/$movieId'),
            statusCode: 404,
            statusMessage: 'Not Found',
          ));
        
        expect(() => dataSource.getMovieById(movieId), throwsA(isA<Exception>()));
      });
    });

    //* --- PRUEBAS PARA searchMovies ---
    group('searchMovies', () {
      const query = 'Inception';
      final mockSearchResponse = {
        "page": 1,
        "results": [
          {
            "id": 27205,
            "title": "Inception",
            "overview": "A thief who steals corporate secrets...",
            "poster_path": "/poster_inception.jpg",
            "release_date": "2010-07-15",
            "vote_average": 8.4,
            "adult": false,
            "backdrop_path": "/backdrop_inception.jpg",
            "genre_ids": [28, 878],
            "original_language": "en",
            "original_title": "Inception",
            "popularity": 200.0,
            "video": false,
            "vote_count": 30000
          }
        ],
        "total_pages": 1,
        "total_results": 1
      };

      //* --- Caso de Éxito con un query ---
      test('debe retornar una lista de películas cuando el query no está vacío y la llamada es exitosa', () async {
        when(mockDio.get(
          '/search/movie',
          queryParameters: {'query': query},
        )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/search/movie'),
          data: mockSearchResponse,
          statusCode: 200,
        ));

        final result = await dataSource.searchMovies(query);

        expect(result, isA<List<Movie>>());
        expect(result.isNotEmpty, true);
        expect(result.first.title, 'Inception');
      });

      //* --- Caso de Borde: query vacío ---
      test('debe retornar una lista vacía inmediatamente si el query está vacío', () async {
        // ARRANGE: No necesitamos configurar el mock, porque no se debe llamar a Dio.

        final result = await dataSource.searchMovies('');

        expect(result, isA<List<Movie>>());
        expect(result.isEmpty, true);
        
        // Verificamos que NUNCA se llamó a `dio.get`.
        verifyNever(mockDio.get(any, queryParameters: anyNamed('queryParameters')));
      });

      //* --- Caso de Éxito con respuesta vacía ---
      test('debe retornar una lista vacía si la búsqueda no encuentra resultados', () async {
        // 1. ARRANGE: Configuramos el mock para que devuelva una lista de resultados vacía.
        final emptyResponse = {
          "page": 1,
          "results": [],
          "total_pages": 1,
          "total_results": 0
        };

        when(mockDio.get(
          '/search/movie',
          queryParameters: {'query': 'unfindablemoviexyz'},
        )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/search/movie'),
          data: emptyResponse,
          statusCode: 200,
        ));

        final result = await dataSource.searchMovies('unfindablemoviexyz');

        expect(result, isA<List<Movie>>());
        expect(result.isEmpty, true);
      });
    });

  });
}