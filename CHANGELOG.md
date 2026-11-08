# Changelog

Versionen von `agent/ptc.md` (SemVer, D10). Jede Version steht auch im Kopf der Agent-Datei; `scripts/check.ps1` prüft die Übereinstimmung.

## 1.1.0 — 2026-11-08

Aus dem Eval-Set 1C (`docs/PHASE_1C_PLAN.md` § Erkenntnisse), umgesetzt in 1D-a (`docs/PHASE_1D_A_PLAN.md`, D26–D34). Allgemein formuliert, ohne Begriffe der Ableitungsfälle (D27).

- Ä1: neuer § 3.5 Zustandspfade (alle Änderungspfade eines dauerhaften Zustands bis zum Persistenzauslöser; „gewollte" Lücke ohne offenen Punkt = LECK).
- Ä2: § 2.2 Zustandskreuz (Freigeben/Neuöffnen/Ersetzen einer Ressource gegen jeden Betriebszustand).
- Ä3: § 2.3 Pflichtfrage 4 um Summe unter Last, Wartezeit und Reserve erweitert (weiter vier Pflichtfragen, D28); Befundpflicht.
- Ä4: § 0.5 Regel 6 (V-gegen-V-Widerspruch ist Befund, keine Frage), § 9 Regel 14 (offene Frage nur bei fehlender Quelle), Ausgabe-Zeile OFFENE FRAGEN.
- Ä5: neuer § 3.6 Erfüllbarkeit (Akzeptanzkriterium gegen eigenen Mechanismus des Plans).
- Ä6: § 10 Belege und Anpassungsbedingungen (IST auf Sonnet bestätigt; neue Regeln).
- `scripts/check.ps1`: Pflichtabschnitte § 3.5 und § 3.6.

## 1.0.0 — 2026-11-08

Erste Fassung, abgeleitet aus MiMaMa v1.1 nach dem Testlauf auf `Yoka-DAW/docs/PHASE_4J_PLAN.md` (Lauf-Protokoll: `docs/runs/2026-11-08_yoka-daw_4j_mimama-full.md`).

- Übernommen aus MiMaMa: Ebenen-Spine, Prämissen-Klärung, Quellen-Bindung, Abwärts-Operator, Selbst-Falsifikation, PASS/FAIL statt Verdict.
- Ersetzt: 14-Kriterien-Raster durch Querachsen und Ressourcen-Pflichtfragen; 3 Eimer durch Reichweite; binären Cross-Flow durch HART/LECK/SYNC.
- Gestrichen: Kritische-Masse-Schwelle, „Kulturelle Akzeptanz", „Politische Machbarkeit", Durchschnitte.
- Neu: Schnittstellen-Matrix, Plan-gegen-Ist, Belegklasse S, Ressourcen-Achse (CPU, RAM, Platte, Thread-Zeit, Latenz, Kontingente), Fehlerarten-Raster, Lebenszyklus, Modi PLAN/IST/VERIFY/LITE mit Kostenregeln.
