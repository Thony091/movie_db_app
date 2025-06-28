

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/presentation/presentation.dart';

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

  @override
  Widget build(BuildContext context) {

    final appTextTheme = Theme.of(context).textTheme;
    bool isPressed = false;

    return InkWell(
      onTap: () async {
        setState(() => isPressed = true); 
        widget.showArrowCallback();
        await ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() => isPressed = false); 
      },
      borderRadius: BorderRadius.circular(13), 
      splashColor: Colors.white.withValues( alpha: 0.3 ), 
      highlightColor: Colors.white.withValues( alpha: 0.1 ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // ignore: dead_code
          color: isPressed ? Colors.white.withValues( alpha: 0.2 ) : Colors.transparent,
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