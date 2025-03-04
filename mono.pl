% Estado: estado(Pos_Mono, Pos_Caja, EnCaja, Tiene_Banana)

% Definir el tamaño del mapa
mapa_tamano(6). % Ahora el mapa tiene 6 posiciones

% Mostrar el estado del juego de forma sencilla
mostrar_estado(estado(Pos, Caja, EnCaja, Banana)) :-
    mapa_tamano(Tamano),
    Tamano1 is Tamano - 1, % Asegurar que el valor sea un entero
    findall(X, between(0, Tamano1, X), Vector),
    (EnCaja = si -> reemplazar(Vector, Caja, 'X', Vec1) ;
     (reemplazar(Vector, Pos, 'M', Vec2), reemplazar(Vec2, Caja, 'C', Vec1))),
    reemplazar(Vec1, Tamano1, 'B', Vec3), % Marcar la última casilla como la banana
    write(Vec3), write('  Estado: '), write(estado(Pos, Caja, EnCaja, Banana)), nl.

% Reemplazar un elemento en la lista
reemplazar([_|T], 0, X, [X|T]).
reemplazar([H|T], I, X, [H|R]) :- I > 0, I1 is I - 1, reemplazar(T, I1, X, R).

% Seleccionar la mejor acción a realizar
mejor_accion(estado(Pos, Caja, EnCaja, Banana), MejorAccion) :-
    (Banana = si -> MejorAccion = terminar ; % Si el mono tiene la banana, finaliza
     (EnCaja = no ->  % Si el mono no está sobre la caja, moverse hacia ella
        (Pos < Caja -> MejorAccion = mover_derecha ; Pos > Caja -> MejorAccion = mover_izquierda ; MejorAccion = subir)
     ; % Si el mono está sobre la caja, moverse con la caja hacia la banana
        (Caja < 5 -> MejorAccion = mover_caja_derecha ; MejorAccion = tomar_banana))).

% Ejecutar la acción seleccionada
ejecutar_accion(estado(Pos, Caja, EnCaja, Banana)) :-
    (Banana = si -> write('¡Objetivo alcanzado!'), nl ;
    mejor_accion(estado(Pos, Caja, EnCaja, Banana), MejorAccion),
    aplicar_accion(MejorAccion, estado(Pos, Caja, EnCaja, Banana), NuevoEstado),
    mostrar_estado(NuevoEstado),
    ejecutar_accion(NuevoEstado)).

% Aplicar la acción seleccionada
aplicar_accion(mover_izquierda, estado(Pos, Caja, EnCaja, Banana), estado(NuevaPos, Caja, EnCaja, Banana)) :-
    NuevaPos is Pos - 1.

aplicar_accion(mover_derecha, estado(Pos, Caja, EnCaja, Banana), estado(NuevaPos, Caja, EnCaja, Banana)) :-
    NuevaPos is Pos + 1.

aplicar_accion(mover_caja_derecha, estado(Pos, Caja, si, Banana), estado(NuevaPos, NuevaCaja, si, Banana)) :-
    NuevaPos is Pos + 1, NuevaCaja is Caja + 1.

aplicar_accion(subir, estado(Pos, Caja, no, Banana), estado(Pos, Caja, si, Banana)).

aplicar_accion(tomar_banana, estado(Pos, Caja, si, no), estado(Pos, Caja, si, si)).

% Ejemplo de ejecución con entrada personalizada
ejemplo(PosMono, PosCaja) :-
    EstadoInicial = estado(PosMono, PosCaja, no, no),
    mostrar_estado(EstadoInicial),
    ejecutar_accion(EstadoInicial).
