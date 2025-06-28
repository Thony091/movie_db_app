
import 'package:flutter/material.dart';
import 'package:movie_db_app/domain/domain.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({
    super.key,
    required this.movie,
    required this.appColorTheme,
  });

  final Movie? movie;
  final ColorScheme appColorTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 10,
          children: movie!.genreIds.map((genre) {
            return Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.transparent, 
                ),
              ),
              label: Text(genre),
              backgroundColor: appColorTheme.primary.withValues(alpha: 0.75),
              labelStyle: const TextStyle(
                color: Colors.white,  
                fontSize: 13,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
