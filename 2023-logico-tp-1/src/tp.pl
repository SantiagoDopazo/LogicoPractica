
contador(roque).
ingeniera(ana).
abogada(cecilia).

honesto(ana).
honesto(roque).

ambicioso(roque).
trabajoPrevio(roque).
trabajoPrevio(cecilia).

puedeAndar(contaduria, Empleado) :- contador(Empleado), honesto(Empleado).
puedeAndar(ventas, Empleado) :- ambicioso(Empleado), trabajoPrevio(Empleado).
puedeAndar(ventas, lucia) :- true.

% PUNTO 2

asesino(Odiador, Victima) :-
    odia(Odiador, Victima),
    not(masRico(Odiador, Victima)).

viveEn(agatha, dreadbury).
viveEn(carnicero, dreadbury).
viveEn(charles, dreadbury).

% Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
odia(charles, Persona) :-
    viveEn(Persona, dreadbury),
    not(odia(agatha, Persona)).

% Agatha odia a todos los que viven en la mansión, excepto al carnicero.
odia(agatha, Persona) :-
    viveEn(Persona, dreadbury),
    Persona \= carnicero.

% El carnicero odia a las mismas personas que odia tía Agatha.
odia(carnicero, Persona) :-
    odia(agatha, Persona).

% Quien no es odiado por el carnicero y vive en la mansión, es más rico que tía Agatha.
masRico(Persona, agatha) :-
    viveEn(Persona, dreadbury),
    not(odia(carnicero, Persona)).

/*:- begin_tests(tp1).
test(un_contador_honesto_puede_trabajar_en_contaduria, nondet):-
    puedeAndar(roque, contaduria).
:- end_tests(tp1).*/
