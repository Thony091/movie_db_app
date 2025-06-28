import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/presentation/pages/home/components/category_button.dart';
import 'package:movie_db_app/presentation/presentation.dart';

class CustomAppBarHome extends ConsumerWidget {
  const CustomAppBarHome({
    super.key, 
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final movieSuggestions = ref.watch(movieSuggestionsProvider) ;

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
              CategoryButton(label: "Top Rated", index: 0,),
              CategoryButton(label: "Popular", index: 1),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
      ]
    );
  }
}
