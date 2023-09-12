# pdchallenge

Challenge creado para cumplir con la consigna del Mobile code challenge.

## Arquitectura
Model View View Model

## Unit Tests
Test sobre el parse del json de las respuestas y para validar que el ViewModel realice las llamadas a los repositorios.
No he utilizado ningún framework para realizar los Unit Tests.

UI Test para validar que la pantalla de inicio muestre el buscador y los characteres.

## Packages usados
Solo integré el package SDWebImage para demostrar como utilizar un paquete.

## Nota
No vi necesario utilizar un package para las llamadas a la API pero en caso de ser necesario podría agregarlo.

Implementé el buscador y favorito.

Utilicé Alloctions tool para estar seguro que todos los objetos son dealocados correctamente.

## Falta implementar
Más UI Tests

Unit Tests en caso de network error

