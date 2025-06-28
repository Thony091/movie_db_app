// 🎯 Provider para manejar el estado del PageView
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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