# Unterphase 1C „Eval-Set" – Detailplan

Status: **Umsetzung läuft, Pakete 1–3 erledigt** (2026-11-08; Detailplan fertig 2026-11-08) · Pakete 1–6 ohne Yoka · Grundlage: [PHASE_1_PLAN.md](PHASE_1_PLAN.md) § 1C, D1–D14, [PROCESS.md](PROCESS.md) (Belegklassen, Treffer-Bewertung, Testregel)

> **Für die ausführende Session:** **Eine** Session (Sonnet 5.5, Effort medium, D12) setzt 1C von Paket 1 bis zum Merge um, ohne Rückfrage zwischen den Paketen. Paket 3 und die Bewertungen laufen als Opus-Subagent (D12, D18). Alles lokal (D11), Branch `phase-1c-eval`, Commits `phase 1C: …`, Plan im selben Commit pflegen. **`agent/ptc.md` wird in 1C nicht geändert** (das ist 1D); damit gibt es in 1C keine Kernänderung und kein Pflicht-Review. Das Yoka-DAW-Repo wird nur gelesen (D13).

**Ziel:** Ein kleines, eingefrorenes, wiederholbares Eval-Set, mit dem jede PTc-Fassung (v1.0 jetzt, v1.1 in 1D) ohne Dialog gegen bekannte Befunde laufen kann: zwei Fälle, je eine Erwartungsdatei, ein Laufskript, ein Rot-Nachweis je Fall, Token und Dauer je Lauf.

**Fertig, wenn:** (1) PTc v1.0 erfüllt die Muss-Erwartungen des Regressionsfalls 4J ohne verbotenen Befund (T), (2) der Vorhersagefall 4I ist gelaufen und nach `PROCESS.md` bewertet (Treffer, Fehlalarme, Verpasst, Mehrwert), (3) der Rot-Nachweis ist je Fall dokumentiert oder sein Fehlen begründet, (4) Token und Dauer je Lauf stehen unter „Messwerte", (5) die Änderungsvorschläge für 1D stehen unter „Erkenntnisse".

## Entscheidungen 1C (D15–D24, von Claude nach Empfehlung)

| # | Thema | Entscheidung | Begründung |
|---|---|---|---|
| D15 | Ausführungsweg | Eval-Läufe **ohne Dialog** über `claude -p` (CLI 2.1.311): `--agents <json> --agent <name> --model <m> --effort medium --tools "Read,Grep,Glob" --strict-mcp-config --no-session-persistence --permission-prompts none --output-format json`. Die Agent-Definition kommt **immer** aus einer zur Laufzeit erzeugten JSON-Datei (aus `agent/ptc.md` bzw. einer Rot-Variante), nie aus `~/.claude/agents/` | A1 am 2026-11-08 geprüft (Fakt 1, 2). Die JSON-Datei prüft die Repo-Fassung statt der deployten Kopie (D4) und macht Rot-Varianten ohne Deploy möglich. `--strict-mcp-config` ohne Konfiguration schaltet MCP (u. a. mem0) ab: Memory ist keine Quelle (ptc.md § 9.13) |
| D16 | Fälle | **Zwei** Fälle: `4j-ist` (Regression, D14) und `4i-plan` (unkontaminierter Vorhersagefall). Reserve: `4h-plan` (Detailplan-Commit `8bb1f2a`), nur wenn 4I nach Paket 3 weniger als drei Muss-Erwartungen trägt | Budget D7/D23: ein Volllauf ≤ 2 PTc-Läufe. 4I hat die meisten Probleme auf PTc-Achsen (Fakt 6); 4H liegt vor allem auf Tracktion-Interna (Nano), 4G hat drei Detailplan-Entwürfe (`db4a10d`, `6e823bf`, `47d8bad`) und keinen eindeutigen Stand |
| D17 | Fixture-Inhalt | Nur Dokumente, byte-gleich per `git show <commit>:<pfad>` und in der Repo-Struktur (`repo/CLAUDE.md`, `repo/docs/…`). Plan, `PROCESS.md` und `CLAUDE.md` vollständig; `PHASE_4_PLAN.md` nur als **Ausschnitt** (Kopf Z. 1–10 plus die Zeilen, die der Fixture-Plan per Zeile oder D-Nummer nennt, plus die Zeile der eigenen Unterphase) mit Kopfblock „Ausschnitt aus `<commit>`, Originalzeilen …". Je Fall `MANIFEST.md`: Quell-Commit, Pfad, Zeilen, SHA-256 je Datei | `PHASE_4_PLAN.md` hat 108–121 KB; vollständig würde es Lesekosten treiben (D7). Erwartungen binden per Zitat statt per Zeilennummer (D20), Ausschnitte stören darum nicht. Hashes machen „eingefroren" prüfbar (T) |
| D18 | Erwartungen | `expected.md` je Fall, geschrieben von einem **Opus-Subagenten ohne PTc-Ausgabe** (Paket 3) und **vor dem ersten Eval-Lauf committet**; der Commit-Hash steht in jedem Ergebnis | Auswertungen sind Opus (D12). Blind und vorab festgelegt verhindert, dass Erwartungen nachträglich an die Karte angepasst werden (Overfitting, PROCESS.md § Reviews) |
| D19 | Modus und Modell je Fall | `4j-ist`: `PTc:IST`, **Sonnet** · `4i-plan`: `PTc:PLAN`, **Opus** · Effort medium | wie D7 und ptc.md § 7. Die Rot-Variante läuft mit demselben Modell wie ihr Positivlauf, sonst ist ein Verfehlen nicht der Verstümmelung zuzuordnen. 4J auf Sonnet prüft nebenbei den Parameter „IST auf Sonnet" aus ptc.md § 10 |
| D20 | Bewertung | **Opus-Subagent** (frischer Kontext, nur Read/Grep/Glob) mit festem Auftrag `evals/GRADER.md`; erhält nur `expected.md` und die wörtliche Karte, nicht die Begründungen des Ausführenden. **Kein** Bewertungsskript für die Zuordnung; das Skript `evals/run.ps1` liefert nur Messdaten | Die Zuordnung Befund ↔ Erwartung ist semantisch (andere Worte, andere Ebene); ein Stichwort-Skript erzeugt falsche Treffer und falsches Verpasst. Mechanisches (Token, Dauer, gelesene Pfade) macht das Skript |
| D21 | Rot-Varianten | Nicht als Dateien eingecheckt und nie deployt: `evals/variants/<name>.txt` nennt nur die zu entfernenden Überschriften; `evals/run.ps1` erzeugt die Variante zur Laufzeit aus `agent/ptc.md` in einen Temp-Ordner und **prüft**, dass die Überschriften fehlen (sonst Abbruch). Name im Frontmatter `ptc-rot-<name>` | `~/.claude/agents/` lädt jede `.md` als Agent (D4); eine eingecheckte Rot-Fassung könnte versehentlich deployt werden. Schnitt aus der aktuellen Fassung bleibt in 1D gültig |
| D22 | Ablage | Ergebnis je Lauf: `evals/results/<datum>_<fall>_<variante>.md` (Kopf, Bewertung) plus `<gleicher Name>.karte.md` (wörtliche Karte) plus `<gleicher Name>.json` (CLI-Ausgabe). `docs/runs/` bleibt echten Einsätzen in Fremd-Projekten vorbehalten (D13) | Eval-Läufe sind Belegklasse T, Einsätze L; getrennte Orte halten die Bilanz in 1D sauber |
| D23 | Kosten | Ein **Volllauf** = die zwei Positivläufe, Ziel ≤ 250 000 Token **ohne Cache-Read** (geändert, siehe Erkenntnisse Paket 1–2) (D7). Der Rot-Nachweis läuft **einmal** je Fall (2 Läufe) und nur erneut, wenn sich der geschnittene Abschnitt in 1D ändert. Harte Grenze je Lauf über `--max-budget-usd` (Wert in Paket 1 aus dem Trockenlauf) | D7; der Rot-Nachweis prüft den Fall, nicht jede Fassung |
| D24 | Lauf-Gültigkeit | Ein Lauf ist **ungültig**, wenn ein Werkzeugaufruf einen Pfad außerhalb des Lauf-Ordners liest (Auswertung der `stream-json`- bzw. JSON-Ausgabe durch `run.ps1`), wenn das Budget greift oder die Karte fehlt. Ungültige Läufe werden protokolliert, nicht bewertet | Die Fixtures sind alte Stände; liest PTc das echte Yoka-DAW-Repo, sieht es die Erkenntnisse von später und der Vorhersagefall ist kontaminiert |

