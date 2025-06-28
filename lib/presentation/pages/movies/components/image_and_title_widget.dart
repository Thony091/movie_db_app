
import 'package:flutter/material.dart';
import 'package:movie_db_app/domain/domain.dart';

class ImageAndTitleWidget extends StatelessWidget {
  const ImageAndTitleWidget({
    super.key,
    required this.movie,
    required this.appTextTheme,
  });

  final Movie? movie;
  final TextTheme appTextTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -90,
          left: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              image: movie!.posterPath.isEmpty
                  ? const AssetImage('assets/images/no-image.jpg') as ImageProvider
                  : NetworkImage(movie!.posterPath),
              width: 120,
              height: 160,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no-image.jpg',
                  width: 120,
                  height: 160,
                  fit: BoxFit.cover,
                );
              },
            ),                 
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 140, top: 10),
          child: Text(
            movie!.title,
            style: appTextTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}