%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 - La copa de las casas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

hizo(harry, fueraDeCama).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(harry, buenaAccion(60, ganarleAVoldemort)).


hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(seccionRestringida)).
hizo(hermion, buenaAccion(50, salvarASusAmigos)).
hizo(hermion, responderPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
hizo(hermion, responderPregunta(comoHacerLevitarUnaPluma, 25, flitwick)).

hizo(draco, irA(mazmorras)).

hizo(ron, buenaAccion(50, ganarAlAjedrezMagico)).

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(irA(Lugar), PuntajeQueResta):-
    lugarProhibido(Lugar, Puntos),
    PuntajeQueResta is Puntos * -1.
puntajeQueGenera(buenaAccion(Puntaje, _), Puntaje).
puntajeQueGenera(responderPregunta(_, Dificultad,snape), Puntos):-
    Puntos is Dificultad/2.
puntajeQueGenera(responderPregunta(_, Dificultad,Profesor), Dificultad):-
    Profesor \= snape.

hizoAlgunaAccion(Mago):- hizo(Mago,_).

hizoAlgoMalo(Mago):-
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntaje),
    Puntaje < 0.

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

esRecurrente(Accion):-
    hizo(Mago1, Accion),
    hizo(Mago2, Accion),
    Mago1 \= Mago2.

puntajeDeCasa(Casa, PuntajeTotal):-
    esDe(_, Casa),
    findall(Puntos, (esDe(Mago, Casa), hizo(Mago, Accion), puntajeQueGenera(Accion, PuntajeTotal)), ListaPuntos),
    sum_list(ListaPuntos, PuntajeTotal).
    
casaGanadora(Casa):-
    puntajeDeCasa(Casa, PuntajeMayor),
    forall((puntajeDeCasa(OtraCasa, PuntajeMenor), Casa\= OtraCasa), PuntajeMayor >  PuntajeMenor).
    