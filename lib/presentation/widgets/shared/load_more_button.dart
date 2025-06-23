import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation.dart';

class LoadMoreButton extends ConsumerStatefulWidget {
  final PageController pageController;
  final VoidCallback showArrowCallback;

  const LoadMoreButton({
    super.key,
    required this.pageController,
    required this.showArrowCallback,
  });

  @override
  LoadMoreButtonState createState() => LoadMoreButtonState();
}

class LoadMoreButtonState extends ConsumerState<LoadMoreButton> {

  Future<void> _loadMore() async {
    int currentPage = widget.pageController.page?.round() ?? 0;

    widget.showArrowCallback();

    if (currentPage == 0) {
      await ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
    } else {
      await ref.read( popularMoviesProvider.notifier ).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {

    final appTextTheme = Theme.of(context).textTheme;
    bool isPressed = false;
    
    return InkWell(
      onTap: () async {
        setState(() => isPressed = true); 
        await _loadMore();
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
          color: isPressed 
            // ignore: dead_code
            ? Colors.white.withValues( alpha: 0.2 ) 
            : Colors.transparent,
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