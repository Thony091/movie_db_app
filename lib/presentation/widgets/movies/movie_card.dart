import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/helpers/human_formats.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

class MovieItem extends ConsumerWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appTextTheme = Theme.of(context).textTheme;
    final appColorTheme = Theme.of(context).colorScheme;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return Card(
      color: appColorTheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: appColorTheme.secondary,
          width: 1
        )
      ),
      margin: const EdgeInsets.symmetric( vertical: 8),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  width: 120,
                  height: 150,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'), 
                  image: NetworkImage(movie.posterPath)
                ),
              ),
          
              const SizedBox(width: 25),
          
              // Information
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox( height: 3 ),
                      Text(
                        'Title:', 
                        style: appTextTheme.titleSmall,
                      ),
                      Text(
                        movie.title, 
                        style: appTextTheme.bodySmall,
                        maxLines: 3,
                      ),
                      Spacer(),
                      Text(
                        "Release Date:", 
                        style: appTextTheme.titleSmall
                      ),
                      Text( 
                        HumanFormats.shortDate(movie.releaseDate), 
                        style: appTextTheme.bodySmall
                      ),
                      Spacer(),
                      Text(
                        "Average Rating: ", 
                        style: appTextTheme.titleSmall
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage ),
                        style: appTextTheme.bodySmall
                      ),
                      SizedBox( height: 3 ),
                    ],
                  ),
                ),
              ),
          
              // Favorite Icon
              SizedBox(
                height: 150,
                child: Column(
                  children: [
                    IconButton(
                      icon: isFavoriteFuture.when(
                        loading: () => const CircularProgressIndicator(strokeWidth: 2 ),
                        data: (isFavorite) => isFavorite
                          ? const Icon( Icons.bookmark, color: Colors.greenAccent, size: 40 )
                          : const Icon( Icons.bookmark, color: Colors.white, size: 40, ), 
                        error: (_, __) => throw UnimplementedError(),
                      ),
                      onPressed: () async {
                        await ref.watch( favoriteMoviesProvider.notifier ).toggleFavorite(movie);
                        ref.invalidate( isFavoriteProvider(movie.id) );
                      }, 
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Read More Button
          Positioned(
            bottom: -11,
            right: 0,
            child: TextButton(
              onPressed: () => context.push('/home/movie/${ movie.id }'),
              child: Text(
                "Read More",
                style: appTextTheme.bodySmall?.copyWith(
                  color: const Color(0xFF61C19C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}