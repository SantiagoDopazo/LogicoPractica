:- dynamic forall/1, forall/4.

seCreoEn(lisp, 1958).
seCreoEn(c,1972).
seCreoEn(prolog, 1972).
seCreoEn(smalltalk, 1980).
seCreoEn(erlang, 1986).
seCreoEn(haskell, 1990).
seCreoEn(java, 1995).
seCreoEn(javascript, 1996).
seCreoEn(scala, 2004).
seCreoEn(elm, 2012).
seCreoEn(wollok, 2015).

influencio(smalltalk, java).
influencio(smalltalk, scala).
influencio(smalltalk, javascript).
influencio(smalltalk, erlang).
influencio(smalltalk, wollok).
influencio(haskell, scala).
influencio(haskell, erlang).
influencio(haskell, elm).
influencio(java, scala).
influencio(java, wollok).
influencio(scala, wollok).
influencio(lisp, smalltalk).
influencio(lisp, haskell).
influencio(lisp, javascript).
influencio(lisp, scala).
influencio(lisp, erlang).
influencio(prolog, erlang).

paradigma(smalltalk, objetos).
paradigma(lisp, funcional).
paradigma(lisp, procedural).
paradigma(erlang, funcional).
paradigma(erlang, deActores).
paradigma(haskell, funcional).
paradigma(java, objetos).
paradigma(javascript, objetos).
paradigma(scala, objetos).
paradigma(scala, funcional).
paradigma(prolog, logico).
paradigma(wollok, objetos).
paradigma(elm, funcional).

funcionalidad(ordenSuperior, scala).
funcionalidad(ordenSuperior, erlang).
funcionalidad(ordenSuperior, haskell).
funcionalidad(ordenSuperior, lisp).
funcionalidad(ordenSuperior, elm).
funcionalidad(inmutabilidad, haskell).
funcionalidad(inmutabilidad, elm).
funcionalidad(lazyEvaluation, haskell).
funcionalidad(patternMatching, haskell).
funcionalidad(ordenSuperior, prolog).
funcionalidad(inversibilidad, prolog).
funcionalidad(patternMatching, prolog).
funcionalidad(envioDeMensajes, smalltalk).
funcionalidad(envioDeMensajes, java).
funcionalidad(anotaciones, java).
funcionalidad(anotaciones, scala).
funcionalidad(envioDeMensajes, wollok).
funcionalidad(envioDeMensajes, erlang).
funcionalidad(desestructuracion, erlang).
funcionalidad(desestructuracion, javascript).
funcionalidad(envioDeMensajes, javascript).
funcionalidad(envioDeMensajes, scala).

esPosterior(Lenguaje,OtroLenguaje) :-
    seCreoEn(Lenguaje,Fecha),
    seCreoEn(OtroLenguaje,OtraFecha),
    Lenguaje\=OtroLenguaje,
    Fecha>OtraFecha. 

esHibrido(Lenguaje) :-
    paradigma(Lenguaje,UnParadigma),
    paradigma(Lenguaje,OtroParadigma),
    UnParadigma\=OtroParadigma.

compartenParadigma(Lenguaje,OtroLenguaje,Paradigma) :-
    paradigma(Lenguaje,Paradigma),
    paradigma(OtroLenguaje,Paradigma),
    Lenguaje\=OtroLenguaje.

creoParadigma(Lenguaje,Paradigma) :-
    paradigma(Lenguaje, Paradigma),
    forall((paradigma(OtroLenguaje,Paradigma)), not(esPosterior(Lenguaje,OtroLenguaje))).

granInfluencia(LenguajeInfluyente) :-
    paradigma(LenguajeInfluyente,Paradigma),
    creoParadigma(LenguajeInfluyente,Paradigma).

granInfluencia(LenguajeInfluyente) :-
    paradigma(LenguajeInfluyente,_),
    forall((compartenParadigma(LenguajeInfluyente,LenguajeInfluenciado,_),esPosterior(LenguajeInfluenciado,LenguajeInfluyente)),influencio(LenguajeInfluyente,LenguajeInfluenciado)).

