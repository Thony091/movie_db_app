
import 'package:go_router/go_router.dart';
import '../../presentation/pages/pages_container.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    
    GoRoute(
      path: '/home',
      name: HomePage.name,
      builder: (context, state) =>  HomePage( ) ,
      routes: [
         GoRoute(
          path: 'movie/:id',
          name: MoviePage.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MoviePage( movieId: movieId );
          },
        ),
      ]
    ),

    GoRoute(
      path: '/favorite-page',
      name: FavoritePage.name,
      builder: (context, state) => FavoritePage(),
    ),


    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    ),

  ]
);