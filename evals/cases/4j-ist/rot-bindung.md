# Rot-Bindung 4j-ist (v1.1, PHASE_1D_A_PLAN.md D32)

Bindung Erwartung <-> geschnittener Abschnitt, festgelegt vor dem ersten v1.1-Lauf. `expected.md` (Commit fd2b581) bleibt unveraendert. Rot gilt je Variante, wenn mindestens eine gebundene Erwartung, die der v1.1-Positivlauf getroffen hat, verfehlt wird (Teiltreffer zaehlt als verfehlt). Modell wie Positivlauf (Sonnet).

| Variante | geschnitten | gebundene Erwartungen (expected.md fd2b581) | Rot, wenn | Kontrolle (soll weiter treffen) |
|---|---|---|---|---|
| `rot-ohne-3-5` | `section|### 3.5 Zustandspfade` | J5 (nur, wenn der Positivlauf J5 trifft) | J5 verfehlt | J1-J4, J6 |
| `rot-ohne-plan-ist-meta` | `section|### 3.4 Plan-gegen-Ist`, `block|PLAN-GEGEN-IST (nur IST/VERIFY)`, `line|\| **Meta** \|` (Tabellenzeile), `line|> **Meso und Meta immer pruefen.**` (Umlaut im Original), `line|5. **Meso und Meta immer.**` | J3, J4 (expected.md: haengen ganz an 3.4; v1.0 fand sie ohne 3.4 ueber Meta) | J3 oder J4 verfehlt | J5 (falls getroffen), J6 |
