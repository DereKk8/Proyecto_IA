% Estado: estado(Pos_Mono, Pos_Caja, EnCaja, Pos_Banana, Tiene_Banana)

% Definir el tamaño del mapa
tamano_mapa(10). 

% Mostrar el estado del juego
display_estado(estado(Pos, Caja, EnCaja, PosBanana, Banana), CostoTotal) :-
    tamano_mapa(Tamano),
    Tamano1 is Tamano - 1, 
    findall(X, between(0, Tamano1, X), Vector),
    (EnCaja = si -> reemplazar(Vector, Caja, 'X', Vec1) ;
     (reemplazar(Vector, Pos, 'M', Vec2), reemplazar(Vec2, Caja, 'C', Vec1))),
    reemplazar(Vec1, PosBanana, 'B', Vec3), % Colocar la banana en su posición real
    write(Vec3), write('  Estado: '), write(estado(Pos, Caja, EnCaja, PosBanana, Banana)),
    write('  Costo Total: '), write(CostoTotal), nl.

% Reemplazar un elemento en la lista
reemplazar([_|T], 0, X, [X|T]).
reemplazar([H|T], I, X, [H|R]) :- I > 0, I1 is I - 1, reemplazar(T, I1, X, R).

% Calcular heurística
heuristica(estado(Pos, Caja, EnCaja, PosBanana, Banana), H) :-
    (Banana = si -> H is 0 ;
     (EnCaja = no -> H is abs(Pos - Caja) ; H is abs(Caja - PosBanana))).

% Seleccionar la mejor acción a realizar
mejor_accion(estado(Pos, Caja, EnCaja, PosBanana, Banana), MejorAccion, Heuristica) :-
    (Banana = si -> MejorAccion = terminar, Heuristica = 0 ;
     (EnCaja = no ->
        (Pos < Caja -> MejorAccion = mover_derecha ; Pos > Caja -> MejorAccion = mover_izquierda ; MejorAccion = subir)
     ;
        (Caja < PosBanana -> MejorAccion = mover_caja_derecha ; MejorAccion = tomar_banana))),
    heuristica(estado(Pos, Caja, EnCaja, PosBanana, Banana), Heuristica).

% Ejecutar la acción seleccionada y mostrar el costo acumulado
ejecutar_accion(estado(Pos, Caja, EnCaja, PosBanana, Banana), CostoTotal) :-
    (Banana = si -> write('¡Objetivo alcanzado!'), nl, write('Costo Total Final: '), write(CostoTotal), nl ;
    write('---------------------------------------'), nl,
    mejor_accion(estado(Pos, Caja, EnCaja, PosBanana, Banana), MejorAccion, Heuristica),
    write('Acción seleccionada: '), write(MejorAccion),
    write(' | Heurística: '), write(Heuristica),
    write(' | Costo Acumulado: '), write(CostoTotal), nl,
    aplicar_accion(MejorAccion, estado(Pos, Caja, EnCaja, PosBanana, Banana), NuevoEstado, CostoMovimiento),
    NuevoCostoTotal is CostoTotal + CostoMovimiento,
    display_estado(NuevoEstado, NuevoCostoTotal),
    ejecutar_accion(NuevoEstado, NuevoCostoTotal)).

% Aplicar la acción seleccionada y devolver el costo del movimiento
aplicar_accion(mover_izquierda, estado(Pos, Caja, EnCaja, PosBanana, Banana), estado(NuevaPos, Caja, EnCaja, PosBanana, Banana), 1) :-
    NuevaPos is Pos - 1.

aplicar_accion(mover_derecha, estado(Pos, Caja, EnCaja, PosBanana, Banana), estado(NuevaPos, Caja, EnCaja, PosBanana, Banana), 1) :-
    NuevaPos is Pos + 1.

aplicar_accion(mover_caja_derecha, estado(Pos, Caja, si, PosBanana, Banana), estado(NuevaPos, NuevaCaja, si, PosBanana, Banana), 2) :-
    NuevaPos is Pos + 1, NuevaCaja is Caja + 1.

aplicar_accion(subir, estado(Pos, Caja, no, PosBanana, Banana), estado(Pos, Caja, si, PosBanana, Banana), 1).

aplicar_accion(tomar_banana, estado(Pos, Caja, si, PosBanana, no), estado(Pos, Caja, si, PosBanana, si), 1).

% Ejemplo de ejecución con entrada personalizada
ejemplo(PosMono, PosCaja, PosBanana) :-
    EstadoInicial = estado(PosMono, PosCaja, no, PosBanana, no),
    display_estado(EstadoInicial, 0),
    ejecutar_accion(EstadoInicial, 0).
