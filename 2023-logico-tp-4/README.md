# TP-4: Functores y polimorfismo

## Pre-requisitos

Tener instalado [prolog](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/prolog/entorno.md).

## El enunciado: Profesiones mágicas

Queremos saber qué aptitudes tienen diferentes magos para diferentes profesiones, y en base a eso saber a cuales podrán dedicarse.

### Magos

Partimos de conocer los siguientes magos y sus fechas de nacimiento:

-  Harry Potter nació el 31/7/1980
-  Hermione Granger nació el 19/9/1979
-  Tom Riddle nació el 31/12/1926
-  Sirius Black nació el 3/11/1959
-  Peter Pettigrew nació el 1/9/1959
-  Ginny Weasley nació el 11/8/1981
-  Minerva McGonagall nació el 4/10/1935

Además, sabemos que Harry, Tom, Sirius, Ginny y Peter son de [sangre pura](https://harrypotter.fandom.com/es/wiki/Sangre_pura).

------------

### Aptitudes

Las aptitudes son características y logros que tienen diferentes magos, a las que cada profesión luego va a asignar alguna calificación. Las aptitudes que conocemos por ahora son 3:
- Notas que sacaron en materias
- Rendimiento jugando al quidditch
- Si son animagos o no

Sabemos que en las siguientes materias sacaron estas notas (si el nombre de alguien no aparece es porque no la cursó):

#### Notas

| Mago | Encantamiento | Historia Mágica | Defensa contra las artes oscuras |
| ---- | ----                             | ----          | -----           |
| Harry |  6 | 7 | 10 | 
| Tom  |  9 | 9 | 10 |
| Hermione  |  10 | 10 | 9 |
| Sirius  |  5 | 3 | 8 |
| Minerva  |  8 | 9 | 10 |
| Ginny  |  7 | 7 | 8 |
| Peter  |  4 | 6 | 2 |

#### Animagos

Sabemos que tanto Sirius como Peter son **animagos**.

#### Quidditch

De los únicos que conocemos sus puntajes en quidditch son:

| Mago | Partidos totales | Partidos ganados |
| ---- | ----        | ----- |
| Harry |  15 | 10 | 
| Ginny  |  20 | 15 |
| Peter  |  10 | 3 |

### Requerimientos

Teniendo en cuenta que los predicados principales tienen que ser inversibles y tener tests, lo que queremos poder consultar es:

**1)** La calificación, puntaje que cierta profesión asigna a cierto mago para cierta disciplina:
- para ser mortífago (que no es una profesión muy honrada):
  - haber cursado encantamientos tiene una calificación igual a la nota * 2.
  - haber cursado defensa contra las artes oscuras tiene una calificación de 20 + la nota si la nota es 10 o más, y de solo la nota en caso contrario.

- para ser auror:
  - haber cursado defensa contra las artes oscura tiene una calificación igual  a la nota * 7.
  - haber jugado al quidditch tiene una calificación igual a los partidos ganados / los partidos perdidos * 60.
  - ser un animago tiene una calificación igual a 40.

- el resto de las profesiones no tiene calificaciones para las aptitudes.

_Ejemplo: Harry tiene una calificación de 70 para Defensa Contra las Artes Oscuras, para ser auror. A su vez, tiene una calificación de 180 para Quidditch, para ser auror._

**2)** Queremos saber si un mago es apto para una profesión, sabiendo que:
- **Todas** las profesiones requieren haberse sacado mas de un 5 en historia magica. 
 
- Para ser apto para ser **mortífago** el mago tiene que tener alguna aptitud que le dé una calificación mayor o igual a 30 para esta profesión, ser sangre pura y haber nacido antes de 1960.

- Para ser apto para ser **auror** todas las aptitudes de auror del mago tienen que darle una clasificación mayor a 15.

- Para ser apto para ser **jugador** de quidditch tiene que haber ganado al menos la mitad de sus partidos

- Para ser apto para ser **adivinador** el mago tiene que tener una fecha de nacimiento donde la suma de su década + su mes + su día sea igual a 100.

_Nota: mod/2 les puede servir para relacionar un año con su década._

**3)** Si un mago está complicado, que sucede cuando no es apto para ninguna profesión.

**4)** Para que profesión se tiene un talento nato, que es aquella para la cual un mago tiene su calificación más alta (no hay que sumar, es la más alta entre todas sus aptitudes).

**5)** Si tiene un destino marcado, que se cumple si solamente tiene una sola profesion que para la que es apto.

--------------------------

Cuando terminen, creen un issue etiquetando a sus tutores así les llega una notificación y se corrigen y les dejan feedback ahí.
![](https://i.imgur.com/ypeXpBw.gif)
