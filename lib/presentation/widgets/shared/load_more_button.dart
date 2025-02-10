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


  Future<void> _loadMore( Future<void> topRatedNextPage, Future<void> popularNextPage ) async {
    int currentPage = widget.pageController.page?.round() ?? 0;

    widget.showArrowCallback();

    if (currentPage == 0) {
      await topRatedNextPage;
    } else {
      await popularNextPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topRatedNextPage = ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
    final popularNextPage = ref.read( popularMoviesProvider.notifier ).loadNextPage();
    final appTextTheme = Theme.of(context).textTheme;
    bool isPressed = false;
    return InkWell(
      onTap: () async {
        setState(() => isPressed = true); 
        await _loadMore( topRatedNextPage, popularNextPage );
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