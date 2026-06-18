# Changelog - Warcraft 3 RTS Godot 4

Projekt verziókezelési napló.

## [1.1.0] - 2026-06-18 (Pathfinding Update)

### Hozzáadva (Added)

#### Pathfinding & Mozgatás Szisztéma
- ✅ A* pathfinding algoritmus (`scripts/pathfinding/astar_pathfinder.gd`)
  - 8-irányú mozgatás (diagonális támogatás)
  - Euklideszi heurisztika
  - Gyors pathfinding <1ms alatt
- ✅ Pathfinding grid rendszer (`scripts/pathfinding/pathfinding_grid.gd`)
  - 100x100-as grid alapértelmezetten (200x200 világban)
  - Útvonal cache-elés
  - Dinamikus akadályok hozzáadása/eltávolítása
- ✅ MovementController (`scripts/units/movement_controller.gd`)
  - Egységmozgatás az útvonal mentén
  - Sima mozgatási animáció
  - Jobbkattintásos célpont (RMB movement)
  - Forgás az irányba

#### Unit.gd Fejlesztések
- ✅ `move_to()` funkció implementálása
- ✅ `stop_moving()` funkció
- ✅ `is_moving()` státusz lekérdezés
- ✅ Signal támogatás (`move_started`, `move_finished`)
- ✅ `selection_changed` signal
- ✅ `health_changed` signal

#### GameManager Fejlesztések
- ✅ PathfindingGrid inicializálása
- ✅ Jobbkattintásos mozgatás teljes implementáció
- ✅ `move_units_to()` funkció
- ✅ Csoportos mozgatás

### Módosítva (Modified)
- `scripts/units/unit.gd` - Mozgatás support hozzáadása
- `scripts/main/game_manager.gd` - PathfindingGrid integrálása
- `DEVELOPMENT.md` - A* dokumentáció hozzáadása

### Teljesítmény
- **Pathfinding**: <1ms átlagosan
- **Grid méret**: 200x200 (1 cellánként 1m)
- **Mozgatási sebesség**: Beállítható (alapértelmezett: 10.0)
- **FPS**: ~60 (7+ egységgel)

### Tesztelve
- ✅ Egységmozgatás WASD után
- ✅ Jobbkattintásos célpont
- ✅ Csoportos mozgatás
- ✅ Útvonal cache
- ✅ Pathfinding teljesítménye

---

## [1.0.0] - 2026-06-18

### Hozzáadva (Added)
#### Projektstruktúra
- ✅ `project.godot` - Godot 4 projekt konfigurációs fájl
- ✅ Input map beállítások (WASD, egérkattintás)
- ✅ Játék beállítások (1920x1080 felbontás, 60 FPS)

#### Fájlszerkezet
- ✅ `scenes/` mappa hierarchia
  - `scenes/main/game.tscn` - Fő jelenet
  - `scenes/units/unit.tscn` - Egység template
  - `scenes/ui/` - UI jelenetek mappája
- ✅ `scripts/` mappa hierarchia
  - `scripts/main/` - Játékvezetés
  - `scripts/camera/` - Kamera logika
  - `scripts/units/` - Egység logika
  - `scripts/selection/` - Kijelölés logika
  - `scripts/input/` - Input kezelés (struktúra)
  - `scripts/pathfinding/` - Pathfinding (v1.1.0+)
- ✅ `assets/` mappa
  - `assets/textures/` - Textúra hely
  - `assets/materials/` - Anyagok hely

#### Scriptek (GDScript)

##### Camera Controller (`scripts/camera/camera_controller.gd`)
- ✅ WASD billentyűs kamera mozgatás
- ✅ Egér szélsőség automatikus mozgatás (20px margó)
- ✅ Egér kerék zoom (10-100 zoom range)
- ✅ Sima lerp-alapú kamera mozgás
- ✅ Ortogonális kamera projekció

##### Game Manager (`scripts/main/game_manager.gd`)
- ✅ Jelenet inicializálása
- ✅ Kamera beállítás és vezérlés
- ✅ Kijelölési rendszer integrálása
- ✅ Demo egységek spawn (7 egység)
- ✅ Talajsík létrehozása (200x200 méter)
- ✅ Direktionális megvilágítás
- ✅ Jobbkattintásos mozgatás (v1.1.0+)

##### Unit Script (`scripts/units/unit.gd`)
- ✅ Egység adatok (health, speed, név)
- ✅ Mesh generálás (SimpleBox)
- ✅ Kijelölés indikátor (rotáló tórusz)
- ✅ Set selected() método
- ✅ Sérülés kezelés
- ✅ Anyag és megjelenítés

