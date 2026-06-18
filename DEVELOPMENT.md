# Fejlesztési Útmutató - Warcraft 3 RTS Godot 4

## Projekt Arquitectúra

### MVC-szerű Felépítés

```
GameManager (Controller)
    ├── CameraController (View - Kamera)
    ├── UnitSelection (Controller - Kijelölés)
    ├── Units (Model - Egységek)
    └── GroundPlane (View - Pálya)
```

## Következő Lépések - Fejlesztési Sorrendje

### 1. Fázis: Egységmozgatás (Priority: HIGH) ✅ ELKÉSZÜLT
- [x] Pathfinding implementáció (A* algoritmus)
- [x] Egységmozgatási vezérlés
- [ ] Parancs üzenetsor (csoportos parancsok)
- [ ] Mozgatási animáció (forgás, lépés)
- [ ] Ütközéskerülés (egységek közötti)
- [ ] Formáció mozgatás

**Elkészült Fájlok**:
- ✅ `scripts/pathfinding/astar_pathfinder.gd` - A* algoritmus
- ✅ `scripts/pathfinding/pathfinding_grid.gd` - Grid rendszer
- ✅ `scripts/units/movement_controller.gd` - Mozgatás vezérlés
- ✅ `scripts/units/unit.gd` - Egység mozgatási support

### 2. Fázis: Épületek (Priority: HIGH)
- [ ] Épület jelenet létrehozása
- [ ] Épületépítés szisztéma
- [ ] Épület kijelölés
- [ ] Terület-alapú építés

**Fájlok**:
- `scenes/buildings/building.tscn`
- `scripts/buildings/building.gd`
- `scripts/buildings/building_manager.gd`

### 3. Fázis: Erőforrások (Priority: MEDIUM)
- [ ] Arany/fa erőforrások
- [ ] Erőforrás kezelés UI
- [ ] Gyűjtés mechanika
- [ ] Szállítás és tárolás

**Fájlok**:
- `scripts/resources/resource_manager.gd`
- `scripts/resources/resource_gatherer.gd`

### 4. Fázis: Harc (Priority: MEDIUM)
- [ ] Támadási rendszer
- [ ] Sérülés számítás
- [ ] Harcművelet animáció
- [ ] Halál/Elpusztulás

**Fájlok**:
- `scripts/combat/combat_system.gd`
- `scripts/units/unit_combat.gd`

### 5. Fázis: Terep (Priority: LOW)
- [ ] Magasságtérképes terep
- [ ] Terep textúra
- [ ] Terep deformáció
- [ ] Végzetes zónák

**Fájlok**:
- `scripts/terrain/terrain_generator.gd`
- `scripts/terrain/terrain_renderer.gd`

## Gyakorlati Kód Példák

### Új Egységtípus Hozzáadása

```gdscript
# scripts/units/unit_types/worker.gd
extends Unit

class_name Worker

@export var gather_speed: float = 1.0
@export var carry_capacity: float = 100.0

var carrying_resource: float = 0.0

func _ready() -> void:
	super()
	unit_name = "Dolgozó"
	health = 60.0
	max_health = 60.0
	speed = 8.0

func gather_resource(amount: float) -> void:
	if carrying_resource < carry_capacity:
		carrying_resource = min(carrying_resource + amount, carry_capacity)
```

### Új Épület Hozzáadása

```gdscript
# scripts/buildings/building.gd
extends Node3D

class_name Building

@export var building_name: String = "Épület"
@export var health: float = 500.0
@export var max_health: float = 500.0
@export var build_time: float = 30.0
@export var gold_cost: int = 200

var is_selected: bool = false
var construction_progress: float = 0.0

func _ready() -> void:
	# Épület inicializálás
	pass

func set_selected(selected: bool) -> void:
	is_selected = selected
	# Vizuális visszajelzés

func take_damage(damage: float) -> void:
	health = max(0, health - damage)
	if health <= 0:
		destroy()

func destroy() -> void:
	queue_free()
```

## Signal (Jelek) Rendszer

Az alábbi jelek javasolt csatornái:

```gdscript
# Egység jelzések
signal unit_selected(unit: Unit)
signal unit_deselected(unit: Unit)
signal unit_died(unit: Unit)
signal unit_moved(unit: Unit, position: Vector3)
signal move_started(target: Vector3)
signal move_finished(position: Vector3)

# Épület jelzések
signal building_completed(building: Building)
signal building_damaged(building: Building, damage: float)

# Erőforrás jelzések
signal gold_changed(amount: int)
signal wood_changed(amount: int)

# Kijelölés jelzések
signal selection_changed(selected: bool)
```

## A* Pathfinding Rendszer

### Áttekintés
A projekt egy hatékony A* pathfinding algoritmust használ a terepen történő navigációhoz. A rendszer grid-alapú, ami 100x100-as cellákat kezel alapértelmezésként.

### Osztályok

#### AStarPathfinder
A* algoritmus magja. Megtalálja a legrövidebb utat egy starttól egy célig, az Euklideszi heurisztika felhasználásával.

```gdscript
# Útvonal keresése
var pathfinder = AStarPathfinder.new()
pathfinder.set_grid(Vector2i(100, 100), walkable_cells, 1.0)
var path = pathfinder.find_path(start_grid, goal_grid)  # Array[Vector2i]

# Grid-ből világpozícióba konvertálás
var world_pos = pathfinder.grid_to_world(Vector2i(10, 20))  # Vector3

# Világból grid-be konvertálás
var grid_pos = pathfinder.world_to_grid(Vector3(10, 0, 20))  # Vector2i
```

