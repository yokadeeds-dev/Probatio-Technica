# Eval 4i-plan - rot-ohne-befundpflicht v1.1 - 2026-11-08

| Feld | Wert |
|---|---|
| Agent | ptc-rot-ohne-befundpflicht |
| Agent-Fassung SHA-256 | 96e8d4158cd5d7a01329805d37ae0a29af1422efe58788e676883a3ab5628f3b |
| Schnitt | block '**Befundpflicht:**' Zeilen 115-115; line '14. **Offene Frage nur bei fehlender Quelle.**' Zeilen 289-289; line 'OFFENE FRAGEN:' Zeilen 256-256; section '### 3.6 Erfüllbarkeit' Zeilen 156-158 |
| Fixture-Manifest SHA-256 | 75ae7a62c6bf27ced1512624418b5f98f4bca58735c3d6d65ca1c8b0c7e19159 |
| Modell / Effort | opus / medium |
| Token input / output / cache read / cache creation | 8 / 27285 / 149964 / 63127 |
| Token Summe (alle Arten) | 240384 |
| Token ohne Cache-Read (input + output + cache creation) | 90420 |
| USD | 1.0807408 |
| Dauer s / Turns / Werkzeugaufrufe | 264.8 / 6 / 5 |
| Zugriffe ausserhalb Lauf-Ordner | 0 |
| gueltig | ja |

Karte: 2026-11-08_4i-plan_rot-ohne-befundpflicht_v1.1.karte.md - CLI-Ausgabe (stream-json): 2026-11-08_4i-plan_rot-ohne-befundpflicht_v1.1.json


## Bewertung (GRADER, Opus, 2026-11-08) - wörtlich (Spalte Fundstelle gekürzt; Weitere Befunde gekürzt)

| ID | Art | Ergebnis | Fundstelle in der Karte |
|---|---|---|---|
| I1 | MUSS | Teiltreffer | Ressourcen: „`usage.jsonl` und Events bei 8 Fadern × 60 Hz … I/O auf dem Message-Thread ungeklärt (F5)“ … Gewertet als Teiltreffer, weil die Karte die Last von 8 Fadern nur als offene Frage zum Log-I/O stellt; ein fehlendes Budget für die Summe oder die Wartezeit nennt sie nicht. |
| I2 | MUSS | Teiltreffer | Ressourcen: „**28 von 28, keine Reserve** (Z.35). Für 4J und 4K ist das geregelt, für Phase 5/6 nicht.“ Unter Operatoren: „Katalogregel (28/28) für Phase 5/6 als offenen Punkt eintragen“. Das ist kein HART-, LECK- oder SYNC-Befund und kein Punkt der Korrekturliste. |
| I3 | MUSS | Teiltreffer | F2: „Ergibt die gemeinsame Zähler-Geste (Z.29) zusammen mit dem `UndoTransactionInhibitor` getrennte Schritte je `coalesce_key`, so wie Z.29 … und Z.37 („genau 8“) es verlangen?“ Gewertet als Teiltreffer, weil die Karte den Widerspruch selbst als offene Frage F2 einstuft. |
| I4 | MUSS | Treffer | L2 (LECK): „`reconnect` bzw. Neuerkennung während einer **Aufnahme** sind nicht getestet.“ Dazu Korrektur 7. |
| I5 | MUSS (Regression) | Treffer | H3: „Paket 4: ‚Katalog → Review nur bei Zonenänderung‘ (Z.150) … PROCESS.md:42 zählt `registry/mcp_tools.json` … zu den Kernpfaden“, dazu Korrektur 3. |
| I6 | KANN | Teiltreffer | Nano: „Wie die alte Bit-Tabelle nach dem atomaren Austausch freigegeben wird (Z.26), ist offen.“ |
| I7, I8, I10, I11, I12 | KANN | Verpasst (je) | – |
| I9 | KANN | Teiltreffer | Fehlerarten: „OSC-Port belegt / Feld `osc.error` vorhanden (Z.33), kein Test“ |
| I13-I17 | NICHT | nicht verletzt (je) | I13 nur offene Frage F3; I15 L2 beschränkt sich auf Aufnahme und Rollenwechsel |

Fehlalarme: keine
Weitere Befunde (alle: Offen, für 1D): H1, H2, L1 bis L6, S1 bis S3
Summen: MUSS 2/5 (dazu MUSS-Teiltreffer 3: I1, I2, I3) · KANN 0/8 (dazu Teiltreffer 2: I6, I9) · NICHT verletzt 0 · Fehlalarme 0 · Mehrwert 1 (I5) · davon kontaminiert 1 (I5)
Urteil Fall: Messung (kein Urteil)