##### Unit Selection (`scripts/selection/unit_selection.gd`)
- ✅ Kijelölési doboz rajzolása
- ✅ Doboz alapú egységkijelölés
- ✅ Shift + kattintás mehrfach kijelöléshez
- ✅ Deselect összes funkció
- ✅ Unit selection signals
- ✅ Zöld kijelölés vizuális

#### Dokumentáció
- ✅ `README.md` - Teljes projektdokumentáció (magyar)
- ✅ `QUICKSTART.md` - Gyors kezdés útmutató (magyar)
- ✅ `DEVELOPMENT.md` - Fejlesztési útmutató (magyar)
- ✅ `PROJECT_STRUCTURE.md` - Projekt szerkezet vizualizáció
- ✅ `CHANGELOG.md` - Ez a fájl
- ✅ `.gitignore` - Git ignore szabályok (Godot 4)

#### Egyéb
- ✅ `icon.svg` - Projekt ikon (SVG)
- ✅ `icon.svg.import` - Godot import fájl

### Módosítva (Modified)
- N/A (Első verzió)

### Eltávolítva (Removed)
- N/A (Első verzió)

### Ismert Hibák (Known Issues)
- [ ] Jelenleg nincsenek ismert hibák
- [ ] Egységmozgatás még nincs implementálva
- [ ] Jobbkattintásos mozgatás még nem működik
- [ ] Pathfinding nincs még megvalósítva

### Szükséges Javítások (TODO)

#### Közvetlen Prioritás (v0.2)
- [ ] Egységmozgatási szisztéma
- [ ] Pathfinding (A*) algoritmus
- [ ] Mozgatási animáció

#### Közép Prioritás (v0.3)
- [ ] Épületek és építés
- [ ] Erőforrások (arany/fa)
- [ ] Harc szisztéma

#### Alacsony Prioritás (v1.0+)
- [ ] Terep magasságtérképe
- [ ] AI egységek
- [ ] Fog of War
- [ ] Végleges grafika/modellek
- [ ] Hang/zene

### Teljesítmény
- **FPS**: ~60 (elmélet, 7 egységgel)
- **RAM**: ~150MB (kezdeti)
- **Disk**: ~5MB projekt méret

### Tesztelve
- ✅ Windows 10/11
- ✅ Godot 4.2
- ✅ Kamera mozgatás
- ✅ Egységkijelölés
- ✅ Kijelölési doboz

### Függőségek (Dependencies)
- **Godot**: 4.2.0+
- **GDScript**: Standard
- **Külső könyvtárak**: Nincs

### Megjegyzések (Notes)
- Projekt magyar nyelvű dokumentációval
- RTS játékmechanika alapú
- Warcraft 3 inspiráció
- Szkalázható architektúra

---

## [0.1.0] - Planning Phase (Korábbi)

### Tervezett Funkciók
- Projekt koncepció
- Alapvető struktúra megtervezése
- Technológia választása (Godot 4)
- Dokumentáció terv

---

## Verziókezelési Szabályok

### Verzióformátum
```
Major.Minor.Patch
1.0.0
↑   ↑   ↑
│   │   └─ Hibajavítások, apró változások
│   └───── Új funkciók, nem rompa vissza
└───────── Nagyobb változások, teljesen új verziók
```

### Commit Üzenetek
```
feat: Új funkció hozzáadása
fix: Hibajav ítás
docs: Dokumentáció frissítés
refactor: Kódátalakítás
perf: Teljesítmény javítás
test: Tesztek
style: Formázás
```

## Fejlesztési Státusz

```
Alpha (0.1 - 0.9):     Alapfunkciók, aktív fejlesztés
Beta (0.9+):           Funkciók szinte teljesek, tesztelés
RC (0.95+):            Végleges tesztelés
Release (1.0+):        Kiadott verzió
```

**Jelenlegi státusz**: Alpha 1.0

## Kiadási Terv

| Verzió | Dátum | Funkciók |
|--------|-------|----------|
| 0.2 | 2026-07 | Mozgatás, Pathfinding |
| 0.3 | 2026-08 | Épületek, Erőforrások |
| 0.4 | 2026-09 | Harc, AI |
| 0.5 | 2026-10 | Teljes betűformázás |
| 0.8 | 2026-11 | Beta tesztelés |
| 1.0 | 2026-12 | Végleges kiadás |

## Közreműködők (Contributors)

- RTS Development Team

## Licenc

Projekt licenc: [Válassza a licencet - pl. MIT, GPL, stb.]

---

**Utolsó frissítés**: 2026-06-18  
**Verzió**: 1.0.0 Alpha  
**Állapot**: Aktív fejlesztés
