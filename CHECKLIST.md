# Warcraft 3 RTS - Fejlesztési Ellenőrzőlista

Nyomon követés az összes fejlesztési feladathoz. Frissítsd az [x] jeleket az elkészültség alapján.

## 🎮 Szisztémek Ellenőrzőlistája

### ✅ 1. Alap Infrastruktúra
- [x] Godot 4 projekt létrehozása
- [x] Projektstruktúra felépítése
- [x] Input map konfigurálása
- [x] Dokumentáció írása
- [x] Git repo előkészítése

### 2. Kamera Szisztéma
- [x] Ortogonal kamera beállítás
- [x] WASD mozgatás
- [x] Egér szélsőség mozgatás
- [x] Zoom (egér kerék)
- [x] Kamera korlátok
- [ ] Kamera tweening animáció
- [ ] Kamera gombok más stílusokhoz (jobbkattintás drag)

### 3. Egység Szisztéma
- [x] Egység alaposztály (Unit.gd)
- [x] Egység mesh renderelés
- [x] Kijelölési indikátor
- [x] Egészség rendszer
- [ ] Egység típusok (katonai, dolgozó, mágus)
- [ ] Egység inventár
- [ ] Egység abilitások
- [ ] Egység szintek/fejlesztések

### 4. Kijelölési Szisztéma
- [x] Kijelölési doboz
- [x] Egységek kijelölésének detektálása
- [x] Többegység kijelölés (Shift)
- [x] Kijelölési vizuális (zöld tórusz)
- [x] Deselect összes
- [ ] Csoportok (CTRL+1-9)
- [ ] Előző kijelölés (Tab)
- [ ] Kijelölés inverz

### 5. Mozgatási Szisztéma
- [ ] Jobbkattintásos mozgatás
- [ ] Pathfinding algoritmus (A*)
- [ ] Mozgatási animáció
- [ ] Sebesség szimulálása
- [ ] Ütközéskerülés
- [ ] Formáció mozgatás
- [ ] Parancsüzenetsor

### 6. Épület Szisztéma
- [ ] Épület alaposztály
- [ ] Épület típusok
- [ ] Építés/Terv režim
- [ ] Épület kijelölés
- [ ] Épület sérülés/romolás
- [ ] Épület gyorsítottabilitások

### 7. Harc Szisztéma
- [ ] Támadás alapmechanikája
- [ ] Sérülés számítás
- [ ] Fegyverkezelés
- [ ] Harcművelet animáció
- [ ] Támadási hatótáv
- [ ] Ellenfél kijelölés
- [ ] Harcállapot indikátor

### 8. Erőforrás Szisztéma
- [ ] Arany gyűjtés
- [ ] Fa gyűjtés
- [ ] Erőforrás tárolás
- [ ] Erőforrás kezelő UI
- [ ] Dolgozók erőforráskezelése
- [ ] Gazdaság szimulálása

### 9. Terep Szisztéma
- [ ] Terep magasságtérkép
- [ ] Terep szintek
- [ ] Végzetes zónák
- [ ] Terep deformálás
- [ ] Vegetáció
- [ ] Sziklák és akadályok

### 10. AI Szisztéma
- [ ] AI vezérlő alaposztály
- [ ] AI mozgatáskezelés
- [ ] AI harc AI
- [ ] AI épület kezelés
- [ ] AI erőforráskezelés
- [ ] Nehézségi szintek

### 11. UI/HUD Szisztéma
- [x] Alapvető HUD terv
- [ ] Egység infó panel
- [ ] Épület gyorsítócellák
- [ ] Erőforrás kijelzés
- [ ] Minimapa
- [ ] Messenger/Esemény log
- [ ] Beállítások menü
- [ ] Pausa menü

### 12. Audio Szisztéma
- [ ] Háttérzene
- [ ] Egység hangok (kattintás)
- [ ] Harc hangok
- [ ] Épület hangok
- [ ] Szovegezés
- [ ] Hangerő vezérlés

### 13. Mentés/Betöltés
- [ ] Játék mentése
- [ ] Játék betöltése
- [ ] Konfigurációs fájlok
- [ ] Konfigurációs mentés/betöltés

### 14. Teljesítmény
- [ ] FPS monitorozás
- [ ] Memóriahasználat optimalizálása
- [ ] Fizika optimalizálása
- [ ] Render optimalizálása
- [ ] LOD (Level of Detail) rendszer
- [ ] Occlusion culling

