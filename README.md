# Movie DB App - Descripción de la Aplicación

Este proyecto fue creado con **Flutter SDK versión 3.27.1**.

Para evitar problemas de compilación, debes tener **Java 17 instalado**.

The Movie DB App es una aplicación móvil desarrollada en **Flutter**, diseñada para los amantes del cine. Permite a los usuarios explorar, buscar y gestionar sus películas favoritas con una interfaz intuitiva y visualmente atractiva. La aplicación se integra con una API externa de base de datos de películas para obtener información en tiempo real.

---

## 🔹 Funcionalidades Principales

### 1️⃣ Visualización de Películas Populares y Mejor Valoradas
La aplicación cuenta con dos listas principales de películas:

- **Películas Populares**: Muestra las películas que están en tendencia entre los usuarios.
- **Películas Mejor Valoradas**: Muestra las películas con las calificaciones más altas basadas en reseñas de la audiencia y críticos.

📌 Los usuarios pueden alternar entre estas listas mediante **botones de categoría**, que también cambian visualmente al ser seleccionados.  
📌 Las listas son **paginadas**, lo que permite cargar más películas de forma dinámica al hacer clic en un botón.

---

### 2️⃣ Sistema de Favoritos
✔️ Los usuarios pueden guardar sus películas favoritas tocando un **icono de marcador**.  
✔️ Las películas guardadas se almacenan en una lista llamada **"Watch List"**.  
✔️ Esta lista es accesible desde el menú principal.  
✔️ El estado de las películas favoritas se mantiene **persistente** usando almacenamiento local.  

---

### 3️⃣ Búsqueda de Películas con Autocompletado
La aplicación incluye una barra de búsqueda donde los usuarios pueden buscar películas por título.  

🔹 Mientras el usuario escribe, aparecen **sugerencias en tiempo real** basadas en los datos existentes.  

✅ **Si se encuentra la película**:  
- Se **autocompleta** el campo de búsqueda al seleccionarla.  
- Al hacer clic en el **botón de búsqueda**, el usuario es redirigido a la página de detalles de la película.  

❌ **Si no hay coincidencias**, el botón de búsqueda se deshabilita.  

---

### 4️⃣ Vista de Detalles de la Película
Al hacer clic en una película, se abre una página con detalles completos, que incluyen:

- 📌 **Póster en alta resolución** y **imagen de fondo**.  
- 📌 **Título de la película** y una breve **sinopsis**.  
- 📌 **Géneros** representados como etiquetas.  
- 📌 **Fecha de estreno, calificación, popularidad y número de reseñas**.  
- 📌 **Pestañas** para "Acerca de la Película" y "Reseñas".  
- 📌 **Opción de agregar o eliminar la película de favoritos**.  
- 📌 **Botón de retroceso** para volver a la pantalla anterior.  

---

### 5️⃣ UI Suave e Interactiva
✔️ **Transiciones fluidas** entre las listas de películas populares y mejor valoradas con `PageView`.  
✔️ **Animaciones y efectos**:  
   - 📌 El botón **"Cargar Más"** muestra una **animación de flecha descendente** al hacer clic.  
   - 📌 El botón de búsqueda tiene **efectos de pulsación** para indicar interacción del usuario.  
✔️ **Manejo de estado eficiente con Riverpod** para garantizar una experiencia fluida.  

---

## 🔹 Cómo Funciona

1️⃣ **El usuario inicia la aplicación** → Se muestran las películas **Populares** por defecto.  
2️⃣ **El usuario cambia entre las listas de Populares y Mejor Valoradas** → Las películas se actualizan dinámicamente.  
3️⃣ **El usuario busca una película** → Aparecen sugerencias en tiempo real.  
4️⃣ **El usuario selecciona una película** → Se abre la pantalla de detalles con información completa.  
5️⃣ **El usuario guarda una película como favorita** → Se añade a la **Watch List**.  
6️⃣ **El usuario abre la Watch List** → Se muestran todas las películas favoritas guardadas.  
7️⃣ **El usuario carga más películas** → Se añaden dinámicamente a la lista.  

---

## 🔹 Tecnologías Utilizadas

✅ **Flutter (Dart)** → Para el desarrollo de la interfaz de usuario.  
✅ **Riverpod** → Para la gestión del estado.  
✅ **GoRouter** → Para la navegación y deep linking.  
✅ **Integración con API** → Para obtener datos de películas en tiempo real.  
✅ **Almacenamiento local** → Para guardar películas favoritas de forma persistente.  

---

## 🔹 Resumen

📌 The Movie DB App es una aplicación interactiva para explorar películas **populares y mejor valoradas**, realizar **búsquedas inteligentes con autocompletado**, guardar películas como favoritas y ver información detallada con una **interfaz elegante y responsiva**. 🎬📱  

---

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
  - Destruir el widget para que se reinicie los estados de pagina al volver.
