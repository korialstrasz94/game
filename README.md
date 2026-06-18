# Warcraft 3 stílus RTS - Godot 4

## Projekt Áttekintés

Ez egy Warcraft 3 stílus valós idejű stratégia (RTS) játék, amely Godot 4-ben készült. A projekt jelenleg a kamera mozgatást és az egység kijelölést tartalmazza.

## Projektstruktúra

```
game/
├── project.godot              # Godot projekt fájl
├── scenes/
│   ├── main/
│   │   └── game.tscn         # Fő játékjelenet
│   ├── units/
│   │   └── unit.tscn         # Egység jelenet template
│   └── ui/
│       └── (UI komponensek később)
├── scripts/
│   ├── main/
│   │   └── game_manager.gd   # Fő játékmenedzser
│   ├── camera/
│   │   └── camera_controller.gd  # Kamera vezérlés
│   ├── units/
│   │   └── unit.gd           # Alap egység script
│   ├── selection/
│   │   └── unit_selection.gd # Kijelölési rendszer
│   └── input/
│       └── (Input kezelés később)
├── assets/
│   ├── textures/             # Textúrák
│   └── materials/            # Anyagok
└── README.md                  # Ez a fájl
```

## Jelenlegi Funkciók

### 1. Kamera Mozgatás
- **WASD billentyűk**: Kamera mozgatása
- **Egér szélsőség**: Automatikus kamera mozgás az egér szélén (20px-en belül)
- **Egér kerék**: Zoom in/out
- Sima lerp-alapú mozgás

### 2. Egység Kijelölés
- **Bal kattintás és húzás**: Kijelölési doboz
- **Shift + kattintás**: Többegység kijelölés
- **Jobbkattintás**: (Később) Egységek mozgatása
- Zöld glowing indikátor a kijelölt egységekhez

### 3. Demo Jelenet
- Pályaalap (sík zöld terület)
- 7 demo egység szétszórva
- Közvetlen megvilágítás

## Használat

### Projekt Megnyitása
1. Godot 4 Editor megnyitása
2. "Projekt Megnyitása" → `game` mappa kiválasztása
3. `game.tscn` megnyitása a szerkesztőben

### Játék Futtatása
- **F5** vagy "Play" gomb a projekt futtatásához
- **ESC** - Kilépés

### Kamera Kezelés
```
W        - Kamera fel mozgatása
S        - Kamera le mozgatása
A        - Kamera bal mozgatása
D        - Kamera jobb mozgatása
Egér fel   - Zoom in
Egér le    - Zoom out
Egér szél  - Kamera mozgatása automatikusan
```

### Egységek Kezelése
```
Bal kattintás + húzás  - Kijelölés doboz
Shift + kattintás      - Többegység kijelölés
Jobbkattintás         - Mozgatás (várja az implementációt)
```

## Beállítások (Inspector-ban szerkeszthető)

### CameraController
- `camera_speed`: Billentyűzet mozgási sebesség (alapértelmezett: 50)
- `edge_scroll_speed`: Egér szélsőség mozgási sebesség (alapértelmezett: 50)
- `edge_scroll_margin`: Egér szélsőség távolsága (alapértelmezett: 20px)
- `zoom_speed`: Zoom sebesség (alapértelmezett: 5)
- `min_zoom`: Minimum zoom érték (alapértelmezett: 10)
- `max_zoom`: Maximum zoom érték (alapértelmezett: 100)

### Unit
- `unit_name`: Egység neve
- `health`: Jelenlegi egészség
- `max_health`: Maximum egészség
- `speed`: Mozgási sebesség
- `model_scale`: Modell méretezés

## Jövőbeni Funkciók

- [ ] Egységek valódi mozgatási szisztéma (pathfinding)
- [ ] Épületek és építés
- [ ] Terep magasság
- [ ] Erőforrás menedzselés
- [ ] AI egységek
- [ ] Fog of War (Köd a háborúban)
- [ ] Csapatok/Vezér kezelés
- [ ] Támadási rendszer
- [ ] Anim á ció és hangeffektek
- [ ] Tényleges modellek helyett mesh-ek

## Szript Leírások

### GameManager (game_manager.gd)
A fő játékmenedzser, amely:
- Jelenet inicializálást kezeli
- Kamerákat és kijelölési rendszert állít be
- Demo egységeket spawn-ol
- Egységmozgatást koordinál

### CameraController (camera_controller.gd)
Ortogonális kamera vezérlés:
- WASD billentyűs mozgatás
- Egér szélsőség mozgatás
- Zoom funkcionalitás
- Simítás a mozgásban

### UnitSelection (unit_selection.gd)
Egységkijelölési rendszer:
- Kijelölési doboz rajzolása
- Egységek kijelölésének kezelése
- Signálok a kijelölési eseményekhez
- Deselect funkciók

### Unit (unit.gd)
Alap egységScript:
- Egység adatai (health, speed, stb.)
- Kijelölés vizuális visszajelzése
- Egészség és ütközés kezelés

## Technikai Információk

- **Godot verzió**: 4.2+
- **Felhasználó felület**: 3D viewport
- **Kamera típusa**: Ortogonális
- **Fizika**: Godot PhysicsServer3D
- **Inputkezelés**: Godot InputMap

## Fejlesztés Tippek

1. **Egységek hozzáadása**: `spawn_demo_units()` függvényt szerkeszd a game_manager.gd-ben
2. **Kamera szintézise**: A camera_controller.gd exportált tulajdonságait módosítsd
3. **UI hozzáadása**: `scenes/ui/` mappába UI szcenariókat adj
4. **Textúrák**: `assets/textures/` mappába helyezz textúra fájlokat

## Hibakeresés

Ha probléma van:
1. Nyisd meg a Debug konzolt (Godot-ban: Debug > Monitor)
2. Ellenőrizd az error üzeneteket
3. Biztosítsd, hogy az összes script elérési út helyes
4. A Project Settings-ben ellenőrizd az input map beállításokat
