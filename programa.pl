% Aquí va el código.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555



%PARCIAl SUENIOS}


% 1)
% Creer
cree(gabriel,campanita).
cree(gabriel,elMagoDeOz).
cree(gabriel,cavenaghi).
cree(juan,conejoDePascua).
cree(macarena,reyesMagos).
cree(macarena,elMagoCapria).
cree(macarena,campanita).

% Tipos de sueños
quiere(gabriel, ganarLoteria([5,9])).
quiere(gabriel, serFutbolista(arsenal)).
quiere(juan, serCantante(100000)).
quiere(macarena, serCantante(10000)).
quiere(santi, serCantante(600000)). % -> Prueba

persona(Persona):- quiere(Persona,_). % -> Persona que tiene suenio


%3
ambiciosa(Persona):-
    persona(Persona),
    findall(Dificultad,(quiere(Persona, Suenio), dificultad(Suenio, Dificultad)) ,Dificultades),
    sum_list(Dificultades, SumaDificultades),
    SumaDificultades > 20.

dificultad(serCantante(Num), 6):-   Num > 500000.
dificultad(serCantante(Num), 4):-   Num =< 500000.

dificultad(ganarLoteria(SerieNums), Dificultad):-  length(SerieNums, CantNums),     Dificultad is 10 * CantNums.
dificultad(serFutbolista(Equipo), 3):-              equipoChico(Equipo).
dificultad(serFutbolista(Equipo), 16):-             equipoGrande(Equipo).

equipoGrande(racing).
equipoChico(aldosivi).
equipoChico(arsenal).

%4

tieneQuimica(campanita,Persona):-
    cree(Persona,campanita),
    quiere(Persona, Suenio), dificultad(Suenio, Dificultad),
    Dificultad < 5.

tieneQuimica(Personaje,Persona):-
    cree(Persona,Personaje),
    Personaje \= campanita,
    todosLosSueniosPuros(Persona),
    not(ambiciosa(Persona)).

todosLosSueniosPuros(Persona):-
    %persona(Persona), no hace falta porq ya viene ligado
    forall(
        quiere(Persona,Suenio),     %para todo suenio
        suenioPuro(Suenio)          %es puro
    ).

suenioPuro(serFutbolista(_)).
suenioPuro(serCantante(Ventas)):- Ventas < 200000.








% 4)
amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).

amigo(conejoDePascua, cavenaghi).

enfermo(campanita).
enfermo(conejoDePascua).


puedeAlegrar(Personaje, Persona):-
    persona(Persona),
    tieneQuimica(Personaje, Persona),
    not(enfermo(Personaje)).

puedeAlegrar(Personaje,Persona):-
    persona(Persona),
    tieneQuimica(Personaje,Persona),
    personajeBackUp(Personaje, PersonajeBackup),
    not(enfermo(PersonajeBackup)).

personajeBackUp(Personaje1, Personaje2):-           %directo
    amigo(Personaje1, Personaje2).

personajeBackUp(Personaje1, Personaje2):-           %indirecto
    amigo(Personaje1, Personaje3),
    personajeBackUp(Personaje3, Personaje2).