## Geprüfte Fakten (2026-11-08)

1. **A1 grün, `--agent` mit installiertem Agent:** `claude -p --agent ptc --model haiku --tools "Read,Grep,Glob" --max-budget-usd 0.10 --no-session-persistence --output-format json "Nenne nur Handle und Versionsnummer …"` → `"result":"Handle: **PTc** · Version: **1.0.0**"`, `is_error:false`, 4,8 s, 0,0059 USD, `cache_creation_input_tokens` 29 326 (Grundlast: Systemprompt von Claude Code, globale `CLAUDE.md`, Werkzeuge, Agent).
2. **A1 grün, `--agents <datei>` für Rot-Varianten:** JSON `{"ptc-rot-test":{"description":…,"prompt":"Du bist ROT-TEST, Version 9.9.9 …","tools":["Read"]}}` per `--agents <pfad> --agent ptc-rot-test` → `"result":"ROT-TEST 9.9.9"`. Der Prompt der JSON-Datei ersetzt also die Rolle; keine Datei unter `~/.claude/agents/` nötig.
3. **CLI-Optionen (`claude --help`, 2.1.311):** `--agent`, `--agents <json-or-file>` (Datei nur mit `--print`), `--model`, `--effort`, `--tools`, `--max-budget-usd` (nur `--print`), `--output-format json|stream-json`, `--no-session-persistence`, `--strict-mcp-config`, `--permission-prompts none`. Die JSON-Ausgabe enthält `duration_ms`, `num_turns`, `total_cost_usd`, `modelUsage.<modell>.{inputTokens, outputTokens, cacheReadInputTokens, cacheCreationInputTokens}`.
4. **Yoka-DAW-Commits:** `42e70bf` 4J Detailplan, `981425c` 4J Paket 6 (2026-11-08 09:51), `6f2a690` 4J Paket 6b (Korrekturen aus dem Audit, also nach dem MiMaMa-Lauf); `589c2f3` 4I Detailplan (2026-11-06 23:03), danach 4I Pakete 1–7 bis `33f09aa` Abnahme; `8bb1f2a` 4H Detailplan.
5. **Größen:** `981425c:docs/PHASE_4J_PLAN.md` 350 Zeilen / 79 KB; `589c2f3:docs/PHASE_4I_PLAN.md` 270 Zeilen / 46 KB; `PHASE_4_PLAN.md` 108 KB (`589c2f3`) bzw. 121 KB (`981425c`); `PROCESS.md` 8 KB, `CLAUDE.md` 4 KB.
6. **4I-Erkenntnisse auf PTc-Achsen** (heutige `docs/PHASE_4I_PLAN.md`, § Erkenntnisse): Message-Thread-Warteschlange wächst mit gleichzeitig bewegten Fadern (B1: 8 → 64–68 ms, D307 nur „je Aufruf" erfüllt) · `retired`-Tabellen ohne Schonfrist freigegeben (Review) · `reconnect` während Aufnahme verwirft sie (Review 3. Durchgang) · `SO_REUSEADDR`: zweite Instanz teilt den OSC-Port, „Port belegt" nie gemeldet · `osc.json` kollidiert unter Windows mit der Gerätebelegung `OSC.json` · Note-off eines später belegten Tastendrucks verbraucht (hängende Note) · D299/D307: `UndoManager` kennt nur eine offene Transaktion, „8 Fader = 8 Undo-Schritte" wurde zu „ein Schritt je Fahrt" · Tool-Kontingent 28 von 28 (D309 hob auf 30) · Plan nicht gepflegt (wiederholter Review-Blocker).
7. **Kontamination 4I, teilweise:** Das 4J-Lauf-Protokoll zitiert „Katalog → Review nur bei Zonenänderung (4I:151, 4J:157)"; im Fixture steht die Zeile bei `589c2f3` als Z. 150. Dieser Befund ist durch die Ableitung von v1.0 bekannt (D14) und zählt in 4I **nur als Regression**, nicht als Wirkung. Die übrigen 4I-Probleme kommen in ptc.md und im Lauf-Protokoll nicht vor (Grep `osc|retired|REUSE|reconnect` in `agent/ptc.md` und `docs/runs/`: in Paket 2 bestätigen).
8. **4J-Erwartungen:** Das Lauf-Protokoll `docs/runs/2026-11-08_yoka-daw_4j_mimama-full.md` nennt 6 verifizierte Treffer (gewanderte Falschaussage `PHASE_4_PLAN.md:279`, plan-lokale Review-Ausnahme gegen `PROCESS.md:50`, Zeiten „nicht gemessen", D-Drift 6 von 14, Plugin-Fenster ohne Autosave, kalter Index 261 s > 180 s ohne Aufgabe), 0 Fehlalarme, 5 degradierte Punkte.
9. **Sektionen für Rot-Schnitte** (`agent/ptc.md` v1.0.0): § 2.3 „Ressourcen" Z. 102–111, § 3.4 „Plan-gegen-Ist" Z. 137–144, Ausgabe-Block „PLAN-GEGEN-IST" Z. 237–239, Ausgabe-Zeile „Ressourcen" Z. 234, Verhaltensregel 6 Z. 267.

## Ungeprüfte Annahmen (im genannten Paket zuerst prüfen)

| # | Annahme | Paket | Rückfall |
|---|---|---|---|
| A1 | ~~PTc läuft ohne Dialog~~ **grün** (Fakt 1–3) | – | (wäre gewesen: Lauf als Subagent aus einer Session per `Agent`-Tool mit `subagent_type: ptc`, Karte wörtlich aus dem Ergebnis, Token/Dauer aus der Abschlussmeldung; Rot-Varianten dann nur über eine temporär deployte Kopie mit eigenem Namen) |
| A2 | Ein Lauf mit `--tools "Read,Grep,Glob"` und Arbeitsordner = Temp-Kopie der Fixture liest nur dort; Absolutpfade ins echte Repo kommen nicht vor | 1 (Trockenlauf), jeder Lauf über D24 | Prompt nennt ausdrücklich „Projektwurzel = …, nichts außerhalb lesen"; wiederholt verletzt: `--add-dir` weglassen ist schon Default, dann `--disallowedTools` mit Pfadmuster prüfen |
| A3 | Die globale `~/.claude/CLAUDE.md` wird mitgeladen (Grundlast ≈ 29 000 Token Cache, Fakt 1) und verfälscht nichts, weil sie für alle Varianten gleich ist | 1 | `--bare` braucht `ANTHROPIC_API_KEY` (kein OAuth); falls vorhanden, Trockenlauf mit `--bare --agents` vergleichen und den günstigeren, gleich guten Weg nehmen |
| A4 | Die Token-Summe aus `modelUsage` (input + output + cache read + cache creation) ist mit den ≈ 122 000 Token des 4J-Laufs (Subagent-Zählung) vergleichbar | 4 | beide Größen getrennt ausweisen (Summe und `total_cost_usd`); D7-Grenze in 1D an der CLI-Zählung neu festlegen |
| A5 | Ein Positivlauf ist ausreichend stabil: Wiederholung desselben Laufs ändert Muss-Treffer nicht | 4 | verfehlt v1.0 eine Muss-Erwartung, **ein** Wiederholungslauf; schwankt das Ergebnis, Erwartung als „instabil" markieren und in 1D zwei Läufe je Fall einplanen (Budget neu) |
| A6 | Ohne § 3.4 verfehlt PTc die Plan-gegen-Ist-Erwartungen in 4J; die Meta-Ebene (§ 1, „Stimmt die Selbstbeschreibung …") allein trägt sie nicht | 5 | trifft die Variante sie trotzdem: Erkenntnis „Befund hängt nicht an § 3.4" (Vorschlag für 1D); zweiter Schnitt zusätzlich ohne Meta-Zeile in § 1, sonst Fall nur ohne Rot-Nachweis für diese Erwartung |
| A7 | v1.0 findet in 4I mindestens eine Erwartung, die an § 2.3 hängt (B1 Message-Thread-Warteschlange oder Tool-Kontingent); sonst gibt es nichts, was die Rot-Variante verfehlen könnte | 4 | Rot ohne § 2.3 stattdessen auf 4J (Erwartung „kalter Index 261 s > 180 s ohne Aufgabe"); 4I bleibt dann Messfall ohne Rot-Nachweis bis 1D |
| A8 | Die Fixtures sind ohne Quellcode und Tracktion-Pfade prüfbar (Code-Aussagen werden zu `[UNVERIFIZIERT]`, ptc.md § 0.5) und PTc fragt nicht nach der Prämisse zurück | 1 (Trockenlauf Haiku auf `4i-plan`) | Prompt nennt Objekt, Stand und Ziel ausdrücklich (Vorlage in `evals/cases/<fall>/prompt.txt`) |

## Dateistruktur

| Pfad | Art | Inhalt |
|---|---|---|
| `evals/README.md` | neu | Zweck, Ablauf eines Volllaufs, Rot-Nachweis, Kosten, Gültigkeit (D24) |
| `evals/run.ps1` | neu | ASCII. Parameter `-Case`, `-Variant` (`v` = Repo-Fassung, sonst Name aus `variants/`), `-Model`, `-MaxBudgetUsd`, `-DryRun`. Schritte: Fixture in Temp-Ordner kopieren und Hashes gegen `MANIFEST.md` prüfen · Agent-JSON aus `agent/ptc.md` (bzw. Schnitt) erzeugen, UTF-8 ohne BOM · bei Variante prüfen, dass die Überschriften fehlen · `claude -p …` (D15) mit `prompt.txt` · Ausgabe als `.json`, Karte als `.karte.md`, Kopf von `.md` (Datum, Fall, Variante, SHA-256 der Agent-Fassung, Modell, Effort, Token je Art und Summe, USD, Dauer, Turns, gelesene Pfade, Gültigkeit) nach `evals/results/` |
| `evals/variants/rot-ohne-3-4.txt` | neu | Überschriften: `### 3.4 Plan-gegen-Ist`, Ausgabe-Block `PLAN-GEGEN-IST` (Z. 237–239) |
| `evals/variants/rot-ohne-2-3.txt` | neu | Überschrift `### 2.3 Ressourcen`, Ausgabe-Zeile „Ressourcen" (Z. 234), Verhaltensregel 6 (Z. 267) |
| `evals/GRADER.md` | neu | fester Auftrag des Bewertungs-Subagenten (D20): Eingaben, Regeln, Ausgabeformat (unten) |
| `evals/cases/4j-ist/` | neu | `prompt.txt`, `expected.md` |
| `evals/cases/4i-plan/` | neu | `prompt.txt`, `expected.md` |
| `evals/fixtures/4j-ist/` | neu | `MANIFEST.md`, `repo/CLAUDE.md`, `repo/docs/PHASE_4J_PLAN.md`, `repo/docs/PROCESS.md` (alle `981425c`), `repo/docs/PHASE_4_PLAN.md` (Ausschnitt `981425c`, mindestens Z. 1–10, 56, 58, 81, 84, 248–297 wie im 4J-Lauf gelesen) |
| `evals/fixtures/4i-plan/` | neu | `MANIFEST.md`, `repo/CLAUDE.md`, `repo/docs/PHASE_4I_PLAN.md`, `repo/docs/PROCESS.md` (alle `589c2f3`), `repo/docs/PHASE_4_PLAN.md` (Ausschnitt `589c2f3`: Kopf, Zeilen 49 und 52, D138, D141, D142, D289, Zeile 4I) |
| `evals/results/` | neu | Ergebnisse (D22) |
| `.gitattributes` | ggf. | `evals/fixtures/** -text` nur falls `git show` CRLF liefert; sonst unverändert (LF) |
| `docs/PHASE_1C_PLAN.md`, `docs/PHASE_1_PLAN.md` | Pflege | Statuszeile, Fortschritt, Zeiten, Messwerte |

Nicht geändert: `agent/ptc.md`, `scripts/check.ps1`, `scripts/deploy.ps1`, `~/.claude/agents/`.

**Format `expected.md`** (je Erwartung eine Zeile):

| ID | Art | Befund (Substanz) | Stelle im Fixture (Zitat) | Ebene / Achse | trägt (ptc.md §) | Beleg E (Quelle der Erkenntnis) | Damals gefunden von | Kontaminiert? |
|---|---|---|---|---|---|---|---|---|

- **Art:** `MUSS` (auf Planebene erkennbar, ein PTc-Abschnitt ist dafür da) · `KANN` (erkennbar nur mit Code oder mit Glück; zählt als Bonus-Treffer, Fehlen ist kein Verpasst) · `NICHT` (darf nicht als HART/LECK gemeldet werden: im Plan schon behandelt oder später grün belegt; als offene Frage erlaubt).
- **Damals gefunden von:** `Test` · `Review` · `Abnahme` · `Messung` · `niemand vorher` (für die Spalte Mehrwert, PROCESS.md § Treffer-Bewertung).
- Ein Befund, der im Fixture-Plan selbst schon als Risiko steht (z. B. 4I „Bus-Falle", „Pan und Send"), ist **kein** MUSS.

**Kandidaten 4I** (Paket 3 prüft und belegt, Auswahl dort): MUSS-Kandidaten B1/D307 „Message-Thread-Block ≤ 50 ms je Aufruf" ohne Warteschlangen-Budget bei acht Fadern (§ 2.3 Konkurrenz, § 2.1) · Tool-Kontingent „28 von 28" (§ 2.3 Kontingente) · D307 „acht Fader … 8 Undo-Schritte" gegen D299 eine Geste/`UndoManager` (§ 1 Meso, § 4) · `reconnect` im Lebenszyklus „während Aufnahme" (§ 2.2) · Regression: „Katalog → Review nur bei Zonenänderung" Z. 150 gegen `PROCESS.md` (§ 3.4 Punkt 4 bzw. Meta; kontaminiert, Fakt 7). KANN-Kandidaten: `osc.json`/`OSC.json` (§ 2.4 Wiederverwendung von Kennungen/Pfad), zweite Instanz auf dem Port (§ 2.4, Konkurrenz), Schonfrist `retired`, hängende Note-off. NICHT-Kandidaten: Annahme 2 Fork-Patch, Annahme 5 Loopback, Annahme 3 Hotplug (alle später grün).

**Format Ergebnis `evals/results/<datum>_<fall>_<variante>.md`:**

```
# Eval <fall> · <variante> · <datum>
| Feld | Wert |  (Agent-SHA-256, expected.md-Commit, Fixture-Manifest-Hash, Modell, Effort,
                   Token: input / output / cache read / cache creation / Summe, USD, Dauer s, Turns,
                   gelesene Pfade außerhalb: 0, gültig: ja/nein)
## Bewertung (GRADER, Opus, <Datum>)
| ID | Art | Ergebnis (Treffer / Teiltreffer = nur als offene Frage oder degradiert / Verpasst) | Fundstelle in der Karte (Zitat) |
Fehlalarme: [Befunde gegen NICHT-Erwartungen oder sachlich falsch, mit Zitat]
Weitere Befunde: [nicht in expected.md; Einstufung Offen, für 1D]
Summen: MUSS k/n · KANN k/n · NICHT verletzt k · Fehlalarme k · Mehrwert (Treffer mit „niemand vorher") k
Urteil Fall: grün / rot (nur Positivlauf 4j-ist hat ein Urteil; 4i-plan ist Messung)
```

Kein Score (D3): nur Zählungen je Klasse, keine Quote über Klassen hinweg.

## Aufgaben

### Paket 1: Laufwerkzeug und Trockenlauf

**Modell: Sonnet 5.5, Effort medium**

- [x] `evals/run.ps1` nach „Dateistruktur" (ASCII, JSON per `[System.IO.File]::WriteAllText` mit `UTF8Encoding($false)`), `evals/variants/*.txt`, `evals/README.md`.
- [x] Rot-Nachweis des Schnitts (Testregel): Variante mit einer Überschrift, die es nicht gibt → `run.ps1 -DryRun` bricht ab (rot); korrekte Variante → erzeugte JSON enthält die Überschrift nicht (grün).
- [x] Rot-Nachweis D24: Trockenlauf mit Prompt, der ausdrücklich eine Datei außerhalb liest → Lauf „ungültig".
- [x] Trockenlauf `4i-plan` (Fixture aus Paket 2 vorziehen oder Mini-Fixture) mit **Haiku**, `PTc:LITE`: prüft A2, A3, A8; Karte vorhanden, kein Rückfragen-Abbruch.
- [x] `--max-budget-usd` je Modell aus den USD/Token des Trockenlaufs festlegen: Grenze = Preis von 180 000 Token (≈ 1,5 × Lauf aus D7) → Wert in D23 nachtragen.

**Fertig, wenn:** beide Rot-Nachweise erbracht, Trockenlauf gültig, Budgetwerte eingetragen (T).

### Paket 2: Fixtures einfrieren

**Modell: Sonnet 5.5, Effort medium**

- [x] Per `git -C F:\Yoka\Workspace\Yoka-DAW show <commit>:<pfad>` (nur lesen, D13) die Dateien nach D17 schreiben; Ausschnitte von `PHASE_4_PLAN.md` mit Kopfblock und Originalzeilen.
- [x] `MANIFEST.md` je Fall mit SHA-256; `run.ps1` prüft sie.
- [x] Fakt 7 bestätigen: Grep `osc|retired|REUSE|reconnect|Undo-Schritt` in `agent/ptc.md` und `docs/runs/` → keine 4I-Inhalte außer Z. 150-Befund.
- [x] `prompt.txt` je Fall: `PTc:IST <repo>/docs/PHASE_4J_PLAN.md` mit Stand „Pakete 1–6 umgesetzt" bzw. `PTc:PLAN <repo>/docs/PHASE_4I_PLAN.md` mit Stand „nicht umgesetzt"; Projektwurzel; „nur innerhalb lesen". Keine Hinweise auf erwartete Befunde.

**Fertig, wenn:** beide Fixtures committet, Hashes grün (T).

### Paket 3: Erwartungen (blind)

**Modell: Opus 5.5, Effort medium** (als Subagent aus der Sonnet-Session, D12, D18)

- [x] Subagent erhält: Fixture-Pfade, 4J-Lauf-Protokoll (für `4j-ist`), die heutige `Yoka-DAW/docs/PHASE_4I_PLAN.md` § Erkenntnisse und Zeiten plus `docs/phase4i_abnahme.md` (für `4i-plan`), das Format oben. **Keine** PTc-Ausgabe.
- [x] `4j-ist/expected.md`: die 6 Treffer als MUSS (Plugin-Fenster als LECK-MUSS), die 5 degradierten Punkte als „offene Frage erlaubt, HART verboten" (NICHT), Mehrwert-Spalte aus dem Lauf-Protokoll (alle Meta/Schnittstelle, „niemand vorher"; das ausgelassene Review als Folge).
- [x] `4i-plan/expected.md`: Kandidaten aus „Dateistruktur" prüfen, je Zeile Zitat im Fixture **und** Beleg E in den späteren Erkenntnissen; Kontamination markieren (Fakt 7). Mindestens 3 MUSS, sonst D16-Reserve 4H (Fixture und Erwartungen wie hier, +0,75 h).
- [x] `evals/GRADER.md` schreiben (Regeln: Zuordnung nach Substanz und Stelle, Ebene darf abweichen; Teiltreffer = nur offene Frage/degradiert; Fehlalarm = NICHT-Verletzung oder sachlich falsch mit Gegenzitat aus dem Fixture; weitere Befunde nur auflisten).
- [x] Commit **vor** Paket 4; Hash in D18-Notiz unter „Fortschritt".

**Fertig, wenn:** zwei `expected.md` und `GRADER.md` committet, jede MUSS-Zeile mit Fixture-Zitat und E-Beleg (E).

### Paket 4: Positivläufe v1.0

**Modell: Sonnet 5.5, Effort medium** (Läufe nach D19, Bewertung Opus-Subagent)

- [ ] `run.ps1 -Case 4j-ist -Variant v -Model sonnet` und `-Case 4i-plan -Variant v -Model opus` (im Hintergrund, je ≈ 5 min).
- [ ] Gültigkeit (D24) prüfen; je Lauf Bewertung durch einen frischen Opus-Subagenten nach `GRADER.md`, Ergebnis wörtlich in die Ergebnisdatei.
- [ ] A4, A5, A7 auswerten; bei verfehlter MUSS in 4J ein Wiederholungslauf (A5).
- [ ] Messwerte-Tabelle füllen.

**Fertig, wenn:** `4j-ist` grün (alle MUSS, 0 NICHT verletzt) oder rot mit benannter Ursache für 1D; `4i-plan` bewertet; Volllauf-Token unter „Messwerte" (T).

### Paket 5: Rot-Nachweis

**Modell: Sonnet 5.5, Effort medium**

- [ ] `run.ps1 -Case 4j-ist -Variant rot-ohne-3-4 -Model sonnet` → erwartet: die an § 3.4 hängenden MUSS (D-Drift, gewanderte Falschaussage, Zeiten, Regelkonflikt) verfehlt.
- [ ] `run.ps1 -Case 4i-plan -Variant rot-ohne-2-3 -Model opus` → erwartet: die an § 2.3 hängenden MUSS (B1, Kontingent) verfehlt; Rückfall A7.
- [ ] Bewertung je Lauf durch Opus-Subagenten; Rot gilt, wenn **mindestens eine** Erwartung, die im Positivlauf getroffen wurde und am geschnittenen Abschnitt hängt, verfehlt wird. Getroffene Erwartungen trotz Schnitt → A6, Erkenntnis.

**Fertig, wenn:** je Fall Rot-Nachweis erbracht oder sein Fehlen mit Rückfall begründet (T).

### Paket 6: Abschluss

**Modell: Sonnet 5.5, Effort medium**

- [ ] Erkenntnisse: Änderungsvorschläge für 1D (nur Liste, keine Änderung an `agent/ptc.md`).
- [ ] `PHASE_1_PLAN.md`: Statuszeile, 1C erledigt, Fortschritt, Zeiten; Offene Punkte (A1 erledigt).
- [ ] Merge-Commit nach `main`, Tag `phase-1c`, Push.

**Fertig, wenn:** Merge und Tag gepusht, Plan aktuell.

## Rot-Nachweis-Design

| Variante | Schnitt (aus `agent/ptc.md` zur Laufzeit) | Fall | Modell | muss verfehlen | darf weiter treffen |
|---|---|---|---|---|---|
| `rot-ohne-3-4` | § 3.4 Plan-gegen-Ist (Z. 137–144) und Ausgabe-Block PLAN-GEGEN-IST (Z. 237–239) | `4j-ist` | Sonnet | mindestens eine von: D-Drift 6/14, gewanderte Falschaussage `PHASE_4_PLAN.md:279`, Zeiten „nicht gemessen", Review-Ausnahme gegen `PROCESS.md:50` | Plugin-Fenster-Leck (Meso), kalter Index (Ressourcen) |
| `rot-ohne-2-3` | § 2.3 Ressourcen (Z. 102–111), Ausgabe-Zeile Ressourcen (Z. 234), Verhaltensregel 6 (Z. 267) | `4i-plan` (Rückfall A7: `4j-ist`) | Opus | B1 Warteschlange/Message-Thread bzw. Tool-Kontingent (bzw. kalter Index) | Meso- und Meta-Befunde |

- Ablage der Varianten: nur die Schnitt-Listen in `evals/variants/`; erzeugte Agent-Dateien im Temp-Ordner des Laufs, nie unter `~/.claude/agents/` (D21).
- Aufruf: `powershell -File evals\run.ps1 -Case <fall> -Variant <name> -Model <m>`; der Agent heißt `ptc-rot-<name>`, `--agents <temp>\agents.json --agent ptc-rot-<name>`.
- Sparsam: je Fall genau ein Rot-Lauf (2 Läufe gesamt), nicht je Erwartung; erneut nur, wenn 1D den geschnittenen Abschnitt ändert (D23).

## Kostenbudget

| Posten | Läufe | Token (Schätzung) | Grundlage |
|---|---|---|---|
| Trockenlauf Haiku (Paket 1) | 1–2 | ≈ 50 000 | Grundlast 29 326 (Fakt 1) + Lesen |
| **Volllauf** (Paket 4): `4j-ist` Sonnet + `4i-plan` Opus | 2 | **≤ 250 000** (Ziel ≈ 2 × 110 000) | 4J-Lauf ≈ 122 000 (D7); 4I-Fixture kleiner |
| Rot-Nachweis (Paket 5) | 2 | ≈ 220 000, einmalig | wie Volllauf |
| Wiederholung bei A5 | 0–1 | ≤ 120 000 | nur bei verfehlter MUSS |
| Bewertung Opus-Subagent | 4 | ≈ 4 × 25 000 = 100 000 | liest nur Karte + `expected.md` |
| Erwartungen Opus-Subagent (Paket 3) | 1 | ≈ 80 000 | Fixtures + 4I-Erkenntnisse |
| **Summe 1C** | | **≈ 0,6–0,7 Mio.** | davon wiederkehrend je Volllauf ≤ 250 000 + 50 000 Bewertung |

Harte Grenze je Lauf: `--max-budget-usd` (Paket 1, D23). Überschreitet ein Positivlauf 150 000 Token, steht das als Erkenntnis für 1D (Lesestrategie).

## Messwerte

| Lauf | Modell | Token Summe | davon Cache | USD | Dauer | Turns | gültig | MUSS | KANN | NICHT verletzt | Fehlalarme |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Trockenlauf `4i-plan` LITE | Haiku | 436 681 (ohne Cache-Read 83 336) | 353 345 | 0,0285 | 137,5 s | 10 | ja | – | – | – | – |
| `4j-ist` v1.0 | Sonnet | | | | | | | | | | |
| `4i-plan` v1.0 | Opus | | | | | | | | | | |
| `4j-ist` rot-ohne-3-4 | Sonnet | | | | | | | | | | |
| `4i-plan` rot-ohne-2-3 | Opus | | | | | | | | | | |
| **Volllauf** (Summe Positivläufe) | | | | | | | | | | | |

## Erkenntnisse

### Planung (2026-11-08)

- **A1 grün:** PTc läuft ohne Dialog; die Agent-Definition lässt sich per JSON-Datei übergeben. Damit sind Rot-Varianten ohne Deploy möglich (D21) und das Eval-Set prüft die Repo-Fassung, nicht die Kopie.
- **Grundlast ≈ 29 000 Token** je Lauf (Cache-Erzeugung, Fakt 1) unabhängig von der Fixture; sie zählt in D7 mit.
- **Fixture-Wahl:** 4I ist der einzige Vorhersagefall (D16). Sein Wert liegt in den Querachsen, die 4J kaum hatte (Threads, Lebenszyklus, Fehlerarten, Kontingent). Teil-Kontamination über die Z.-150-Regel (Fakt 7) ist markiert.
- **Mögliche Änderungsvorschläge für 1D** (nur Hypothesen, Evals bestätigen oder verwerfen): (1) § 2.3 um „Warteschlange/Durchsatz unter gleichzeitiger Last" ergänzen, falls B1 verpasst wird (Budget „je Aufruf" ≠ Wartezeit); (2) § 2.4 „Kennungen" um Groß-/Kleinschreibung von Dateinamen unter Windows und Port-Teilung zweier Instanzen ergänzen, falls die KANN-Fälle durchweg fehlen; (3) § 7 „IST auf Sonnet" nach `4j-ist` bestätigen oder auf Opus heben (§ 10); (4) Prompt-Vorlage für Läufe ohne Dialog (Objekt/Stand/Ziel) in den QUICK START, falls A8 Rückfragen zeigt; (5) Lese-Regeln schärfen, falls ein Lauf > 150 000 Token braucht; (6) Hängen Plan-gegen-Ist-Befunde nicht an § 3.4 (A6), § 3.4 kürzen statt erweitern.

## Zeiten

| Paket | Inhalt | Schätzung | Start | Ende | Ist | Quelle |
|---|---|---|---|---|---|---|
| Detailplan | dieser Plan, A1 geprüft, Fixture-Wahl | 0,5–0,75 h | 2026-11-08 ≈ 13:55 | 2026-11-08 14:20 | ≈ 0,4 h | Session |
| 1 | `run.ps1`, Varianten, Trockenlauf, Budgetgrenzen | 0,75 h | 2026-11-08 14:42 | 2026-11-08 14:58 | ≈ 0,27 h | Session |
| 2 | Fixtures, Manifeste, Prompts | 0,5 h | 2026-11-08 14:50 (mit Paket 1 vorgezogen) | 2026-11-08 14:58 | ≈ 0,15 h | Session |
| 3 | Erwartungen und `GRADER.md` (Opus-Subagent) | 0,75 h | 2026-11-08 14:59 | 2026-11-08 15:10 | ≈ 0,2 h | Session |
| 4 | Positivläufe, Bewertung, Messwerte | 0,75 h (Läufe ≈ 2 × 5 min im Hintergrund) | | | | |
| 5 | Rot-Nachweis | 0,5 h | | | | |
| 6 | Erkenntnisse, Plan, Merge, Tag | 0,25 h | | | | |
| **Summe Umsetzung** | Paket 1–6 | **≈ 3,5 h** (Reserve 4H: + 0,75 h) | | | | |

### Paket 1–2 (2026-11-08)

- **Rot-Nachweis Schnitt (T):** `run.ps1 -DryRun` mit `variants/rot-test-fehlt.txt` (Überschrift `### 9.9 …` gibt es nicht) → Abbruch „Schnitt-Ueberschrift nicht gefunden" (rot). `rot-ohne-3-4` → erzeugte `agents.json` enthält weder `3.4 Plan-gegen-Ist` noch `PLAN-GEGEN-IST (nur`, aber § 2.3 noch; `rot-ohne-2-3` umgekehrt; Repo-Fassung `v` enthält beides (grün). Geschnittene Zeilen: 3-4: 137–145 und 228–230 (nach dem ersten Schnitt verschoben); 2-3: 102–112, 223, 255. `rot-test-fehlt.txt` bleibt als Testfall im Repo.
- **Rot-Nachweis D24 (T):** Haiku-Lauf mit Prompt „lies `F:\Yoka\Workspace\Probatio-Technica\CLAUDE.md`" → `Read` auf den Absolutpfad erkannt, Lauf **ungültig** (Exit 2). Zusatzbefund: Das CLI verweigerte den Zugriff selbst (Pfad außerhalb der Arbeitsverzeichnisse, `--permission-prompts none`); D24 bleibt als zweite Sicherung.
- **A2 grün:** Gültiger Lauf ohne Zugriff außerhalb (0 von 9 Werkzeugaufrufen). Erster Versuch war „ungültig" wegen Fehlern des Prüfers (Grep-Regex als Pfad gewertet, Fixture-Elternordner statt `repo/`). **Geändert:** Arbeitsordner und Lauf-Ordner im Sinne D24 ist jetzt nur die Kopie von `repo/` (Manifest liegt außerhalb); Grep-`pattern` zählt nicht als Pfad, nur Glob-`pattern`.
- **A3 teilweise:** Globale `CLAUDE.md`/Grundlast ist für alle Varianten gleich; `--bare` nicht versucht (braucht API-Key, nicht vorhanden angenommen). Kein Rückfall nötig, Grundlast bleibt in den Zahlen.
- **A4 geändert:** Die Summe inkl. Cache-Read ist **nicht** mit der Subagent-Zählung (≈ 122 000) vergleichbar: Haiku LITE 436 681 gesamt, aber 353 345 davon Cache-Read (jeder Turn zählt den Kontext erneut). `run.ps1` weist beides aus (Summe aller Arten; ohne Cache-Read = input + output + cache creation, hier 83 336). Für die Ziel-Grenze D7/D23 (≤ 250 000) gilt **„ohne Cache-Read"** plus USD; Rückfall aus A4 angewandt. D23 entsprechend geändert, siehe Erkenntnisse.
- **A8 grün:** Mit `prompt.txt`-Vorlage (Objekt, Stand, Ziel, „keine Rückfragen") gab Haiku PRÄMISSE „geklärt" und eine Karte ohne Rückfrage. Der erste Versuch (Haiku, 21 Turns, 260 s, 921 042 gesamt) zeigt: LITE auf Haiku ist nicht billig (53 k Output).
- **Fakt 7 bestätigt (T):** Grep `osc|retired|REUSE|reconnect|Undo-Schritt` in `agent/ptc.md` und `docs/runs/`: keine Treffer in `ptc.md`; im Lauf-Protokoll nur die Z.-150-Regel (4I:151/4J:157) und „Undo-Schritt beim Speichern" (4J, anderer Befund). Keine 4I-Kontamination darüber hinaus.
- **Fixtures (D17):** `4j-ist` aus `981425c` (CLAUDE 4314 B, PROCESS 8726 B, PHASE_4J 79 291 B; Ausschnitt `PHASE_4_PLAN.md` Z. 1–10, 56, 58, 81, 84, 101, 248–297), `4i-plan` aus `589c2f3` (PHASE_4I 46 037 B; Ausschnitt Z. 1–10, 49, 52, 80, 84, 101, 104–105, 240). Im Ausschnitt trägt jede Zeile das Präfix `[Z.n]`. D289 steht nicht im Gesamtplan (nur im 4I-Plan), daher kein Ausschnitt dazu. LF, keine CRs; `.gitattributes` unverändert.
- **Budgetgrenze (D23, vorläufig):** `--max-budget-usd` Standard 2,0 (Sonnet), 4,0 (Opus) als harte Obergrenze; Haiku-Lauf 0,029 USD für 83 k Token ohne Cache-Read. Wert nach dem ersten Sonnet-/Opus-Lauf anhand der echten USD nachtragen (Preis von 180 000 Token ist ohne Preisliste der Modelle nicht ableitbar).

### Paket 3 (2026-11-08)

- **Erwartungen blind (D18):** Opus-Subagent (225 159 Token, 5,4 min; Plan schätzte 80 000) schrieb `evals/cases/4j-ist/expected.md` (6 MUSS J1–J6, 2 KANN, 5 NICHT) und `evals/cases/4i-plan/expected.md` (5 MUSS I1–I5, davon I5 kontaminierte Regression, 7 KANN, 5 NICHT) ohne PTc-Ausgabe. Zitate per Grep im Fixture geprüft. Reserve 4H nicht nötig (≥ 3 MUSS ohne Kontamination: I1–I4).
- **Abweichungen vom Plan, vom Subagenten gefunden:** (1) Die Gegenstelle „`PROCESS.md:50`" aus dem 4J-Protokoll gibt es in der 4I-Fixture-`PROCESS.md` nicht; sie ist dort `:42` und `:45` (in `expected.md` vermerkt). (2) Im 4J-Fixture stehen sechs Pakete mit „nicht gemessen" (Z. 342–347), nicht fünf. (3) J5 (Plugin-Fenster) wurde damals vom Review (Paket 2) gefunden, nicht „niemand vorher". (4) I2 teilweise kontaminiert (Katalog-Reserve-Gedanke im 4J-Protokoll). (5) „Damals gefunden von" bei I8, I9, I11 = „Umsetzung" (zählt nicht als Mehrwert). Grenzfälle: I4 (reconnect während Aufnahme) als MUSS, I6 als KANN.
- **Rot-Zuordnung laut Erwartungen:** `4j-ist`: J3, J4 hängen ganz an § 3.4, J1 überwiegend, J2/J6 teilweise. `4i-plan`: I1, I2 an § 2.3 (I1 kann auch über § 2.1 als Teiltreffer ohne Budget kommen).
- **Commit der Erwartungen (D18): `fd2b581`**, vor dem ersten Eval-Lauf. Der Hash steht in jedem Ergebnis.
