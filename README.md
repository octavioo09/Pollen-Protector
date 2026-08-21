# Carbonara Studio
### Pollen Protector

Os presentamos nuestro proyecto de videojuego desarrollado para la asignatura de Videojuegos I de la Universidad de Alicante

Este juego ha sido desarrollado para jugarse en **GameBoy** en lenguaje Assemblyx86 .z80. Se trata de un juego de oleadas frenético en el que encarnarás la piel de una abeja que quiere defender su hermoso jardín de una invasión de insectos con ganas de comer flores. El juego cuenta con varios tipos de enemigos con diferentes comportamientos, un sistema de spawneo tanto de los enemigos como de las flores aleatorio y un sistema de puntuación final.

Technical & Design Overview
El primero de los objetivos era crear un juego teniendo en cuenta las restricciones de la GameBoy, pero sin que eso afectara a la jugabilidad del mismo. Como programador, fui el responsable de la creación de un sistema ECS desde cero específicamente diseñado para este lenguaje. Las características de este sistema es que es completamente escalable y super optimizado, permitiendo tener cientos de entidades simultaneamente sin afectar a la performance del juego. También creé un sistema de animaciones optimizado para mejorar visualmente el juego sin que se viera afectado y colaboré en la creación de un sistema de colisiones completo super optimizado y en el diseño y creación de la IA de los enemigos.

Key Systems & My Contributions
Nuestro juego sigue una arquitectura ECS (Entity Component System). In this data-driven structure, entities are collections of data, components store that data, and systems process it. Las partes más destacadas de este sistema son las siguientes:

Sistema ECS
    Scalability: este sistema permite la adición de nuevos proyectiles, nuevos tipos de enemigos o nuevos tipos de flores debido al uso de flags para el control de la creación de las entidades. Mediante estas flags, se                     utilizan plantillas de enemigos preescritas y se les da valores aleatorios para colocarlos en el mapa, de manera que no hay que modificar la estructura del sistema.
    Optimización: mediante la gestión de los tiempos de dibujado de la GameBoy, se cuenta la cantidad de entidades que hay en el mapa y a partir de esa cantidad se añade un controlador que aumenta o disminuye la cantidad de veces que se dibuja por pantalla, haciendo que la tasa de FPS sea estable sin afectar al renderizado del juego. Todo esto sumado a la gestión conjunta de todas las entidades hace que la optimización del sistema sea una de las cosas mas destacables del proyecto.

Sistema de animaciones

Sistema de IA

Additional Technical Features


Licensed under the MIT license.
