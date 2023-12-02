:- use_module(begin_tests_con).

%traductor(nombre,rubro,[idiomas o conocimientos] ) referencia
traductor(juani, literario, [ingles, espanol]).
traductor(juanFdS, tecnico, [ingles, espanol]).
traductor(juanFdS, tecnico, [ingles, espanol]).
traductor(juanFdS, publico, [ingles, espanol]).
traductor(tomi, publico, [frances, espanol]).
traductor(emi, literario, [aleman, espanol, frances]).

habilidadesTecnicas(juanFdS, [biologia, fisica]).

idiomasQueManeja(juani,[ingles, espanol]).
idiomasQueManeja(juanFdS,[ingles, espanol]).
idiomasQueManeja(tomi,[frances, espanol]).
idiomasQueManeja(emi,[aleman, espanol, frances]).


%obra(nombre,idioma,año,categoria) referencia
obra(la_tempestad, ingles, 1611, categoria(literaria,350)).
obra(las_bicis_del_sol, espanol, 1992, categoria(literaria,10)).
obra(los_miserables, frances, 1862, categoria(literaria,1090)).
obra(las_dos_torres, ingles, 1954, categoria(literaria,352)).
obra(la_montania_magica, aleman, 1924, categoria(literaria,25)).
obra(constitucion_eeuu, ingles, 1789,categoria(legales)).
obra(declaracion_derechos_hombre_y_del_ciudadano, frances, 1789,categoria(legales)).
obra(animales_extincion, ingles, 2010, categoria(papers, biologia, 3)).
obra(polinomios_cuanticos, frances, 1990, categoria(papers,matematica, 8)).
obra(herencia_mixines, ingles, 1990, categoria(papers, ciencias_computacion, 4)).

categoria(literaria,numero_hojas).
categoria(legales).
categoria(papers,campo,nivel).

%tradujo(nombre del traductor, nombre obra, idioma traducido).  referencia 
tradujo(juani, la_tempestad, espanol).
tradujo(juani, las_bicis_del_sol, ingles).
tradujo(emi, declaracion_derechos_hombre_y_del_ciudadano, aleman).
/*tradujo(emi, declaracion_derechos_hombre_y_del_ciudadano, Idioma) :-
    traductor(emi, _, Idiomas),
    member(Idioma, Idiomas).*/

tradujo(emi, declaracion_derechos_hombre_y_del_ciudadano, espanol).
tradujo(emi, la_montania_magica, espanol).  
tradujo(emi, la_montania_magica, frances).   
tradujo(emi, los_miserables, aleman).      
tradujo(emi, los_miserables, espanol).
tradujo(tomi, declaracion_derechos_hombre_y_del_ciudadano, espanol).
 

disponible_en_idioma(Obra, Idioma) :-
    obra(Obra, Idioma, _, _).
disponible_en_idioma(Obra, Idioma) :-
    tradujo(_, Obra, Idioma).

disponibleEnIdiomas(Obra, Idiomas) :-
    obra(Obra, Idioma, _, _),
    member(Idioma, Idiomas).
disponibleEnIdiomas(Obra, Idiomas) :-
    tradujo(_, Obra, Idioma),
    member(Idioma, Idiomas).

%punto 2

esidoneo(Traductor, Obra):-
    traductor(Traductor, _, Idiomas),
    disponibleEnIdiomas(Obra, Idiomas),
    cumple_requerimientos(Traductor, Obra).

cumple_requerimientos(Traductor, Obra) :-
    obra(Obra, _, _, categoria(legales)),
    traductor(Traductor,publico,_).
    
cumple_requerimientos(Traductor, Obra) :-
    obra(Obra, _, _, categoria(literaria,Hojas)),
    Hojas =< 10,
    traductor(Traductor,_,_).

cumple_requerimientos(Traductor, Obra) :-
    obra(Obra, _, _, categoria(literaria,Hojas)),
    Hojas > 10,
    traductor(Traductor,literario,_).

cumple_requerimientos(Traductor, Obra) :-
    obra(Obra, _, _, categoria(papers,Campo,Nivel)),
    traductor(Traductor,tecnico,Idiomas),
    habilidadesTecnicas(Traductor, Diciplinas),
    member(Campo, Diciplinas).

cumple_requerimientos(Traductor, Obra) :-
    obra(Obra, _, _, categoria(papers,Campo,Nivel)),
    Nivel<5,
    traductor(Traductor,tecnico,_).
      
% punto 3 

sospechoso(Traductor, Obra) :-
    tradujo(Traductor,Obra,_),
    not(esidoneo(Traductor, Obra)).

esAntigua(Obra) :-
    obra(Obra, _, Anio, _),
    Anio =< 2023 - 50.

anticuado(Traductor) :-
    traductor(Traductor, _, _),
    tradujo(Traductor,_,_),
    forall(tradujo(Traductor, Obra, _), esAntigua(Obra)).

copion(Traductor, OtroTraductor) :-
    traductor(Traductor,_,Idiomas),
    traductor(OtroTraductor,_,Idiomas2),
    forall(
        (tradujo(Traductor, Obra, Idioma), Traductor \= OtroTraductor),
        (tradujo(OtroTraductor, Obra, Idioma))).
    
%punto 4

experienciaObra(Obra, Experiencia) :-
    obra(Obra, _, Anio, _),
    Experiencia is 3 + ((2023 - Anio)/ 100).

experienciaTraductor(Traductor, ExperienciaTotal) :-
    traductor(Traductor, _, _),
    findall(ExperienciaObra, (tradujo(Traductor, Obra, _), experienciaObra(Obra, ExperienciaObra)), Experiencias),
    sum_list(Experiencias, ExperienciaTotal).

:- begin_tests_con(tpIntegrador, []).

:- end_tests(tpIntegrador).
