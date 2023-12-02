habilidad(escupirAcido, 20).
habilidad(levitar, 0).
habilidad(escupirFuego, 30).
habilidad(camuflaje, 25).
habilidad(lanzarHielo, 40).
habilidad(resistenciaTermica, 30).
habilidad(cuerpoDeMetal,10).

%%dragon(Nombre, Tamanio, TamanioAlas, CantidadDisparos, Habilidad).
dragon(smaug, 20, 11, 4, camuflaje).
dragon(kalameet, 20, 7, 5, escupirAcido).
dragon(midir, 35, 22, 15, escupirFuego).
dragon(spyro, 3, 1, 1, levitar).
dragon(dragonite, 10, 14, 15, escupirFuego).
dragon(garchomp, 10, 2, 10, escupirFuego).

peligrosidad(Dragon, Peligrosidad) :- 
    dragon(Dragon, Tamanio, _, CantidadDisparos, Habilidad),
    habilidad(Habilidad, PuntajeHabilidad),
    Peligrosidad is Tamanio + PuntajeHabilidad + 3*CantidadDisparos.


categoria(Dragon,inofensivo) :- peligrosidad(Dragon, Peligrosidad), Peligrosidad =< 50.
categoria(Dragon,amenazante) :- peligrosidad(Dragon, Peligrosidad), Peligrosidad > 50, Peligrosidad =< 100.
categoria(Dragon,peligroso) :- peligrosidad(Dragon, Peligrosidad), Peligrosidad > 100.

vuela(Dragon) :- dragon(Dragon, Tamanio, TamanioAlas, _, Habilidad), (TamanioAlas > Tamanio/2 ; Habilidad = levitar).

masPeligroso(Dragon1, Dragon2) :-
    peligrosidad(Dragon1, Peligrosidad1),
    peligrosidad(Dragon2, Peligrosidad2),
    Peligrosidad1>Peligrosidad2.

elMasPeligroso(Dragon) :-
    dragon(Dragon, _, _, _, _),
    not((dragon(OtroDragon, _, _, _, _), OtroDragon \= Dragon, masPeligroso(OtroDragon, Dragon))).

rivales(Dragon1, Dragon2) :-
    dragon(Dragon1, _, _, _, Habilidad),
    dragon(Dragon2, _, _, _, Habilidad),
    Dragon1 \= Dragon2,
    categoria(Dragon1, Categoria),
    categoria(Dragon2, Categoria).

sePuedeDefender(cuerpoDeMetal,escupirAcido).
sePuedeDefender(resistenciaTermica,lanzarHielo).
sePuedeDefender(resistenciaTermica,escupirFuego).
sePuedeDefender(lanzarHielo,escupirFuego).
sePuedeDefender(escupirFuego,lanzarHielo).
sePuedeDefender(camuflaje,_).

presaFacil(Dragon1,Dragon2):-
    dragon(Dragon1, _, _, _, Habilidad1),
    dragon(Dragon2, _, _, _, Habilidad2),
    Dragon2\=Dragon1,
    masPeligroso(Dragon2,Dragon1),
    (sePuedeDefender(Habilidad2,Habilidad1);not(vuela(Dragon1))).

:- begin_tests(dragones).
test(la_peligrosidad_de_spyro_es_6):- peligrosidad(spyro,6).
:- end_tests(dragones).