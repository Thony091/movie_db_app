import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';

class HomePage extends ConsumerStatefulWidget {

  static const name = 'home-page';

  const HomePage({
    super.key, 
  });

  @override
  HomePageState createState() => HomePageState();
}

//* Este Mixin es necesario para mantener el estado en el PageView
class HomePageState extends ConsumerState<HomePage> with AutomaticKeepAliveClientMixin {

  late PageController pageController;
  final TextEditingController controller = TextEditingController();
  bool showArrowAnimation = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final movieSuggestions = ref.watch(movieSuggestionsProvider) ?? [];
    final pageIndexNotifier = ref.watch(pageIndexHomeProvider.notifier);
    final pageController = pageIndexNotifier.pageController;

    final appTextTheme = Theme.of(context).textTheme;
    final appColorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: appColorTheme.secondary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric( horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CustomAppBarHome( controller: controller ),
      
                    // Movies List
                    Visibility(
                      visible: movieSuggestions.isEmpty,
                      child: Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PageView(
                              controller: pageController,
                              onPageChanged: (index) {
                                pageIndexNotifier.changePage(index);
                              },
                              children: [
                                MovieListView( moviesProvider: topRatedMoviesProvider ),
                                MovieListView( moviesProvider: popularMoviesProvider ),
                              ],
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
                    ),
      
                    SizedBox( height: 60, )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
        
            // 🔽 Botón "Load More" y "Watch List"
            Positioned(
              bottom: 5,
              left: 0,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
      
                    Visibility(
                      // visible: movieSuggestions.length,
                      child: LoadMoreButton(
                        pageController: pageController,
                        showArrowCallback: _showArrow,
                      ),
                    ),
      
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF61C19C),
                          foregroundColor: Colors.black, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () => context.go('/favorite-page'),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Watch List",
                              style: appTextTheme.labelLarge,
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.bookmark, 
                              size: 30, 
                              color: appColorTheme.secondary
                            ), 
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
        ),
      ),

    );
  }
  
  @override
  bool get wantKeepAlive => true;
}


class MovieListView extends ConsumerWidget {

  final StateNotifierProvider<MoviesNotifier, List<Movie>> moviesProvider;

  const MovieListView({
    super.key, 
    required this.moviesProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final movies = ref.watch( moviesProvider );

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieItem(
          movie: movies[index]
        );
      },
    );
  }
}

class _CustomAppBarHome extends ConsumerWidget {
  const _CustomAppBarHome({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final movieSuggestions = ref.watch(movieSuggestionsProvider) ?? [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        const SizedBox(height: 50),
    
        Text(
          'Movie DB App', 
          style: Theme.of(context).textTheme.headlineLarge
        ),
        
        SizedBox( height: 30 ),
        
        Text(
          'Find your movies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
        
        SizedBox( height: 20 ),
        SearchBarWidget(
          controller: controller, 
        ),
        
        SizedBox( height: 25 ),
        
        Visibility(
          visible: movieSuggestions.isEmpty,
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
          ),
        ),
        
        const SizedBox(height: 20),
        
        Visibility(
          visible: movieSuggestions.isEmpty,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CategoryButton(label: "Top Rated", index: 0,),
              _CategoryButton(label: "Popular", index: 1),
            ],
          ),
        ),
    
        
        const SizedBox(height: 30),
        
      ]
    );
  }
}


class _CategoryButton extends ConsumerWidget {
  final String label;
  final int index;

  const _CategoryButton({
    required this.label, 
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final pageIndexNotifier = ref.watch(pageIndexHomeProvider.notifier);
    final selectedIndex = ref.watch(pageIndexHomeProvider);
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        pageIndexNotifier.changePage(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
            ? const Color(0xFF61C19C) 
            : const Color.fromARGB(255, 86, 89, 96).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label, 
          style: TextStyle(
            color: !isSelected
              ?  Colors.white 
              :  Color(0xFF33373E)
          )
        ),
      ),
    );
  }
}


// 🎯 Provider para manejar el estado del PageView
final pageIndexHomeProvider = StateNotifierProvider<PageIndexNotifier, int>((ref) => PageIndexNotifier());

// 🎯 Notifier para manejar la lógica del índice de PageView
class PageIndexNotifier extends StateNotifier<int> {
  PageIndexNotifier() : super(0);

  final PageController pageController = PageController(initialPage: 0);

  void changePage(int index) {
    if (index != state) {
      state = index; // ✅ Cambiar el estado correctamente
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}