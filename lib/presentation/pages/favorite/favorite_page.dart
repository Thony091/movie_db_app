import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/presentation/pages/favorite/favorite_view.dart';

import '../../presentation.dart';

class FavoritePage extends ConsumerWidget {
  static const name = 'favorite-page';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isarAsyncValue = ref.watch(isarFutureProvider);

    return isarAsyncValue.when(
      
      data: (_) => const FavoriteView(),
      
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error al cargar la base de datos'),
              Text(error.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
