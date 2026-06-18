# Gyors Kezdés - RTS Game Godot 4

## 1️⃣ Telepítés

### Követelmények
- **Godot 4.2** vagy újabb ([Letöltés](https://godotengine.org/download))
- **Windows/Mac/Linux**
- Legalább 2GB RAM

### Projekt Megnyitása
1. Godot 4 Editor megnyitása
2. **"Projektek" → "Megnyitás"**
3. Válaszd ki a `game` mappát
4. **"Megnyitás"** gombra kattintás
5. Fejlesztőkörnyezet betöltődik

## 2️⃣ Első Futtatás

1. **F5** billentyű vagy **▶ Play** gomb
2. Készen áll a tesztelésre!

## 3️⃣ Alapvető Irányítás

### Kamera
```
W / ↑      → Fel
S / ↓      → Le
A / ←      → Balra
D / →      → Jobbra
Egér fel   → Nagyítás
Egér le    → Kicsinyítés
```

### Egységek
```
Kattintás + Húzás      → Kijelölés doboz
Shift + Kattintás      → Többegység kijelölés
Jobbkattintás          → Mozgatás (működés alatt van)
```

## 4️⃣ Projekt Szerkezet Gyorsan

```
📁 game/
  ├ 🎬 scenes/          ← Jelenet fájlok (.tscn)
  ├ 📜 scripts/         ← Kódok (GDScript)
  ├ 🎨 assets/          ← Grafikák, textúrák
  ├ 📋 project.godot    ← Godot projekt fájl
  ├ 📖 README.md        ← Teljes dokumentáció
  └ 📚 DEVELOPMENT.md   ← Fejlesztői útmutató
```

## 5️⃣ Főbb Fájlok

| Fájl | Célja |
|------|-------|
| `scenes/main/game.tscn` | Fő jelenet |
| `scripts/main/game_manager.gd` | Játékvezetés |
| `scripts/camera/camera_controller.gd` | Kamera mozgatás |
| `scripts/units/unit.gd` | Egység logika |
| `scripts/selection/unit_selection.gd` | Kijelölés |

## 6️⃣ Tipp: Szcenarióban Nyitás

1. **FileSystem → scenes/main**
2. **game.tscn** duplakattintás
3. Jelenet megjelenik a szerkesztőben
4. **F5** a játék indításához

## 7️⃣ Inspector Módosítások

### Egység sebessége
1. Jelenet megtekintés: `scenes/units/unit.tscn`
2. **Inspector** jobb oldalon
3. `Unit` script → `speed` módosítása
4. Pl: `10.0` → `15.0` gyorsabb

### Kamera sebesség
1. **Play** után nyomás: **Ctrl + Pause**
2. Jelenetfán: **Camera3D** kiválasztása
3. **Inspector** módosítása:
   - `camera_speed`: Gyorsabb/lassabb
   - `zoom_speed`: Zoom sebessége

## 8️⃣ Konzol Megtekintés

Ha hibák jelennek meg:
1. **Debug → Monitor** megnyitása
2. **Console** fülre kattintás
3. Error üzenetek ellenőrzése

## 9️⃣ Jelenet Editálása

### Új Node Hozzáadása
1. **Scene** panel
2. **Node** jobbkattintás → **Add Child Node**
3. Típus kiválasztása

### Komponens Hozzáadása
1. **Attach Script** gombra kattintás
2. Script kiválasztása
3. Hajtsd végre a kódot

## 🔟 Mentés Munkád

```
Ctrl + S  → Jelenet mentése
Ctrl + Shift + S  → Név szerint mentés
```

## 🚀 Következő Lépések

### Könnyű Feladatok (Kezdőknek)
- [ ] Egységek számának megváltoztatása
- [ ] Egységek szövetének módosítása (szín)
- [ ] Kamera sebességének beállítása
- [ ] Demo szcenarióban szétszórt egységek

### Közepes Feladatok
- [ ] Új egységtípus létrehozása
- [ ] Egység mozgatási szisztéma
- [ ] UI elemek hozzáadása
- [ ] Hang/Zene integrálása

### Nehézebb Feladatok
- [ ] Pathfinding implementáció
- [ ] Harc szisztéma
- [ ] Építési szisztéma
- [ ] AI ellenfél

## 📚 Tanulmányanyag

**GDScript alapok**: `scenes/units/unit.gd` tanulmányozása  
**3D Camerák**: `scripts/camera/camera_controller.gd`  
**Input kezelés**: `scripts/selection/unit_selection.gd`  

## ⚙️ Beállítások Gyors Referencia

**project.godot** szerkesztéséhez:
- Input billentyűk módosítása
- Ablak méretének beállítása
- Fizika paraméterek

## 🐛 Hibakeresés

### Habár a jelenet nem jelenik meg
```
✓ Godot 4.2+ verzió
✓ Fájlok helyesen vannak-e
✓ project.godot létezik
✓ Helyes főjelenet: scenes/main/game.tscn
```

### Egységek nem jelennek meg
```
✓ Unit scene (scenes/units/unit.tscn) létezik
✓ Script elérési út helyes
✓ F5 után Play mód aktív
```

## 💾 Fájlok Helyreállítása

Ha valami elromlik:
```bash
# Godot cache törlése
rm -rf .godot/
# Projectet újra megnyitni
```

## 📞 Segítség

- **Godot Docs**: https://docs.godotengine.org/
- **GDScript Referencia**: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/
- **Discord Community**: https://discord.gg/godotengine
- **Reddit**: r/godot

---

**Boldog fejlesztést! 🎮**
