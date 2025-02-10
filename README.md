# Movie DB App - Application Overview
This project is create with fflutter sdk version 3.27.1.

To avoid compilation problems you must have Java 17 installed

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

## Guia para ejecución del proyecto Android

1️⃣ Requisitos previos: 
Antes de empezar, asegúrate de tener instaladas las siguientes herramientas:

|   Herramienta   	|    Versión Requerida  	|       Descargar           |
|   Flutter	        |         3.27.1          |       flutter.dev         |
|   Android Studio	|    Última versión       |  	developer.android.com   |
|   Java JDK	      |           17	          |      oracle.com/java/     |


2️⃣ Descargar el proyecto Movie DB App:

Descarga el proyecto Movie DB App desde el repositorio de GitHub.

git clone https://github.com/Thony091/movie_db_app.git

3️⃣ Abrir el proyecto Movie DB App en Visual Studio Code.

4️⃣ Instalar las dependencias del proyecto:

Ejecutar el siguiente comando en la terminal para instalar las dependencias del proyecto:

- flutter pub get

5️⃣ Compilar y ejecutar el proyecto:

Ejecutar el siguiente comando en la terminal para compilar y ejecutar el proyecto:

- flutter run

Preguntara por el dispositivo Android con el que desea conectarse y se compilará y ejecutará el proyecto en el dispositivo especificado.

## Guia para generar un APK

Para generar un APK, ejecutar el siguiente comando en la terminal:

- flutter build apk

El archivo APK se generará en la carpeta build/app/outputs/apk/release/.


## Si Todo Falla: descargar el APK desde Github
Si no puedes ejecutar la app, puedes descargar el APK desde GitHub Releases.

📌 Enlace de descarga:

➡ [📥 Descargar última versión del APK](https://github.com/Thony091/movie_db_app/releases/tag/apk)


Instrucciones:

Ve al enlace de arriba.
Descarga el archivo app-release.apk.
Instálalo en tu dispositivo Android.


## No se Completo del Proyecto

- Logica para boton de la pagina favoritos, "load more",:
  - Limitar el numero de lista de videos cargadas por pagina
  - Implementar logica para que sea coherente con el boton de "load more" y su animacion de carga

- Logica para limpieza del buscador:
  - Limpiar el controlador de texto al transicionar entre distintas páginas.

- Reinicio de listas de peliculas en el home:
  - Implementar la limpieza de la lista del provider al salir de la pagina home.
