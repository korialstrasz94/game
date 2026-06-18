# Warcraft 3 RTS - Teljes Projektstruktúra

```
game/
│
├── 📄 project.godot                    [Godot 4 projekt konfigurációs fájl]
├── 📄 icon.svg                         [Projekt ikonja]
├── 📄 icon.svg.import                  [Godot import fájl]
├── 📄 .gitignore                       [Git figyelmen kívül hagyási fájl]
│
├── 📖 README.md                        [Teljes projektdokumentáció]
├── 📖 QUICKSTART.md                    [Gyors kezdés útmutató]
├── 📖 DEVELOPMENT.md                   [Fejlesztési útmutató]
│
│
├── 🎬 scenes/                          [Godot jelenetfájlok]
│   │
│   ├── main/
│   │   └── game.tscn                   [Fő játékjelenet]
│   │
│   ├── units/
│   │   └── unit.tscn                   [Egység alap jelenet]
│   │
│   └── ui/                             [UI jelenetek]
│       ├── (hud.tscn)                  [HUD - jövőben]
│       ├── (menu.tscn)                 [Menü - jövőben]
│       └── (pause_menu.tscn)           [Szünet menü - jövőben]
│
│
├── 📜 scripts/                         [GDScript scriptfájlok]
│   │
│   ├── main/
│   │   └── game_manager.gd             [Játékmenedzser, játék inicializálása]
│   │       ├── Jelenet felépítés
│   │       ├── Kamera beállítás
│   │       ├── Kijelölés rendszer
│   │       ├── Demo egységek spawning
│   │       └── Egységmozgatás koordinálás
│   │
│   ├── camera/
│   │   └── camera_controller.gd        [Kamera vezérlőrendszer]
│   │       ├── WASD mozgatás
│   │       ├── Egér szélsőség mozgatás
│   │       ├── Zoom (felfelé/lefelé)
│   │       └── Sima lerp-alapú mozgás
│   │
│   ├── units/
│   │   ├── unit.gd                     [Alap egység script]
│   │   │   ├── Egység adatok (health, speed)
│   │   │   ├── Kijelölés kezelés
│   │   │   ├── Vizuális visszajelzés
│   │   │   ├── Sérülés kezelés
│   │   │   └── Mesh/Material renderelés
│   │   │
│   │   ├── (unit_movement.gd)          [Mozgatásvezérlés - jövőben]
│   │   ├── (unit_combat.gd)            [Harc logika - jövőben]
│   │   └── (unit_types/)               [Különleges egységtípusok - jövőben]
│   │       ├── worker.gd
│   │       ├── soldier.gd
│   │       └── mage.gd
│   │
│   ├── selection/
│   │   └── unit_selection.gd           [Kijelölési rendszer]
│   │       ├── Kijelölési doboz rajz
│   │       ├── Egységkijelölés
│   │       ├── Deselect funkciók
│   │       ├── Shift-kattintásos többejelölés
│   │       └── Jelzések (signals)
│   │
│   ├── input/
│   │   └── (input_handler.gd)          [Input kezelés - jövőben]
│   │
│   ├── buildings/                      [Épületek - jövőben]
│   │   ├── building.gd
│   │   ├── building_manager.gd
│   │   └── building_types/
│   │
│   ├── combat/                         [Harc - jövőben]
│   │   └── combat_system.gd
│   │
│   ├── resources/                      [Erőforrások - jövőben]
│   │   ├── resource_manager.gd
│   │   └── resource_gatherer.gd
│   │
│   ├── terrain/                        [Terep - jövőben]
│   │   ├── terrain_generator.gd
│   │   └── terrain_renderer.gd
│   │
│   ├── ai/                             [AI - jövőben]
│   │   ├── ai_controller.gd
│   │   └── ai_pathfinding.gd
│   │
│   └── ui/                             [UI logika - jövőben]
│       ├── ui_manager.gd
│       ├── hud.gd
│       └── menu_controller.gd
│
│
└── 🎨 assets/                          [Játék erőforrások]
    │
    ├── textures/                       [Textúrák és képek]
    │   ├── (ground.png)                [Talaj textúra - jövőben]
    │   ├── (units/)                    [Egység textúrák - jövőben]
    │   └── (ui/)                       [UI textúrák - jövőben]
    │
    ├── materials/                      [Godot anyagok (.tres)]
    │   ├── (ground_material.tres)      [Talaj anyag - jövőben]
    │   └── (unit_materials.tres)       [Egység anyagok - jövőben]
    │
    ├── models/                         [3D modellek - jövőben]
    │   ├── units/
    │   ├── buildings/
    │   └── props/
    │
    ├── audio/                          [Hang- és zeneeffektek - jövőben]
    │   ├── music/
    │   │   └── (main_theme.ogg)
    │   └── sfx/
    │       ├── (unit_click.wav)
    │       ├── (building_construct.wav)
    │       └── (attack_sound.wav)
    │
    └── fonts/                          [Betűtípusok - jövőben]
        └── (arial.ttf)
```

