import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/config/theme/app_theme.dart';
import 'package:movie_db_app/presentation/pages/favorite/components/custom_favorite_app_bar.dart';
import 'package:movie_db_app/presentation/pages/favorite/components/load_more_favorite_button.dart';
import 'package:movie_db_app/presentation/presentation.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({
    super.key
  });

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  bool isLastPage = false;
  bool isLoading = false;
  bool showArrowAnimation = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    setState(() => isLoading = true);

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    
    if (mounted) {
      setState(() {
        isLoading = false;
        if (movies.isEmpty) {
          isLastPage = true;
        }
      });
    }
  }

  void _showArrow() {
    setState(() => showArrowAnimation = true);
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() => showArrowAnimation = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final appColorTheme = Theme.of(context).colorScheme;
    
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty && !isLoading) {
      return Scaffold(
        backgroundColor: appColorTheme.secondary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFavoriteAppBar(appTextTheme: appTextTheme),
                    const SizedBox(height: 30),
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.bookmark_outline_sharp, size: 60, color: appColorTheme.primary),
                          Text('Ohhh no!!', style: appTextTheme.titleMedium),
                          Text('No tienes películas favoritas', style: appTextTheme.titleMedium),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 80),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, 
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 86, 89, 96).withAlpha(204),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () => context.go('/home/0'), 
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                        label: Text("Back", style: appTextTheme.titleMedium),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    // Si hay películas, muestra la lista.
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Stack(
            children: [
              Column(
                children: [
                  CustomFavoriteAppBar(appTextTheme: appTextTheme),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ListView.builder(
                          itemCount: favoriteMovies.length,
                          itemBuilder: (context, index) {
                            final movie = favoriteMovies[index];
                            return MovieItem(movie: movie);
                          },
                        ),
                        Positioned(
                          bottom: 5,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: showArrowAnimation ? 1.0 : 0.0,
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              shadows: [Shadow(color: Colors.green, blurRadius: 20, offset: Offset(0, -5))],
                              size: 65,
                              color: Color(0xFF61C19C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              Positioned(
                bottom: 5,
                left: 0,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isLastPage) 
                      LoadMoreFavoriteButton(showArrowCallback: _showArrow),
                    const Spacer(), 
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 86, 89, 96).withAlpha(204),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                      ),
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                      label: Text("Back", style: appTextTheme.titleMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
