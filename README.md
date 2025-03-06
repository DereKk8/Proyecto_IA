# 📌 PROYECTO: MONO Y LA BANANA 🐵🍌

## 📖 Descripción
Este programa implementa una solución al **problema del mono y la banana** usando **Best-First Search** en **Prolog**. El objetivo del mono es alcanzar la banana, para lo cual primero debe encontrar la caja, subirse a ella y luego moverse hasta la banana.

## 🛠️ Algoritmo de búsqueda Best-First Search
El programa utiliza el algoritmo **Best-First Search**, el cual selecciona en cada iteración **la mejor acción posible** basada en una heurística.

### 🔍 Cálculo de la heurística y lógica del algoritmo
El programa evalúa el estado actual y selecciona la acción óptima en cada paso, siguiendo esta lógica:

1. **Si el mono no está sobre la caja**, primero debe buscarla:
   - Si `Pos_Mono < Pos_Caja`, el mono se moverá a la **derecha** (`Pos_Mono + 1`).
   - Si `Pos_Mono > Pos_Caja`, el mono se moverá a la **izquierda** (`Pos_Mono - 1`).
   - Si `Pos_Mono == Pos_Caja`, el mono **sube** a la caja.

2. **Si el mono está sobre la caja**, entonces mueve la caja hacia la banana:
   - Si `Pos_Caja < Pos_Banana`, el mono mueve la caja a la **derecha** (`Pos_Caja + 1`).
   - Si `Pos_Caja == Pos_Banana`, el mono **toma la banana** y termina el proceso.

3. **Cada vez que se realiza una acción, se recalcula la heurística** `H`:
   - Si el mono busca la caja: `H = |Pos_Mono - Pos_Caja|`
   - Si el mono mueve la caja: `H = |Pos_Caja - Pos_Banana|`
   - Si el mono tiene la banana: `H = 0`

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
El mapa tiene **un tamaño fijo de n posiciones**, representado en una lista:
```
[ 0, 1, 2, 3, 4, 5 , ...]
```
Los elementos en el mapa se representan como:
- `M` → Mono
- `C` → Caja
- `X` → Mono sobre la caja
- `B` → Banana (siempre en la última posición)

## 🔄 Secuencia de pasos del algoritmo
1. **Evaluar el estado actual.**
   - Determinar si el mono ya tiene la banana.
   - Si no la tiene, calcular `H` para los posibles movimientos.
2. **Si el mono no está sobre la caja, moverse hacia ella** (reduciendo `|Pos_Mono - Pos_Caja|`).
3. **Si el mono está sobre la caja, moverse hacia la banana** (reduciendo `|Pos_Caja - Pos_Banana|`).
4. **Seleccionar la mejor acción posible** basada en `H`.
5. **Ejecutar la acción y actualizar el estado.**
6. **Imprimir el estado actualizado, el costo acumulado y la acción seleccionada.**
7. **Repetir hasta que el mono tenga la banana.**

## 🖥️ Ejecución del programa
Para ejecutar un ejemplo, usa:
```prolog
?- ejemplo(PosMono, PosCaja, PosBanana).
```
Donde:
- `PosMono`: Posición inicial del mono.
- `PosCaja`: Posición inicial de la caja.
- `PosBanana`: Posición inicial de la banana.

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
- **El programa garantiza que el mono siempre tomará las mejores decisiones** basadas en la heurística.
- **Cada acción es impresa en pantalla** con su costo y heurística.

