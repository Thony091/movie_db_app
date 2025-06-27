import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/config/constants/environment.dart';

import '../../../infrastructure/infrastructure.dart';

// Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey, 
      'language': 'en-US'
    }
  ));

  return MovieRepositoryImpl( MoviedbDatasourceImpl( dio,) );
});


