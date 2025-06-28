
import 'package:flutter/material.dart';

class CustomFavoriteAppBar extends StatelessWidget {

  final TextTheme appTextTheme ;

  const CustomFavoriteAppBar({
    super.key, 
    required this.appTextTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox( height: 50 ),
        Text(
          'Movie DB App', 
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
        SizedBox( height: 30 ),
        Text(
          'Your Watch List',
          style: appTextTheme.titleMedium, 
          textAlign: TextAlign.left,
        ),
      ],
      )
    );
  }
}