## 📊 Implementációs Állapot

### ✅ Elkészült (1.0 - Alpha)
- [x] Projekt struktúra
- [x] Kamera mozgatás (WASD + egér szélsőség)
- [x] Kamera zoom
- [x] Egység kijelölés (doboz)
- [x] Többegység kijelölés
- [x] Kijelölési vizuális visszajelzés
- [x] Demo 7 egység
- [x] Szcenarióalap (pálya)
- [x] Közvetlen megvilágítás
- [x] Dokumentáció

### 🔄 Fejlesztés Alatt
- [ ] Egységmozgatás
- [ ] Pathfinding (A*)

### 📝 Tervben (Jövőbeli Verzió)
- [ ] Épületek és építés
- [ ] Erőforrások (arany, fa)
- [ ] Harc és sérülés
- [ ] AI egységek
- [ ] Fog of War
- [ ] Végleges grafika
- [ ] Hang/Zene
- [ ] Menü és UI

## 🎯 Szintváltások

### v0.1 - Alpha (JELENLEGI)
- Alapvető projektstruktúra
- Kamera mozgatás
- Egységkijelölés

### v0.2 - Beta
+ Egységmozgatás
+ Pathfinding
+ Épületek

### v0.3 - Pre-Release
+ Erőforrások
+ Harc
+ AI

### v1.0 - Release
+ Teljes grafika
+ Teljes UI
+ Multiplayer (tervezett)

## 📋 Kód Statisztikák

| Elem | Darab | Sor |
|------|-------|-----|
| GDScript fájlok | 4 | ~600 |
| Jelenet fájlok | 2 | ~50 |
| Dokumentáció | 4 | ~1000 |
| **Összesen** | **10** | **~1650** |

## 🔧 Technikai Specifikáció

- **Engine**: Godot 4.2+
- **Nyelv**: GDScript
- **Platform**: Windows, Mac, Linux
- **Grafika**: 3D OpenGL/Vulkan
- **Fizika**: Godot Physics3D
- **Input**: Godot InputMap
- **Jelenetrendszer**: Godot SceneTree

## 🚀 Használati Utasítás

1. **Godot 4.2+** telepítése
2. `game` mappa megnyitása projektként
3. `scenes/main/game.tscn` megnyitása
4. **F5** a futtatáshoz

## 📚 Dokumentáció Index

| Fájl | Célja | Célközönség |
|------|-------|-------------|
| README.md | Teljes áttekintés | Mindenki |
| QUICKSTART.md | Gyors kezdés | Kezdőknek |
| DEVELOPMENT.md | Fejlesztési útmutató | Fejlesztőknek |
| project.godot | Godot konfigurációs | Godot |

## 💡 Fejlesztési Tippek

1. **Szcenarió megtekintése**: `F5` → Játék indítás
2. **Szcenarió szerkesztése**: `Ctrl+Pause` midgame szerkesztéshez
3. **Inspector módosítás**: Valós idejű paraméter beállítás
4. **Console ellenőrzés**: Debug > Monitor
5. **Git verziókezelés**: `.gitignore` már konfigurálva

## 🎮 Játékmechanika Vázlat

```
Játék Jelenet (game.tscn)
    ├─ Kamera (ortogonal, isometrikus)
    ├─ Egységek (3D modellek)
    ├─ Épületek (jövőben)
    ├─ Terep (jövőben)
    ├─ Kijelölés UI (Canvas overlay)
    └─ HUD (jövőben)

Fő Hurok:
    Input (WASD, egér) → Kamera/Kijelölés Update
    ↓
    Fizika Update (ütközés)
    ↓
    Render (kamera nézet)
```

## 📞 Támogatás

- **Godot Dokumentáció**: https://docs.godotengine.org/
- **GitHub Issues**: Projektek GitHub oldala
- **Discord**: Godot Engine Community

---

**Verz ió**: 1.0 Alpha  
**Kiadás dátuma**: 2026-06-18  
**Fejlesztő**: RTS Development Team
