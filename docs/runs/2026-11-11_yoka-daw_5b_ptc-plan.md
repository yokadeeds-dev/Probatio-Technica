# Lauf 2026-11-11 · Yoka-DAW 5B · PTc:PLAN (dritter Vorhersagefall, 1B)

| Feld | Wert |
|---|---|
| Datum | 2026-11-11, vor dem Detailplan-Commit `a66a1b3` (10:05); Uhrzeit des Laufs in der Yoka-DAW nicht protokolliert (Zeile „Plan, PTc“ nennt nur das Datum) |
| Projekt | Yoka-DAW (`F:\Yoka\Workspace\Yoka-DAW`, Branch `phase-5b-plan`, Umsetzung auf `phase-5b-echtzeit`) |
| Objekt | `docs/PHASE_5B_PLAN.md`, unkommittierter Detailplan; nach Einarbeitung committet als `a66a1b3`, freigegeben in `616c14f` (Abschnitt „PTc:PLAN“ dort unverändert) |
| Werkzeug | **PTc v1.1.0** (deployt 2026-11-08 19:36; `~/.claude/agents/ptc.md` am 2026-11-11 byte-gleich mit `agent/ptc.md`) |
| Modus | `PTc:PLAN` |
| Modell | Opus 5.5, Effort medium (Subagent `ptc`) |
| Token | **163 689** (Agent-Abrechnung, Quelle „Agent“ in § Zeiten) |
| Dauer | 370 s (≈ 6,2 min) |
| Werkzeug-Aufrufe | 67 |
| Art | **Vorhersagetest, unkontaminiert** (D14) |
| Quelle | Yoka-DAW `a66a1b3:docs/PHASE_5B_PLAN.md` § Erkenntnisse „PTc:PLAN“; Kennzahlen aus § Zeiten, Zeile „Plan, PTc“ |
| Protokoll | 2026-11-11 nachgetragen; 5B läuft (Pakete 1–2 fertig, `3d033ba`); Treffer-Bewertung nach dem Tag `phase-5b` |

## Ergebnis des Laufs

- **Vorentscheidung: FAIL** (2 HART: K1, K2), „sobald K1–K8 eingearbeitet sind, ist PASS erreichbar“. Zehn Fakten des Plans wörtlich bestätigt.
- **10 Korrekturen**, alle nach D114 eingearbeitet; wörtliche Karte des Agenten nicht im Plan, nur die Einarbeitungsliste (unten wörtlich).

## Übernahme

| K | Inhalt | Übernommen nach |
|---|---|---|
| 1 (HART) | `transport.record` ist rote Zone, Yoka bestätigt jeden Pipe-Aufruf | Paket 3, Paket 6 Schritt 1, „Für Yoka“, D394 |
| 2 (HART) | Summen-Höchststand bricht nacheinander laufende Proxys ab | D398 (1), Tests in beide Richtungen |
| 3 | `ui_paint` an der falschen Stelle, `Present` unsichtbar | D392, A2 |
| 4 | Messzeilen schreiben synchron in die Messung | D392 (Puffer, Schalter, Aufräumregel) |
| 5 | Gerätewechsel: Neubau über Tracktions Timer | D396, A5, Fakt 12 |
| 6 | Worker-Zahl, Export nutzt denselben Wert | Fakt 11, D395 |
| 7 | `values` ohne Arranger-M/S und Verlauf | D393, Test (c) |
| 8 | Lasttests in Paket 2 brauchen L-12 und LatencyMon | Yoka-Schritt vor Paket 2 |
| 9 | drei 4F-Punkte ohne Zuordnung | D398 (5), D399 |
| 10 | `YokaEngine.h` in Kernpfade, `--renderer` je Fenster | D392, D395 |

**Übernahme 10/10.** G4-1 bestätigt. **Kein `PTc:IST` vor der 5B-Abnahme im Plan** (siehe PTc-Plan 1D, D38).

## Kosten

- 163 689 Token, ≈ 0,97 × 4K, 67 Werkzeugaufrufe.

---

## Karte und Einarbeitung (wörtlich aus Yoka-DAW `a66a1b3:docs/PHASE_5B_PLAN.md`)

### PTc:PLAN (2026-11-11, Subagent `ptc`, Opus 5.5, Effort medium)

Vorentscheidung **FAIL** wegen K1 und K2, „sobald K1–K8 eingearbeitet sind, ist PASS erreichbar“; alle Korrekturen nach Empfehlung eingearbeitet (D114). Fakten 2, 3, 5, 6, 7, 9, 10, 12, 13, 14 wörtlich bestätigt.

- **K1 (HART)** `transport.record` ist rote Zone, über die Pipe bestätigt Yoka jeden Aufruf → Bestätigungen in Paket 3 und Paket 6 Schritt 1, „Für Yoka“, keine Ausnahme von D84 (D394).
- **K2 (HART)** Summen-Höchststand bricht nacheinander laufende Proxys ab, „jeder laufende Auftrag“ hebelt die Dauerzustand-Erkennung aus → Regel je Clip-Kennung und Minimum der Wartenden, Tests in beide Richtungen (D398 (1)).
- **K3** `ui_paint` an der falschen Stelle, `Present` unsichtbar → `componentPainted`, `JUCE_DIRECT2D_METRICS`, A2 neu (D392).
- **K4** Messzeilen schreiben synchron in die Messung → Puffer je Sekunde, `controller_raw` hinter eigenem Schalter, Aufräumregel `performance.jsonl` (D392).
- **K5** Gerätewechsel: Kontext bleibt, Neubau über Tracktions Timer → Anlauf beim ersten Graph-Neubau nach Gerätestart, A5 neu (D396, Fakt 12).
- **K6** Worker-Zahl bei Anlage = n, Export nutzt denselben Wert → Fakt 11 berichtigt, Exportdauer als Bedingung (D395).
- **K7** `values` ohne Arranger-M/S und Verlauf → ergänzt, Test (c) (D393).
- **K8** Lasttests in Paket 2 brauchen L-12 und LatencyMon → Yoka-Schritt vor Paket 2.
- **K9** drei 4F-Punkte ohne Zuordnung → Export nach Warp-Änderung und Bus in der Freeze-Datei übernommen, Freeze 1,3 s zurückgestellt (D398 (5), D399).
- **K10** `YokaEngine.h` in die Kernpfad-Liste, `--renderer` wirkt nur je Fenster (D392, D395).
- **G4:** G4-1 bestätigt; K1 ist nach D84 kein G4-Punkt.
