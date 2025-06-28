import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/presentation/pages/home/components/custom_app_bar_home.dart';
import 'package:movie_db_app/presentation/pages/home/components/movie_list_view.dart';
import 'package:movie_db_app/presentation/presentation.dart';
import 'package:movie_db_app/presentation/providers/home/home_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key
  });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin {
  
  bool showArrowAnimation = false;
  final TextEditingController controller = TextEditingController();

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
    super.build(context);

    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final movieSuggestions = ref.watch(movieSuggestionsProvider);
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAppBarHome( controller: controller,),
                    if (movieSuggestions.isEmpty)
                      Expanded(
                        child: 
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            PageView(
                              controller: pageController,
                              onPageChanged: pageIndexNotifier.changePage,
                              children: [
                                MovieListView(moviesProvider: topRatedMovies),
                                MovieListView(moviesProvider: popularMovies),
                              ],
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
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
      
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),

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
                        visible: movieSuggestions.isEmpty, // Oculta el botón si hay sugerencias
                        child: LoadMoreButton(
                          pageController: pageController,
                          showArrowCallback: _showArrow,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF61C19C),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            minimumSize: const Size(150, 50),
                          ),
                          onPressed: () => context.push('/favorite-page'),
                          label: Text("Watch List", style: appTextTheme.labelLarge),
                          icon: Icon(Icons.bookmark, size: 30, color: appColorTheme.secondary),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

