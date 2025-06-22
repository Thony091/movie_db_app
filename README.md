# MovieApp 🎬

Una aplicación de exploración de películas desarrollada en Flutter, diseñada para ofrecer una experiencia de usuario fluida y visualmente atractiva. La app permite a los usuarios descubrir películas populares, mejor valoradas, buscar títulos específicos y gestionar su propia lista de favoritos.

Construida siguiendo los principios de **Arquitectura Limpia**, con **Riverpod** para una gestión de estado reactiva y **Isar** para un almacenamiento local ultrarrápido.
<br>

## ✨ Características Principales

-   **🎞️ Exploración de Películas:** Navega a través de carruseles y listas paginadas de películas actualmente en cines, populares y mejor valoradas.
-   **❤️ Gestión de Favoritos:** Guarda tus películas preferidas para verlas más tarde. Los favoritos se persisten localmente gracias a la base de datos Isar.
-   **🔍 Búsqueda Inteligente:** Encuentra películas por su título con sugerencias en tiempo real mientras escribes.
-   **ℹ️ Detalles Completos:** Accede a una vista detallada para cada película con sinopsis, géneros, calificación, actores y más.
-   **📱 Interfaz de Usuario Moderna:** Disfruta de una UI pulida con animaciones fluidas (`animate_do`), transiciones suaves y un diseño responsivo.
-   **💾 Caché Local:** Las películas vistas y los favoritos se guardan localmente para una carga más rápida y acceso sin conexión.
<br>

## 🛠️ Arquitectura y Pila Tecnológica

Este proyecto sigue los principios de **Arquitectura Limpia** para separar las responsabilidades, mejorar la testeabilidad y facilitar el mantenimiento.

### Pila Tecnológica

| Categoría             | Tecnología / Paquete                                                                                                      | Propósito                                                   |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| **Framework**         | [Flutter](https://flutter.dev/) & [Dart](https://dart.dev/)                                                               | Desarrollo de UI multiplataforma de alto rendimiento.       |
| **Gestión de Estado** | [Riverpod](https://riverpod.dev/)                                                                                         | Gestión de estado reactiva, segura y escalable.             |
| **Base de Datos Local** | [Isar](https://isar.dev/)                                                                                                 | Base de datos NoSQL rápida y fácil de usar para persistencia. |
| **Navegación**        | [GoRouter](https://pub.dev/packages/go_router)                                                                            | Enrutamiento declarativo, manejo de URLs y deep linking.    |
| **Peticiones HTTP**   | [Dio](https://pub.dev/packages/dio)                                                                                       | Cliente HTTP para la comunicación con la API de TheMovieDB. |
| **UI y Animaciones**  | [animate_do](https://pub.dev/packages/animate_do), [card_swiper](https://pub.dev/packages/card_swiper)                      | Para crear interfaces visualmente atractivas e interactivas.  |
| **Variables de Entorno**| [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)                                                                 | Carga segura de claves de API y otras configuraciones.      |

<br>
<details>
<summary>📂 Estructura del Proyecto</summary>
   
```text
lib/
├── config/
│ ├── constants/ # Constantes y variables de entorno.
│ ├── router/ # Configuración de GoRouter.
│ └── theme/ # Temas de la aplicación.
│
├── domain/
│ ├── datasources/ # Contratos (interfaces) de los orígenes de datos.
│ ├── entities/ # Modelos de negocio puros.
│ └── repositories/# Contratos (interfaces) de los repositorios.
│
├── infrastructure/
│ ├── datasources/ # Implementación de los datasources (API, DB local).
│ ├── mappers/ # Convierten modelos de datos en entidades de dominio.
│ ├── models/ # Modelos de datos para la capa de infraestructura (DTOs).
│ └── repositories/# Implementación de los repositorios del dominio.
│
├── presentation/
│ ├── providers/ # Providers de Riverpod para el estado.
│ ├── screens/ # Pantallas de la aplicación.
│ └── widgets/ # Widgets reutilizables.
│
└── main.dart # Punto de entrada de la aplicación.
```  
</details>
<br>

## 🚀 Puesta en Marcha

Para ejecutar este proyecto localmente, sigue estos pasos:

### 1. Prerrequisitos

-   **Flutter SDK:** `^3.27.1`
-   **Java JDK:** `17`
-   Un emulador de Android/iOS o un dispositivo físico.

### 2. Clonar el Repositorio

```bash
git clone https://github.com/Thony091/movie_db_app.git
cd movie_db_app
```

### 3. Configurar Variables de Entorno
Este proyecto utiliza la API de TheMovieDB. Necesitas obtener una clave de API.
Crea un archivo .env en la raíz del proyecto.
Añade tu clave de API de TheMovieDB de la siguiente manera:
```bash
THE_MOVIEDB_KEY="AQUÍ_VA_TU_API_KEY"
```

### 4. Instalar Dependencias
```bash
flutter pub get
```

### 5. Generar Archivos de Código
Isar requiere la generación de archivos. Ejecuta el siguiente comando:
```bash
dart run build_runner build
```

### 6. Ejecutar la Aplicación
```bash
flutter run
```
<br>

## 📦 Generar APK
Para generar un APK para distribución, ejecuta:
```bash
flutter build apk --release
```

El APK se encontrará en build/app/outputs/flutter-apk/app-release.apk.
Si encuentras problemas, también puedes descargar la última versión desde la sección de Releases de este repositorio.

➡ [📥 Descargar última versión del APK](https://github.com/Thony091/movie_db_app/releases/tag/apk)

<br>

## 🗺️ Roadmap y Tareas Pendientes
Esta es una lista de funcionalidades y mejoras planeadas para el futuro:
 - Paginación en Favoritos: Implementar carga por lotes (load more) en la pantalla de favoritos para manejar grandes listas.
 - Limpieza de Estado: Limpiar el controlador de texto de búsqueda al navegar entre pantallas.
 - Reinicio de Listas: Reiniciar el estado de las listas de películas al salir y volver a la pantalla principal para asegurar datos frescos.
 - Tema Oscuro/Claro: Implementar un selector de tema para que el usuario pueda elegir.
 - Tests Unitarios y de Widgets: Añadir cobertura de pruebas para asegurar la calidad del código.
