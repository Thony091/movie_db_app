# Movie DB App - Application Overview
This project is create with sdk version 3.27.1.

The Movie DB App is a Flutter-based mobile application designed for movie enthusiasts. It allows users to explore, search, and manage their favorite movies with an intuitive and visually appealing interface. The app integrates with an external movie database API to fetch real-time movie data.

🔹 Core Features

1️⃣ Display of Popular & Top-Rated Movies
The app features two primary movie lists:
Popular Movies: Displays the movies that are currently trending among users.
Top-Rated Movies: Shows the highest-rated movies based on audience and critic reviews.
Users can switch between these lists using category buttons, which also visually update when selected.
The lists are paginated, allowing users to load more movies dynamically by clicking a button.

2️⃣ Movie Favorites System
Users can save their favorite movies by tapping a bookmark icon.
Saved movies are stored in a "Watch List", which can be accessed from the main menu.
The state of favorite movies is maintained persistently using local storage.

3️⃣ Movie Search with Autocomplete Suggestions
The app includes a search bar where users can look for specific movies by title.
As users type, real-time suggestions appear based on existing movie data.
If a movie is found:
It autocompletes the search bar when selected.
Clicking the search button navigates the user to the selected movie's detail page.
If no movie matches the search, the search button is disabled.

4️⃣ Movie Detail View
Clicking on any movie opens a detailed movie page, which includes:
High-resolution poster and background image.
Movie title and a brief synopsis (overview).
Genres displayed as category chips.
Release date, rating, popularity, and review count.
Tabs for "About Movie" and "Reviews".
The ability to add/remove the movie from favorites.
A back button to return to the previous screen.

5️⃣ Smooth UI & Interactive Elements
Uses PageView for smooth transitions between "Popular" and "Top Rated" movie lists.
Animations and effects:
"Load More" button displays a downward arrow animation when clicked.
Search button shows press effects to indicate user interaction.
The app maintains smooth state management using Riverpod.

🔹 How It Works

1️⃣ User launches the app → Displays "Popular" movies by default.

2️⃣ User navigates between Popular & Top Rated lists → Movies update dynamically.

3️⃣ User searches for a movie → Suggestions appear, selection updates the input field.

4️⃣ User selects a movie → Opens the movie detail screen with information.

5️⃣ User saves a movie as a favorite → Added to the "Watch List".

6️⃣ User opens the Watch List → Displays all saved favorite movies.

7️⃣ User loads more movies → New movies dynamically append to the list.


🔹 Technologies Used

Flutter (Dart) for UI development.
Riverpod for state management.
GoRouter for navigation and deep linking.
API Integration to fetch real-time movie data.
Local storage for saving favorite movies persistently.

🔹 Summary

The Movie DB App is an interactive movie browsing application where users can explore Popular & Top Rated movies, perform intelligent search with autocomplete, save movies to favorites, and view detailed movie information in an elegant and responsive UI. 

## Change App Icon

- flutter pub run flutter_launcher_icons

## Change Splash Screen

- flutter pub run flutter_native_splash:create