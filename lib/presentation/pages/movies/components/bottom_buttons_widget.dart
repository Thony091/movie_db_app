
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/domain/domain.dart';
import 'package:movie_db_app/presentation/presentation.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    super.key,
    required this.isFavoriteFuture,
    required this.ref,
    required this.movie,
    required this.appColorTheme,
  });

  final AsyncValue<bool> isFavoriteFuture;
  final WidgetRef ref;
  final Movie? movie;
  final ColorScheme appColorTheme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      left: 25,
      right: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
            label: const Text("Back"),
          ),
    
          SizedBox(
            height: 43,
            width: 43,
            child: FloatingActionButton(
              backgroundColor: isFavoriteFuture.when(
                loading: () => Colors.transparent,
                data: (isFavorite) => isFavorite
                  ? const Color(0xFF61C19C)
                  : Colors.white.withValues(alpha: 0.15),
                error: (_, __) => Colors.transparent,
              ),
              onPressed: () async { 
                await ref.watch(favoriteMoviesProvider.notifier).toggleFavorite(movie!); 
                ref.invalidate(isFavoriteProvider(movie!.id));
              }, 
              child: isFavoriteFuture.when(
                loading: () => const CircularProgressIndicator(strokeWidth: 2),
                data: (isFavorite) => isFavorite
                      ? Icon( Icons.bookmark, color: appColorTheme.secondary, size: 23 )
                      : const Icon( Icons.bookmark, color: Colors.white, size: 23, ), 
                error: (_, __) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
