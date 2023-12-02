%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Sombrero Seleccionador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* CON LISTAS */

/*caracter(harry, [corajudo, amistoso, orgulloso, inteligente]).
caracter(draco, [orgulloso, inteligente]).
caracter(hermione, [responsable, orgulloso, inteligente]).*/

/*caracterApropiado(Casa, Mago) :-
    caracter(Mago, Caracteristicas),
    casa(Casa),
    forall(caracteristicas(Casa, SuCaracteristica), member(SuCaracteristica, Caracteristicas)).*/

/*tieneCaracteristica(Mago, Caracterisitica):-
    caracter(Mago, Caracteristicas),
    member(Caracteristica, Caracteristicas).*/

/*caracterApropiado(Casa, Mago) :-
    caracter(Mago, Caracteristicas),
    casa(Casa),
    forall(caracteristicas(Casa, SuCaracteristica), tieneCaracteristica(Mago, SuCaracteristica)).*/

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

mago(Mago):- sangre(Mago, _).

tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, amistoso).
tieneCaracteristica(harry, orgulloso).
tieneCaracteristica(harry, inteligente).

tieneCaracteristica(draco, orgulloso).
tieneCaracteristica(draco, inteligente).

tieneCaracteristica(hermione, responsable).
tieneCaracteristica(hermione, orgulloso).
tieneCaracteristica(hermione, inteligente).

odia(slytherin, harry).
odia(hufflepuff, draco).

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).

caracteristicas(gryffindor,coraje).

caracteristicas(slytherin,orgullo).
caracteristicas(slytherin, inteligencia).

caracteristicas(hufflepuff,amistoso).

caracteristicas(ravenclaw, responsabilidad).
caracteristicas(ravenclaw, inteligencia).

%permiteEntrar(Casa, Mago)
%%%%

permiteEntrar(Casa, Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.
permiteEntrar(slytherin, Mago):-
    casa(Casa),
    sangre(Mago, TipoDeSangre),
    TipoDeSangre \= impura.

caracterApropiado(Casa, Mago) :-
    casa(Casa),
    mago(Mago),
    forall(caracteristicas(Casa, SuCaracteristica), tieneCaracteristica(Mago, SuCaracteristica)).

casaSeleccionada(Casa, Mago) :-
    caracterApropiado(Casa, Mago),
    permiteEntrar(Casa, Mago),
    not(odia(Casa, Mago)).
casaSeleccionada(gryffindor, hermione).

cadenaDeAmistades(Magos) :-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago, Magos), amistoso(Mago)).

amistoso(Mago):- tieneCaracteristica(Mago, amistoso).

cadenaDeCasas([]).
cadenaDeCasas([_]).
cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    casaSeleccionada(Casa, Mago1),
    casaSeleccionada(Casa, Mago2),
    cadenaDeCasas([Mago2| MagosSiguientes]).