#### PathfindingGrid
A terep kezelése és útvonal cache-elése. Kezeli a navigálható cellákat és az akadályokat.

```gdscript
# PathfindingGrid inicializálása
var grid = PathfindingGrid.new()
grid.grid_size = Vector2i(200, 200)
grid.cell_size = 1.0

# Útvonal keresése világpozícióban
var path = grid.find_path(start_pos, goal_pos)  # Array[Vector3]

# Akadályok hozzáadása/eltávolítása
grid.add_obstacle(Vector3(50, 0, 50), radius: 2.0)
grid.remove_obstacle(Vector3(50, 0, 50), radius: 2.0)

# Cache törlése
grid.clear_cache()
```

#### MovementController
Az egység mozgatásának kezelése az útvonal mentén.

```gdscript
# Egységmozgatás
var movement = MovementController.new()
movement.movement_speed = 10.0
movement.stop_distance = 0.5
movement.move_to(target_position)  # bool

# Mozgatás leállítása
movement.stop_moving()

# Mozgatási státusz
var is_moving = movement.get_is_moving()  # bool
var current_path = movement.get_current_path()  # Array[Vector3]
```

### Teljesítmény
- **Grid méret**: 200x200 (alapértelmezett)
- **Keresési idő**: <1ms tipikus
- **Cache**: Útvonal cache-elés az ismételt keresésekhez
- **8-irányú mozgatás**: Diagonális mozgatás támogatott

### Jövőbeli Fejlesztések
- [ ] Jump Point Search (JPS) optimalizálása
- [ ] Terep magasság támogatása
- [ ] Dinamikus akadály kezelés
- [ ] Mozgatási animáció smooth-elése

# Játék jelzések
signal game_started()
signal game_paused()
signal game_ended(winner: int)
```

## Perform ancia Optimalizáció

### Javasolt Szintváltás
1. **Közel (0-50m)**: Részletes modellek
2. **Közepes (50-200m)**: Középszintű LOD
3. **Messze (200m+)**: Egyszerű LOD vagy ikon

```gdscript
func update_lod(distance: float) -> void:
	if distance < 50:
		show_detailed_model()
	elif distance < 200:
		show_medium_model()
	else:
		show_simple_model()
```

## Input Kezelés Kiterjesztése

```gdscript
# project.godot további inputok hozzáadása:

build_menu={
"deadzone": 0.0,
"events": [Object(InputEventKey,"keycode":66)] # B billentyű
}

pause_game={
"deadzone": 0.0,
"events": [Object(InputEventKey,"keycode":4194305)] # ESC
}

screenshot={
"deadzone": 0.0,
"events": [Object(InputEventKey,"keycode":4194335)] # Print Screen
}
```

## Tesztelés Stratégia

### Egységtesztek
- Pathfinding helyesség
- Ütközésfelismerés
- Erőforrás számítás

### Integrációs Tesztek
- Egységmozgatás és harc
- Épületépítés és termelés
- Csapatkezelés

### Teljesítménytesztek
- 100+ egység kezelés
- Nagyobb pályák
- Hosszú játékidő

## Debugging Tipek

### Godot Debugger Használat
1. A `Debug > Monitor` megnyitása
2. `performance/` metrikák megtekintése
3. `physics/` szimulációs információk ellenőrzése

### Console Kimenete
```gdscript
# Hasznos debug outputok
print("Egységek száma: %d" % units.size())
print("Kijelölt: %s" % selected_units)
print("FPS: %d" % Engine.get_frames_drawn())
```

## Forráskódszervezés Házirendek

1. **Nevek**: snake_case függvények, PascalCase osztályok
2. **Megjegyzések**: Magyar nyelvű, értelmes
3. **Szóközök**: Inkább 2 szóköz behúzás (GDScript standard)
4. **Hosszúság**: Max 100 karakter/sor
5. **Verziók**: Komment: # v1.0 - leírás

## Erőforrás Menedzselés

### Textúrák és Modellek
- `/assets/textures/` - PNG/JPG formátum
- `/assets/models/` - GLTF/GLB formátum
- `/assets/materials/` - Godot .tres anyag fájlok

### Audio
- `/assets/audio/music/` - Zene
- `/assets/audio/sfx/` - Hangeffektek

## Git Workflow

```bash
# Alapvető munkafolyamat
git checkout -b feature/unit-movement
# ... fejlesztés ...
git add .
git commit -m "feat: Add pathfinding for units"
git push origin feature/unit-movement
```

## Dokumentáció Sablon

```gdscript
##
## Egység kijelölési menedzser
##
## Kezeli az egységek kijelöléseit és a kijelölési dobozról
##
## @tutorial(Egységkijelölés): https://docs.godotengine.org/en/stable/
##
extends Node
```

## Hasznos Erőforrások

- [Godot 4 Dokumentáció](https://docs.godotengine.org/)
- [GDScript Útmutató](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
- [3D Játékfejlesztés](https://docs.godotengine.org/en/stable/tutorials/3d/)
- [Performance Best Practices](https://docs.godotengine.org/en/stable/tutorials/performance/)

---

**Verzió**: 1.0  
**Utolsó frissítés**: 2026-06-18  
**Fejlesztő**: RTS Csapat
