# SoundSpace Mobile
<p align="center">
  <img src="./images/logo.png" width="200" alt="Descripción de la imagen" />
</p>

## Descripción
Aplicación frontend para app de streaming de música (SoundSpace)

## Instalación

# Limpiar las dependencias
$ flutter clean

# Cargar las dependencias
$ flutter pub get

# Ejecutar la aplicacion
Modo debug
$ flutter debug
Modo run
$ flutter run

## Diagrama arquitectura hexagonal

<p align="center">
  <img src="./documents/Diagrama Hexagonal Front Hackers Desarrollo SW-2.png" alt="Descripción de la imagen" />
</p>

##  <i>Project members <i>

- [Francis Bompart](https://github.com/fransbompart)
- [Javier Molina](https://github.com/jav1212)
- [Oriana Toubia](https://github.com/ovtoubia)
- [Jorge Esclasans](https://github.com/Jstarturo)
- [Gabriel Izaguirre](https://github.com/IzaeI)
- [Arturo Hung](https://github.com/ahungm)
- [Aaron Palacios](https://github.com/APalaciosQ)

## Contribuciones

| Miembros | Funcionalidad principal por pagina |
| -------- | -------- |
| Francis Bompart   | Home Page |
| Javier Molina   | Album Page & Artist Page |
| Oriana Toubia | Log In & Subscribe Page |
| Jorge Esclasans | Landing Page & Profile Page
| Gabriel Izaguirre | Search Page |
| Arturo Hung | Album Page |
| Aaron Palacios | Home & Artist Page |

### Francis Bompart:
    Diseño de la estructura del proyecto en base a la arquitectura hexagonal, en conjunto con ciertos patrones de DDD 
    para la aplicación de las reglas de negocio, además del uso de BLoC para el manejo del estado de la aplicación. 
    Al establecer el flujo de comunicación entre las capas y sus componentes se tomaron en cuenta principios y 
    técnicas como SOLID, Dependency Injection y patrones como Singleton.

    Participación en la realización de múltiples funcionalidades, sin embargo se resalta la implementación del manejo 
    de excepciones, chequeo de la conexión a internet y la ubicación del usuario, la navegación en la aplicación y 
    los permisos del usuario.

### Javier Molina:
    Diseño de la estructura del proyecto en base a la arquitectura hexagonal, en conjunto con ciertos patrones de DDD 
    para la aplicación de las reglas de negocio, además del uso de BLoC para el manejo del estado de la aplicación. 
    Al establecer el flujo de comunicación entre las capas y sus componentes se tomaron en cuenta principios y 
    técnicas como SOLID, Dependency Injection y patrones como Singleton.

    Participación en la realización de múltiples funcionalidades, sin embargo se resalta la 
    implementación del reproductor de música con just_audio, la integración de firebase y 
    local_notification para el apartado de notificaciones, implementación del client socket con 
    socketio, implementación de la lógica de streaming e implementación de las pantallas de álbum/playlist 
     y artista con sus respectivos BLoCs.

### Oriana Toubia:
    Log In & Subscribe Page
            - Domain:
                - User entity
                - User repository 
            - Application:
                - Subscribe use case
                - Log in use case
                - Log in BLoC
                - Subscribe BLoC
            - Infrastructure
                - User Mapper
                - User Repository implementation
                - Log in & subscribe screen and widgets
            
    Otros:
    Apoyo en validación de ubicación de usuario, Widgets de landing page, diseño y creación de logo y splash screen, creación de íconos.

### Jorge Esclasans:
    Profile Page
            - Domain:
                - User entity all attributes
                - User repository 
            - Application:
                - Get User Profile Data use case
                - Save User Profile Data use case
                - User BLoC 
            - Infrastructure
                - User Mapper
                - User Repository implementation
                - Landing Page BLoCless screen & widgets
                - Profile Page screen & widgets

### Gabriel Izaguirre:
    Search Page
            - Domain:
                - Search service with entities by name
            - Application:
                - Search BLoC
            - Infrastructure
                - Search Service with entities by name
                - Search Page screen and widgets

    Otros:
    Apoyo en el debuggeo del search page y del music player.

### Arturo Hung:
    Album Detail
            - Domain:
                - Album entity
                - Promotional Banner entity
                - Album repository
                - Promotional Banner repository
            - Application:
                - Get Album Data use case
                - Get Albums By Artist use case
                - Get Trending Albums use case
                - Get Promotional Banner use case
                - Album Detail BLoC:
                    - Album Detail BLoC
                    - Album Detail Event
                    - Album Detail State
            - Infrastructure
                - Album Mapper
                - Promotional Banner Mapper
                - Album Repository implementation
                - Promotional Banner Repository implementation
                - Album Detail widgets

### Aaron Palacios:
    Artist Detail
            - Domain:
                - Song entity
                - Playlist entity
                - Song repository
                - Playlist repository
            - Application:
                - Song use case
                - Playlist use case
                - Artist Detail BLoC:
                    - Artist Detail BLoC
                    - Artist Detail Event
                    - Artist Detail State
            - Infrastructure
                - Song Mapper
                - Playlist Mapper
                - Song Repository implementation
                - Playlist Repository implementation
