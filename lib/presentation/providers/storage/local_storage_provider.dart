import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:movie_db_app/domain/datasources/local_storage_datasource.dart';
import 'package:movie_db_app/domain/entities/movie.dart';
import 'package:movie_db_app/domain/repositories/local_storage_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../../../infrastructure/infrastructure.dart';

final isarFutureProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  
  if (Isar.instanceNames.isEmpty) {
    return await Isar.open(
      [MovieSchema], 
      inspector: true, 
      directory: dir.path,
    );
  }

  return Isar.getInstance()!;
});

final localStorageProvider = Provider<LocalStorageDatasource>((ref) {

  final isarAsync = ref.watch(isarFutureProvider);

  return isarAsync.when(
    data: (isar) => IsarDatasource(isar), 
    loading: () => throw UnimplementedError('Isar is still loading'),
    error: (e, s) => throw UnimplementedError('Failed to initialize Isar: $e'),
  );
});

final localStorageRepositoryProvider = Provider<LocalStorageRepository>((ref) {
  return LocalStorageRepositoryImpl(ref.watch(localStorageProvider));
});