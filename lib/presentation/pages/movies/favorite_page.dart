import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/config/theme/app_theme.dart';

import '../../presentation.dart';

class FavoritePage extends ConsumerStatefulWidget {

  static const name = 'favorite-page';

  const FavoritePage({super.key});

  @override
  FavoritePageState createState() => FavoritePageState(); 
}

class FavoritePageState extends ConsumerState<FavoritePage> {

  bool isLastPage = false;
  bool isLoading = false;
  bool showArrowAnimation = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {

    if ( isLoading || isLastPage ) return;
    isLoading = true;

    final movies = await ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
    isLoading = false;

    if ( movies.isEmpty ) {
      isLastPage = true;
    }

  }
    
  void _showArrow() {
    setState(() {
      showArrowAnimation = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        showArrowAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final appTextTheme = Theme.of(context).textTheme;
    final appColorTheme = Theme.of(context).colorScheme;
    final favoriteMovies = ref.watch( favoriteMoviesProvider ).values.toList();

    if ( favoriteMovies.isEmpty ) {
      return Scaffold(
        backgroundColor: appColorTheme.secondary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 25 ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFavoriteAppBar( appTextTheme: appTextTheme ),
                    const SizedBox(height: 30),
                    Spacer(),
                    Center(
                      child: Column(
                        children: [
                          Icon( Icons.bookmark_outline_sharp, size: 60, color: appColorTheme.primary ),
                          Text('Ohhh no!!', style: appTextTheme.titleMedium),
                          Text('No tienes películas favoritas', style: appTextTheme.titleMedium),
                        ],
                      ),
                    ),
                    Spacer(),
                    const SizedBox(height: 80),
                  ],
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 86, 89, 96).withOpacity(0.8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () => context.go('/home'), 
        
                        icon: const Icon(
                          Icons.arrow_back, 
                          color: Colors.white,
                          size: 25,
                        ),
                        label: Text(
                          "Back",
                          style: appTextTheme.titleMedium
                        ),
                      ),
                    ],
                  ),
                ),
        
              ]
            ),
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 25),
          child: Stack(
            children: [
              Column(
                children: [
                  CustomFavoriteAppBar( appTextTheme: appTextTheme,),
                  SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        ListView.builder(
                          itemCount: favoriteMovies.length,
                          itemBuilder: (context, index) {
                            final movie = favoriteMovies[index];
                            return MovieItem(movie: movie);
                          },
                        ),
                        //Animated Arrow 
                        Positioned(
                          bottom: 5, 
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: showArrowAnimation ? 1.0 : 0.0,
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              shadows: [ 
                                Shadow( 
                                  color: Colors.green, 
                                  blurRadius: 20,
                                  offset: Offset(0, -5),
                                ) 
                              ],
                              size: 65,
                              color: Color(0xFF61C19C),
                            ),
                          ),
                        ),
                      ] 
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              // Load & back Buttons
              Positioned(
                bottom: 5,
                left: 0,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Visibility(
                      visible: favoriteMovies.length >= 10,
                      child: LoadMoreFavoriteButton( 
                        showArrowCallback: _showArrow, 
                      ),
                    ),

                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 86, 89, 96).withOpacity(0.8),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                      ),
                      onPressed: () {
                        context.go('/home');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back, 
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Back",
                            style: appTextTheme.titleMedium
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}

class CustomFavoriteAppBar extends StatelessWidget {

  final TextTheme appTextTheme ;

  const CustomFavoriteAppBar({
    super.key, 
    required this.appTextTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox( height: 50 ),
        Text(
          'Movie DB App', 
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
        SizedBox( height: 30 ),
        Text(
          'Your Watch List',
          style: appTextTheme.titleMedium, 
          textAlign: TextAlign.left,
        ),
      ],
      )
    );
  }
}


class LoadMoreFavoriteButton extends ConsumerStatefulWidget {

  final VoidCallback showArrowCallback;

  const LoadMoreFavoriteButton({
    super.key,
    required this.showArrowCallback,
  });

  @override
  LoadMoreFavoriteButtonState createState() => LoadMoreFavoriteButtonState();
}

class LoadMoreFavoriteButtonState extends ConsumerState<LoadMoreFavoriteButton> {


  Future<void> _loadMore( Future<void> favoriteMoviesNextPage ) async {
    widget.showArrowCallback();
    await favoriteMoviesNextPage;
  }

  @override
  Widget build(BuildContext context) {

    final favoriMoviesNextPage = ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
    final appTextTheme = Theme.of(context).textTheme;
    bool isPressed = false;

    return InkWell(
      onTap: () async {
        setState(() => isPressed = true); 
        await _loadMore( favoriMoviesNextPage);
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() => isPressed = false); 
      },
      borderRadius: BorderRadius.circular(13), 
      splashColor: Colors.white.withOpacity(0.3), 
      highlightColor: Colors.white.withOpacity(0.1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // ignore: dead_code
          color: isPressed ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "Load More",
          style: appTextTheme.titleMedium,
        ),
      ),
    );
  }
}