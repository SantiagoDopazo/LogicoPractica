% Relaciona Pirata con Tripulacion

tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).

tripulante(law, heart).
tripulante(bepo, heart).

tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto

impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy,baroqueWorks, 70000000).
impactoEnRecompensa(luffy,eniesLobby, 200000000).
impactoEnRecompensa(luffy,marineford, 100000000).
impactoEnRecompensa(luffy,dressrosa, 100000000).

impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).

impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).

impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).

impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).

impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).

impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).

impactoEnRecompensa(bepo,sabaody,500).

impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).

impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

eventoTripulacion(Evento, Tripulacion) :- 
    impactoEnRecompensa(Tripulante, Evento, _),
    tripulante(Tripulante, Tripulacion).

relacion(Tripulacion1, Tripulacion2, Evento) :-
    eventoTripulacion(Evento, Tripulacion1),
    eventoTripulacion(Evento, Tripulacion2),
    Tripulacion1 \= Tripulacion2.

quienSeDestacoMas(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, Recompensa),
    forall((impactoEnRecompensa(OtroTripulante, Evento, OtraRecompensa), Pirata \= OtroTripulante), Recompensa > OtraRecompensa).


pasoDesapercibido(Pirata, Evento):-
    tripulante(Pirata, Tripulacion),
    eventoTripulacion(Evento, Tripulacion),
    not(impactoEnRecompensa(Pirata, Evento, _)).

recompensaDePirata(Pirata, RecompensaActual):-
    tripulante(Pirata,_),
    findall(Recompensa, (impactoEnRecompensa(Pirata, _, Recompensa)), Recompensas),
    sum_list(Recompensas, RecompensaActual).

recompensaTotalDeTripulacion(Tripulacion, RecompensaTotal):-
    tripulante(_, Tripulacion),
    findall(RecompensaActual, (tripulante(Pirata,Tripulacion), recompensaDePirata(Pirata, RecompensaActual)), RecompensaTripulantes),
    sum_list(RecompensaTripulantes, RecompensaTotal).

todosLosPiratasSonTemibles(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata, Tripulacion), peligroso(Pirata)).

peligroso(Pirata):-
    recompensaDePirata(Pirata, Recompensa),
    Recompensa > 100000000.
peligroso(Pirata):- 
    comio(Pirata, Fruta),
    frutaPeligrosa(Fruta).

esTemible(Tripulacion):- todosLosPiratasSonTemibles(Tripulacion).
esTemible(Tripulacion):-
    recompensaTotalDeTripulacion(Tripulacion, RecompensaTotal),
    RecompensaTotal > 500000000.
    
comio(luffy, paramecia(gomugomu)).
comio(buggy, paramecia(barabara)).
comio(law, paramecia(opeope)).

comio(chopper, zoan(hitohito, humano)).
comio(lucci, zoan(nekoneko, leopardo)).

comio(smoker, logia(mokumoku)).

frutaPeligrosa(paramecia(opeope)).
frutaPeligrosa(zoan(_, Especie)):-
    esFeroz(Especie).
frutaPeligrosa(logia(_)).

esFeroz(leopardo).
esFeroz(lobo).
esFeroz(anaconda).

tripulacionDeAsfalto(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata, Tripulacion), comio(Pirata,_)).