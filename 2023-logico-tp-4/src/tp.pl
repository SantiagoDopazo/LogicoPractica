nacimiento(harry_potter, fecha(31, 7, 1980)).
nacimiento(hermione_granger, fecha(19, 9, 1979)).
nacimiento(tom_riddle, fecha(31, 12, 1926)).
nacimiento(sirius_black, fecha(3, 11, 1959)).
nacimiento(peter_pettigrew, fecha(1, 9, 1959)).
nacimiento(ginny_weasley, fecha(11, 8, 1981)).
nacimiento(minerva_mcgonagall, fecha(4, 10, 1935)).

sangre_pura(harry_potter).
sangre_pura(tom_riddle).
sangre_pura(sirius_black).
sangre_pura(ginny_weasley).
sangre_pura(peter_pettigrew).

nota(harry_potter, encantamiento(6), historia_magica(7), defensa_contra_artes_oscuras(10)).
nota(tom_riddle, encantamiento(9), historia_magica(9), defensa_contra_artes_oscuras(10)).
nota(hermione_granger, encantamiento(10), historia_magica(10), defensa_contra_artes_oscuras(9)).
nota(sirius_black, encantamiento(5), historia_magica(3), defensa_contra_artes_oscuras(8)).
nota(minerva_mcgonagall, encantamiento(8), historia_magica(9), defensa_contra_artes_oscuras(10)).
nota(ginny_weasley, encantamiento(7), historia_magica(7), defensa_contra_artes_oscuras(8)).
nota(peter_pettigrew, encantamiento(4), historia_magica(6), defensa_contra_artes_oscuras(2)).

animagos(sirius_black).
animagos(peter_pettigrew).

puntaje_quidditch(harry_potter, partidos(partidos_totales(15), partidos_ganados(10))).
puntaje_quidditch(ginny_weasley, partidos(partidos_totales(20), partidos_ganados(15))).
puntaje_quidditch(peter_pettigrew, partidos(partidos_totales(10), partidos_ganados(3))).

% MORTIFAGO 

calificacion(mortifago, Mago, encantamientos, Calificacion) :-
    nota(Mago, _ , _, encantamiento(Nota)),
    Calificacion is Nota * 2.

%calificacion(mortifago, Mago, defensa_contra_artes_oscuras, Calificacion) :-
    %nota(Mago, _ , _, defensa_contra_artes_oscuras(Nota)),
    %(Nota >= 10 ->  Calificacion is 20 + Nota
    %;   Calificacion is Nota).

% AUROR 

calificacion(auror, Mago, defensa_contra_artes_oscuras, Calificacion) :-
    nota(Mago, _ , _, defensa_contra_artes_oscuras(Nota)),
    Calificacion is Nota * 7.

calificacion(auror, Mago, quidditch, Calificacion) :-
    puntaje_quidditch(Mago, partidos(partidos_ganados(Ganados), partidos_totales(Totales))),
    Totales > 0,
    Calificacion is (Ganados / Totales) * 60.

calificacion(auror, Mago, animagos, 40).

% ES MORTIFAGO 
es_apto(mortifago, Mago) :-
    calificacion(mortifago, Mago, _, Calificacion),
    Calificacion >= 30,
    sangre_pura(Mago),
    nacimiento(Mago, fecha(_,_, Anio)),
    AnioNacimiento < 1960.

% ES AUROR
es_apto(auror, Mago) :-
    calificacion(auror, Mago, _, Calificacion),
    Calificacion > 15,
    calificacion(auror, Mago, quidditch, CalificacionQuidditch),
    CalificacionQuidditch > 15.

% ES JUGADOR DE QUIDDITCH
es_apto(quidditch, Mago) :-
    puntaje_quidditch(Mago, partidos(partidos_ganados(Ganados), partidos_totales(Totales))),
    Ganados >= Totales / 2.

% ES ADIVINADOR
es_apto(adivinador, Mago) :-
    nacimiento(Mago, fecha(_,_, Anio)),
    Decada is Anio // 10,
    Suma is Decada + Mes + Dia,
    Suma =:= 100.

% QUE PROFESIONES ES APTO
es_apto(Profesion, Mago) :-
    calificacion(Profesion, Mago, _, _),
    requisitos_generales(Profesion, Mago).

%Requisitos generales para todas las profesiones
requisitos_generales(_, Mago) :-
    nota(Mago, _, historia_magica(Nota), _),
    Nota > 5.


:- begin_tests(tp4).

:- end_tests(tp4).
