# GoRetro

Juego de romper bloques (estilo Arkanoid) hecho con **Godot 4.7**. Basado en el
proyecto original de [dvarrui/goretro](https://github.com/dvarrui/goretro),
portado de Godot 3 a Godot 4.

## Jugar

Necesitas [Godot 4.7](https://godotengine.org/download) (probado con 4.7.2).

```bash
godot --path goretro.g3            # ejecuta el juego
godot --path goretro.g3 --editor   # lo abre en el editor
```

La primera vez, Godot genera su caché de importación (`.godot/`, no se versiona). Para
hacerlo sin abrir el editor: `godot --headless --path goretro.g3 --import`.

### Controles

| Acción | Teclado | Mando |
|---|---|---|
| Mover a la izquierda | `A` o flecha izquierda | cruceta izquierda / stick |
| Mover a la derecha | `D` o flecha derecha | cruceta derecha / stick |
| Nueva partida / empezar | `N`, `G` o `Espacio` | botón A |
| Continuar | `C` | |
| Pausa | `P` | |
| Cambiar el filtro de pantalla (CRT, gris, verde, Game Boy, sin filtro) | `R` | cruceta arriba |
| Panel con los cuatro filtros a la vez (en franjas, al azar) | `4` | |
| Salir | `Esc`, `Q` o `E` | |

## Qué hay en el repositorio

| Carpeta | Contenido |
|---|---|
| `goretro.g3/` | **El juego** (Godot 4.7): título, niveles, pelota, jugador, bloques, puntuación y filtros de pantalla |
| `arkanoid.g462/` | Versión mínima de Arkanoid en Godot 4.6.2, el punto de partida del juego |

Dentro de `goretro.g3/`: `actor/` (pelota, jugador, bloques), `levels/` (niveles; `retro.tscn`
es el principal), `ui/` (título, pausa, puntos y shaders de pantalla), `global/points.gd`
(puntuación, cargada como autoload) y `assets/` (imágenes y sonidos).

La versión original para Godot 3.2 (`arkanoid.g322`) y unos niveles antiguos sin usar se
eliminaron del árbol; siguen en el historial de git.

## Pruebas

Comprobaciones de la lógica del juego (puntuación, menú de pausa), sin ventana:

```bash
godot --headless --path goretro.g3 --script res://tests/test_game.gd
```

Sale con código 0 si todo está bien.

## Exportar

`goretro.g3/export_presets.cfg` trae un preset para Linux/X11 (salida en `bin/`, que no se
versiona):

```bash
godot --headless --path goretro.g3 --export-release "Linux/X11"
```

## Licencia

GNU GPL v3 — ver [`LICENSE`](LICENSE).
