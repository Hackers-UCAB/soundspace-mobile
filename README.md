# SoundSpace Mobile

## Descripción
Aplicación frontend para app de streaming de música (SoundSpace)

## Instalación
```
# Limpiar las dependencias
$ flutter clean

# Cargar las dependencias
$ flutter pub get
```
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
| Aaron Palacios | Apoyo en Home & Album Page |

### Francis Bompart:
    Diseño de la estructura del proyecto en base a la arquitectura hexagonal, en conjunto con ciertos patrones de DDD 
    para la aplicacion de las reglas de negocio, ademas del uso de BLoC para el manejo del estado de la aplicacion. 
    Al establecer el flujo de comunicacion entre las capas y sus componentes se tomaron en cuenta principios y 
    tecnicas como SOLID, Dependency injection y patrones como Singleton.

    Participacion en la realizacion de multiples funcionalidades, sin embargo se resalta la implementacion del manejo 
    de excepciones, chequeo de la conexion a internet y la ubicacion del usuario, la navegacion en la aplicacion y 
    los permisos del usuario.

### Javier Molina:


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


### Aaron Palacios:
    Artist Detail BLoC Pattern Implementation
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
