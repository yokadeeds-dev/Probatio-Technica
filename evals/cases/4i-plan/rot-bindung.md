# Rot-Bindung 4i-plan (v1.1, PHASE_1D_A_PLAN.md D32)

Bindung Erwartung <-> geschnittener Abschnitt, festgelegt vor dem ersten v1.1-Lauf. `expected.md` (Commit fd2b581) bleibt unveraendert. Rot gilt, wenn mindestens eine gebundene Erwartung, die der v1.1-Positivlauf als Treffer hat, verfehlt wird (Teiltreffer zaehlt als verfehlt). Modell wie Positivlauf (Opus).

| Variante | geschnitten | gebundene Erwartungen (expected.md fd2b581) | Rot, wenn | Kontrolle (soll weiter treffen) |
|---|---|---|---|---|
| `rot-ohne-befundpflicht` | `block|**Befundpflicht:**`, `line|14. **Offene Frage nur bei fehlender Quelle.**`, `line|OFFENE FRAGEN:`, `section|### 3.6 Erfuellbarkeit` (Umlaut im Original) | I1, I2, I3 (die, die der Positivlauf als Treffer hat; v1.0 hatte sie nur als Teiltreffer) | eine getroffene gebundene Erwartung verfehlt | I5, I6, I7 |

Hinweis: Der Satz in Regel 6 von Abschnitt 0.5 (Widerspruch ist Befund, keine Frage) bleibt in der Variante stehen. Verfehlt die Variante nichts, ist das eine Erkenntnis (Satz traegt allein), kein Fall-Fehler.
