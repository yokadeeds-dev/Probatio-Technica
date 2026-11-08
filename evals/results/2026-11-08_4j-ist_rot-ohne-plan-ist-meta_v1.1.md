# Eval 4j-ist - rot-ohne-plan-ist-meta v1.1 - 2026-11-08

| Feld | Wert |
|---|---|
| Agent | ptc-rot-ohne-plan-ist-meta |
| Agent-Fassung SHA-256 | 743cb5d7e2db18133955aa699f4ede3ff45a0bf3ffb6fd7697d4c85d5f3d271e |
| Schnitt | section '### 3.4 Plan-gegen-Ist' Zeilen 141-149; block 'PLAN-GEGEN-IST (nur IST/VERIFY)' Zeilen 242-244; line '| **Meta** |' Zeilen 86-86; line '> **Meso und Meta immer prüfen.**' Zeilen 87-87; line '5. **Meso und Meta immer.**' Zeilen 267-267 |
| Fixture-Manifest SHA-256 | 2bfd1c07c9a35f5089a84bea00cc9a1a8e338e9bbe5ad009929579f5516008fe |
| Modell / Effort | sonnet / medium |
| Token input / output / cache read / cache creation | 12 / 24841 / 277878 / 79460 |
| Token Summe (alle Arten) | 382191 |
| Token ohne Cache-Read (input + output + cache creation) | 104313 |
| USD | 0.5940618 |
| Dauer s / Turns / Werkzeugaufrufe | 178.9 / 9 / 8 |
| Zugriffe ausserhalb Lauf-Ordner | 0 |
| gueltig | ja |

Karte: 2026-11-08_4j-ist_rot-ohne-plan-ist-meta_v1.1.karte.md - CLI-Ausgabe (stream-json): 2026-11-08_4j-ist_rot-ohne-plan-ist-meta_v1.1.json


## Bewertung (GRADER, Opus, 2026-11-08) - wörtlich (Spalte Fundstelle gekürzt; Weitere Befunde gekürzt)

| ID | Art | Ergebnis | Fundstelle in der Karte |
|---|---|---|---|
| J1 | MUSS | Treffer | HART-1: „Gespiegelt: PHASE_4_PLAN.md Z.279 „eigener atomarer Schreibweg (`replaceFileIn`)““ · „Erkenntnis :286: „`ReplaceFile` … ist **nicht** atomar …““ |
| J2 | MUSS | Treffer | LECK-5 (a): „Paket 5 ohne Review … `registry/mcp_tools.json` … laut PROCESS.md:43 und :50 … Kernänderung“ |
| J3 | MUSS | Treffer | SYNC-4: „Zeiten-Tabelle (:342-347): Spalte „Ist“ überall „nicht gemessen“, Start/Ende nur als Datum. PROCESS.md:74 verlangt Start- und Endzeit“ |
| J4 | MUSS | Treffer | SYNC-2: „D313 „keine Revision“ vs. … D316 Schlüssel „Pfad relativ zum Ort“ vs. `<Ortsname>/<rel klein>` (:300); D321 `import_audio` „group“ vs. `single` (:321); D319/Fakt „`TrackCommands.cpp:73` …“ vs. dort liegt nur `track.bounce`“ (Muster mit ≥ 3 der 6 D-Nummern; D311 zusätzlich in HART-1, D323 in HART-2) |
| J5 | MUSS (LECK) | Treffer | LECK-1: „Änderungen am Bus vorbei lösen kein Autosave aus (:290 „entspricht D313“) … widerspricht dem Muss-Ziel „Kein Datenverlust“ (:7). Es steht nur als „Mittel (2)“ in den Erkenntnissen, nicht als offener Punkt oder Aufgabe mit Haken.“ |
| J6 | MUSS | Treffer | HART-2: „D323 „erster Index ≤ 3 min ohne TempoDetect“ gegen Messung „kalt 261 s“ (:296) … Aufgabe 8 hat dafür keinen Haken“ |
| J7 | KANN | Verpasst (kein Abzug) | – |
| J8 | KANN | Treffer | SYNC-5: „Messwerte-Tabelle (:234-238) hat leere Zeilen, obwohl Werte vorliegen …“ |
| J9-J13 | NICHT | nicht verletzt (je) | J12 nur SYNC-2 „D320 `daw://library` gegen Erkenntnis :322“ (Text-Drift, keine Last-Meldung) |

Fehlalarme: keine
Weitere Befunde: LECK-2 bis LECK-10, SYNC-1, SYNC-3, SYNC-6, SYNC-7 - je „Offen, für 1D“
Summen: MUSS 6/6 · KANN 1/2 · NICHT verletzt 0 · Fehlalarme 0 · Mehrwert 6 (J1, J2, J3, J4, J6, J8) · davon kontaminiert 7
Urteil Fall: gruen (alle MUSS getroffen, 0 NICHT verletzt)
