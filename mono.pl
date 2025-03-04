% Estado: estado(Pos_Mono, Pos_Caja, EnCaja, Tiene_Banana)

% Definir el tamaño del mapa
mapa_tamano(6). % Ahora el mapa tiene 6 posiciones

% Mostrar el estado del juego de forma sencilla
mostrar_estado(estado(Pos, Caja, EnCaja, Banana), CostoTotal) :-
    mapa_tamano(Tamano),
    Tamano1 is Tamano - 1, % Asegurar que el valor sea un entero
    findall(X, between(0, Tamano1, X), Vector),
    (EnCaja = si -> reemplazar(Vector, Caja, 'X', Vec1) ;
     (reemplazar(Vector, Pos, 'M', Vec2), reemplazar(Vec2, Caja, 'C', Vec1))),
    reemplazar(Vec1, Tamano1, 'B', Vec3), % Marcar la última casilla como la banana
    write(Vec3), write('  Estado: '), write(estado(Pos, Caja, EnCaja, Banana)),
    write('  Costo Total: '), write(CostoTotal), nl.

% Reemplazar un elemento en la lista
reemplazar([_|T], 0, X, [X|T]).
reemplazar([H|T], I, X, [H|R]) :- I > 0, I1 is I - 1, reemplazar(T, I1, X, R).

% Calcular heurística
heuristica(estado(Pos, Caja, EnCaja, Banana), H) :-
    BananaPos = 5,
    (Banana = si -> H is 0 ;
     (EnCaja = no -> H is abs(Pos - Caja) ; H is abs(Caja - BananaPos))).

% Seleccionar la mejor acción a realizar
mejor_accion(estado(Pos, Caja, EnCaja, Banana), MejorAccion, Heuristica) :-
    (Banana = si -> MejorAccion = terminar, Heuristica = 0 ;
     (EnCaja = no ->
        (Pos < Caja -> MejorAccion = mover_derecha ; Pos > Caja -> MejorAccion = mover_izquierda ; MejorAccion = subir)
     ;
        (Caja < 5 -> MejorAccion = mover_caja_derecha ; MejorAccion = tomar_banana))),
    heuristica(estado(Pos, Caja, EnCaja, Banana), Heuristica).

% Ejecutar la acción seleccionada y mostrar el costo acumulado
ejecutar_accion(estado(Pos, Caja, EnCaja, Banana), CostoTotal) :-
    (Banana = si -> write('¡Objetivo alcanzado!'), nl, write('Costo Total Final: '), write(CostoTotal), nl ;
    write('---------------------------------------'), nl,
    mejor_accion(estado(Pos, Caja, EnCaja, Banana), MejorAccion, Heuristica),
    write('Acción seleccionada: '), write(MejorAccion),
    write(' | Heurística: '), write(Heuristica),
    write(' | Costo Acumulado: '), write(CostoTotal), nl,
    aplicar_accion(MejorAccion, estado(Pos, Caja, EnCaja, Banana), NuevoEstado, CostoMovimiento),
    NuevoCostoTotal is CostoTotal + CostoMovimiento,
    mostrar_estado(NuevoEstado, NuevoCostoTotal),
    ejecutar_accion(NuevoEstado, NuevoCostoTotal)).

% Aplicar la acción seleccionada y devolver el costo del movimiento
aplicar_accion(mover_izquierda, estado(Pos, Caja, EnCaja, Banana), estado(NuevaPos, Caja, EnCaja, Banana), 1) :-
    NuevaPos is Pos - 1.

aplicar_accion(mover_derecha, estado(Pos, Caja, EnCaja, Banana), estado(NuevaPos, Caja, EnCaja, Banana), 1) :-
    NuevaPos is Pos + 1.

aplicar_accion(mover_caja_derecha, estado(Pos, Caja, si, Banana), estado(NuevaPos, NuevaCaja, si, Banana), 2) :-
    NuevaPos is Pos + 1, NuevaCaja is Caja + 1.

aplicar_accion(subir, estado(Pos, Caja, no, Banana), estado(Pos, Caja, si, Banana), 1).

aplicar_accion(tomar_banana, estado(Pos, Caja, si, no), estado(Pos, Caja, si, si), 1).

% Ejemplo de ejecución con entrada personalizada
ejemplo(PosMono, PosCaja) :-
    EstadoInicial = estado(PosMono, PosCaja, no, no),
    mostrar_estado(EstadoInicial, 0),
    ejecutar_accion(EstadoInicial, 0).
