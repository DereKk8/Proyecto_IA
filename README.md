# 📌 PROYECTO: MONO Y LA BANANA 🐵🍌

## 📖 Descripción
Este programa implementa una solución al **problema del mono y la banana** usando **Best-First Search** en **Prolog**. El objetivo del mono es alcanzar la banana, para lo cual primero debe encontrar la caja, subirse a ella y luego moverse hasta la banana.

## 🛠️ Algoritmo de búsqueda Best-First Search
El programa utiliza el algoritmo **Best-First Search**, el cual selecciona en cada iteración **la mejor acción posible** basada en una heurística.

### 🔍 Heurística utilizada
- **Si el mono no está sobre la caja:** la heurística mide la distancia entre el mono y la caja.
- **Si el mono está sobre la caja:** la heurística mide la distancia entre la caja y la banana.
- **Si el mono tiene la banana:** la heurística es `0`, ya que se ha alcanzado el objetivo.

Cada acción tiene un costo:
- **Moverse a la izquierda o derecha**: `1`
- **Mover la caja**: `2`
- **Subir a la caja**: `1`
- **Tomar la banana**: `1`

## 📊 Representación del estado
Cada estado se representa como:
```
estado(Pos_Mono, Pos_Caja, EnCaja, Tiene_Banana)
```
Donde:
- `Pos_Mono`: Posición actual del mono en el mapa.
- `Pos_Caja`: Posición de la caja en el mapa.
- `EnCaja`: Indica si el mono está sobre la caja (`si` o `no`).
- `Tiene_Banana`: Indica si el mono ha alcanzado la banana (`si` o `no`).

## 🗺️ Representación del mapa
El mapa tiene **un tamaño fijo de 6 posiciones**, representado en una lista:
```
[ 0, 1, 2, 3, 4, 5 ]
```
Los elementos en el mapa se representan como:
- `M` → Mono
- `C` → Caja
- `X` → Mono sobre la caja
- `B` → Banana (siempre en la última posición)

## 🖥️ Ejecución del programa
Para ejecutar un ejemplo, usa:
```prolog
?- ejemplo(PosMono, PosCaja).
```
Donde:
- `PosMono`: Posición inicial del mono.
- `PosCaja`: Posición inicial de la caja.

**Ejemplo:**
```prolog
?- ejemplo(0, 3).
```
Salida esperada:
```
[ M, 1, 2, C, 4, B ]  Estado: estado(0, 3, no, no)  Costo Total: 0
---------------------------------------
Acción seleccionada: mover_derecha | Heurística: 3 | Costo Acumulado: 0
[ 0, M, 2, C, 4, B ]  Estado: estado(1, 3, no, no)  Costo Total: 1
---------------------------------------
Acción seleccionada: mover_derecha | Heurística: 2 | Costo Acumulado: 1
...
¡Objetivo alcanzado!
Costo Total Final: 7
```

## 📌 Notas importantes
- **El tamaño del mapa es fijo (6 posiciones).**
- **El programa garantiza que el mono siempre tomará las mejores decisiones** basadas en la heurística.
- **Cada acción es impresa en pantalla** con su costo y heurística.

