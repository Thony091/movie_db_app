
import 'package:flutter/material.dart';
import 'package:movie_db_app/config/helpers/human_formats.dart';
import 'package:movie_db_app/domain/domain.dart';

class CustomTabView extends StatelessWidget {
  const CustomTabView({
    super.key,
    required this.appColorTheme,
    required this.movie,
  });

  final ColorScheme appColorTheme;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: appColorTheme.secondary,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0, 
                color: Colors.white, 
              ),
              insets: EdgeInsets.symmetric(horizontal: 0), 
            ),
            tabs: const [
              Tab(text: "About Movie"),
              Tab(text: "Reviews"),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 350,
            child: TabBarView(
              children: [
                // About Movie
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Overviews:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
    
                    // Release Date & Popularity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Release Date:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              HumanFormats.shortDate(movie.releaseDate),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
    
                    const SizedBox(height: 8),
    
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Average Rating:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              HumanFormats.number(movie.voteAverage), 
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
    
                        SizedBox(width: 110),
    
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Rate Count:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              movie.voteCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 0),
    
                      ]
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Popularity: ",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${movie.popularity}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
    
                      ]
                    )
                  ],
                ),
                // Reviews 
                const Center(
                  child: Text(
                    "No reviews available",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}