iconico(Lenguaje):-
    influencio(Lenguaje,_),
    granInfluencia(Lenguaje).

funcionalidadCentral(Funcionalidad,Paradigma):-
    paradigma(_,Paradigma),
    forall((paradigma(Lenguaje,Paradigma),compartenParadigma(Lenguaje,_,Paradigma)), funcionalidad(Funcionalidad,Lenguaje)).
    
funcionalidadExclusiva(Funcionalidad, Paradigma) :-
        paradigma(_, Paradigma), 
        funcionalidad(Funcionalidad,_),
        forall((paradigma(Lenguaje,_),not(esHibrido(Lenguaje)),compartenParadigma(Lenguaje,OtroLenguaje,Paradigma),Lenguaje\=OtroLenguaje),funcionalidad(Funcionalidad,Paradigma)).
 
esPuro(Lenguaje) :-
         paradigma(Lenguaje, Paradigma),
         not(esHibrido(Lenguaje)),
            forall((funcionalidad(Funcionalidad, Lenguaje)),funcionalidadCentral(Funcionalidad, Paradigma) ).

esPuro(haskell).    

:- begin_tests(tp3).
test(si_un_lenguaje_se_creo_despues_que_otro_es_posterior):- esPosterior(elm,haskell).
test(el_primer_lenguaje_que_se_creo_no_es_posterior_a_ningun_otro_lenguaje):- not(esPosterior(lisp,_)).

test(un_lenguaje_con_mas_de_un_paradigma_es_hibrido):- esHibrido(lisp).
test(un_lenguaje_con_un_solo_paradigma_no_es_un_lenguaje_hibrido):- not(esHibrido(smalltalk)).

test(java_y_javascript_comparten_paradigma_de_objetos):- compartenParadigma(java,javascript,objetos).
test(erlang_y_smalltalk_no_comparten_paradigma):- not(compartenParadigma(erlang,smalltalk,_)).

test(el_primer_lenguaje_que_tuvo_el_paradigma_de_objetos_es_su_creador):- creoParadigma(smalltalk,objetos).
test(el_primer_lenguaje_que_tuvo_el_paradigma_logico_es_su_creador):- creoParadigma(prolog,logico).
test(si_un_lenguaje_no_fue_el_primero_en_tener_su_paradigma_entonces_no_lo_creo):- not(creoParadigma(haskell,_)).

test(un_lenguaje_que_influencio_a_todos_los_posteriores_es_una_gran_influencia):- granInfluencia(haskell).

test(si_un_lenguaje_influencio_a_todos_los_lenguajes_posteriores_es_un_lenguaje_iconico):- iconico(haskell).
test(si_un_lenguaje_creo_un_paradigma_pero_no_influencio_a_un_lenguaje_posterior_no_es_un_lenguaje_iconico):- not(iconico(erlang)).

test(envioDeMensajes_es_una_funcionalidad_central_de_objetos):- funcionalidadCentral(envioDeMensajes,objetos).
test(lazyEvaluation_no_es_una_funcionalidad_central_de_funcional):- not(funcionalidadCentral(lazyEvaluation,funcional)).

test(inversibilidad_es_una_funcionalidad_exclusiva_de_logico):- funcionalidadExclusiva(inversibilidad,logico).
test(anotaciones_no_es_una_funcionalidad_exclusiva_de_objetos):- not(funcionalidadExclusiva(anotaciones,objetos)).
test(envioDeMensajes_no_es_una_funcionalidad_exclusiva_por_estar_en_dos_paradigmas):- not(funcionalidadExclusiva(envioDeMensajes,_)).

test(un_lenguaje_es_puro_cuando_no_es_hibrido_y_tiene_solo_funcionalidades_centrales):- esPuro(smalltalk).
test(haskell_es_un_lenguaje_puro):- esPuro(haskell).
test(un_lenguaje_hibrido_no_es_un_lenguaje_puro):- not(esPuro(erlang)).
:- end_tests(tp3).