## 📊 Fejlesztési Fázi sok

### Fázis 1: Alpha (Jelenlegi)
**Készültség: 100%**
```
✅ Projektstruktúra
✅ Kamera mozgatás
✅ Egységkijelölés
✅ Demo jelenet
```

### Fázis 2: Beta - Mozgatás (Következő)
**Becslésezett: 2026-07**
```
[ ] Pathfinding
[ ] Egységmozgatás
[ ] Parancsüzenetsor
[ ] Formáció
```

### Fázis 3: Content - Épületek
**Becslésített: 2026-08**
```
[ ] Épület rendszer
[ ] Erőforrások
[ ] Képzés
```

### Fázis 4: Gameplay - Harc
**Becslésített: 2026-09**
```
[ ] Harc rendszer
[ ] Sérülés/Halál
[ ] AI ellenfél
```

### Fázis 5: Polish - UI és Audio
**Becslésített: 2026-10-11**
```
[ ] HUD rendszer
[ ] Menük
[ ] Hang/Zene
```

### Fázis 6: Release - Finalizálás
**Becslésített: 2026-12**
```
[ ] Tesztelés
[ ] Optimalizálás
[ ] Végső UI csiszolás
```

## 🎯 Prioritási Mátrix

### Magas Prioritás + Könnyű
- [x] Projektstruktúra
- [x] Kamera mozgatás
- [ ] UI alapok
- [ ] Kijelölési rendszer fejlesztés

### Magas Prioritás + Nehéz
- [ ] Pathfinding
- [ ] Épület rendszer
- [ ] AI logika
- [ ] Harc rendszer

### Alacsony Prioritás + Könnyű
- [ ] Hangeffektek
- [ ] Szövegezés
- [ ] Végzetes zónák

### Alacsony Prioritás + Nehéz
- [ ] Multiplayer
- [ ] Advanced terep
- [ ] VFX effektek

## 📈 Haladás Statisztika

```
Teljes feladatok:        ~80+
Elkészült:               4 (5%)
Fejlesztés alatt:        0 (0%)
Tervben:                 76 (95%)

Becsült teljes idő:      6-12 hónap
Jelenlegi sebesség:      ~1 fázis/hó
```

## 🔍 Kódminőség Ellenőrz és

### Kódstílus
- [ ] Összes fájl dokumentálva (docstring)
- [ ] Csapattársak által felülvizsgálva
- [ ] Linting átment
- [ ] Típusok helyesen használva

### Teljesítmény
- [ ] FPS >50 (7 egységnél)
- [ ] FPS >30 (100+ egységnél)
- [ ] RAM <500MB (normalként)
- [ ] Disk <100MB

### Tesztelés
- [ ] Egységtesztek írva
- [ ] Integrációs tesztek
- [ ] Terhelés tesztek
- [ ] Kompatibilitás tesztek

## 📝 Dokumentáció

- [x] README.md - Teljes dokumentáció
- [x] QUICKSTART.md - Gyors kezdés
- [x] DEVELOPMENT.md - Fejlesztési útmutató
- [x] PROJECT_STRUCTURE.md - Projekt mappastruktúra
- [x] CHANGELOG.md - Verziókezés
- [x] Ez az ellenőrzőlista

## 🐛 Ismert Hibák Nyomon Követése

| ID | Súlyosság | Leírás | Állapot |
|----|-----------|---------|---------|
| BUG-001 | INFO | Egységmozgatás nincs | TERVBE |
| BUG-002 | INFO | Pathfinding nincs | TERVBE |
| BUG-003 | LOW | Térképhatárok nincsenek | TERVBE |

## 🚀 Csökkentendő Technológiai Adósságok

- [ ] Szcenariórendszer refaktorizálása
- [ ] Input handler centralizálása
- [ ] Signal-alapú architektura felülvizsgálata
- [ ] Shader optimalizálása
- [ ] Asset pipeline automatizálása

## 📞 Fordító Megjegyzések

```
Jelenlegi verzió: 1.0.0 Alpha
Utolsó szerkesztés: 2026-06-18
Fejlesztő: RTS Csapat

Az ellenőrzőlista frissítéskor:
1. Jelöld meg az [x]-et az elkészült tételekhez
2. Frissítsd a becslésezett dátumokat
3. Módosítsd a százalékos haladást
4. Commit-old a változásokat
```

---

**Frissítsd ezt a listát hetente!**
