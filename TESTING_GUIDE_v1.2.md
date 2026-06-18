# Tesztelési Útmutató v1.2.0

## 🚀 Gyors Indítás

1. **Godot 4.2+** megnyitása
2. `game/game` mappa projektként
3. **F5** futtatás

## 🎯 Tesztelési Szenarió 1: Ütközéskerülés

### Lépések:
1. **Bal kattintás+húzás** - 5-6 egység kijelölése (bal oldali csoport)
2. **Jobbkattintás** - Közepre mozgatás
3. **Figyeld**: Egységek körülötte mozgatnak, nem ütköznek meg

### Elvárt viselkedés:
- Egységek csoportban mozgatnak
- Egymástól 2m távolságot tartanak
- Sima mozgatás (nem szaggatott)

---

## 🏰 Tesztelési Szenarió 2: Épületek

### Lépések:
1. **Kamera mozgatás** (WASD) - Jobb oldalt mozgatás
2. **Figyeld** a 3 épületet (sötét szürke, félalpha)
3. **Bal kattintás** az egyik épületre
4. **Figyeld** az építési progresszió (30 másodirc)
5. **Épület befejezése** - zöld szín, teljes láthatóság

### Elvárt viselkedés:
- 3 épület konstruálódik (Kastély, Laktanya, Aranyfejtő)
- Építés közben félalpha megjelenítés
- Építés után opaque megjelenítés
- Kijelölés sárga indikátor

---

## ⚔️ Tesztelési Szenarió 3: Harc

### Lépések:
1. **2 egység kijelölése** (Shift+bal kattintás mindegyikre)
2. **Jobbkattintás egyik egységen** (a másik kijelölt marad)
3. **Figyeld** a console naplókat
4. **Végig**, amíg az egyik egység "meghalt"

### Elvárt viselkedés:
```
[Egység1 mozgása: 5 pont az útvonalban]
[Egység2 támadás Egység1 ellen!]
[Egység2 támadás: Egység1 -> Egység2 (8.5 sérülés)]
[Egység2 visszaütésben támad!]
```

---

## 🎮 Tesztelési Szenarió 4: Mozgatási Animáció

### Lépések:
1. **1 egység kijelölése**
2. **Jobbkattintás messze** (30+ méter)
3. **Figyeld** a mozgatást
4. **Console** - Teljes útvonal kiírása

### Elvárt viselkedés:
- Sima, continuous mozgatás
- Nem szaggatott, nem csökkent FPS
- Forgás az irányhoz
- Lerp-alapú interpolálás

---

## 📊 Konzol Ellenőrzések

Nyisd meg a Debug konzolt (Debug > Monitor) és figyeld:

```
Performance:
- FPS: 60+ ideális
- Memory: <300MB
- Physics Delta: <0.016

Output:
[Kastély építés megkezdődött]
[Kastély építés befejezve!]
[Egység1 mozgása: 8 pont az útvonalban]
[Egység1 elért a céljához]
```

---

## ✅ Tesztelési Checklist

### Ütközéskerülés
- [ ] Egységek nem ütköznek meg
- [ ] Steering erő működik
- [ ] Sima mozgatás

### Épületek
- [ ] Épületek konstruálódnak
- [ ] Alatta megjelenítés
- [ ] Építés után opaque
- [ ] Kijelölés működik

### Harc
- [ ] Támadás indul jobbkattintásra
- [ ] Sérülés kalkulálódik
- [ ] Ellentámadás működik
- [ ] Egység meghal (HP <= 0)

### Mozgatás
- [ ] Pathfinding működik
- [ ] Útvonal sima
- [ ] Forgás az irányhoz
- [ ] Lerp-animáció

---

## 🔍 Hibakeresés

### Ha az egységek nem mozgatnak:
1. Console: "PathfindingGrid nem található!"
2. Ellenőrizd: GameManager -> PathfindingGrid inicializálása

### Ha az épületek nem jelenne meg:
1. Console: "Demo épületek letrehozva"
2. Ellenőrizd: BuildingManager children

### Ha a harc nem működik:
1. Console: sérülés üzenet
2. Ellenőrizd: CombatSystem target-ja

---

## 🎥 Előre Tervezett Funkciók (v1.3+)

- [ ] UI - HP bar, ressource kijelzés
- [ ] Hang effektek - támadás, mozgatás
- [ ] Formáció mozgatás
- [ ] AI AI ellenfél
- [ ] Terep magasság
- [ ] Nagyobb pálya
