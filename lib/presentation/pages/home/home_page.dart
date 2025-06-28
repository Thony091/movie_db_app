import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/presentation/pages/home/home_view.dart';

import '../../presentation.dart';


class HomePage extends ConsumerWidget {
  static const name = 'home-page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isarAsyncValue = ref.watch(isarFutureProvider);

    return isarAsyncValue.when(
      data: (_) => const HomeView(),

      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Error al inicializar la app: $error'),
        ),
      ),
    );
  }
}



