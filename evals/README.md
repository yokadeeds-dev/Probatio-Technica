# evals/ - Eval-Set fuer PTc

Zweck: Jede PTc-Fassung laeuft ohne Dialog gegen eingefrorene Faelle mit bekannten Befunden. Grundlage: `docs/PHASE_1C_PLAN.md` (D15-D24), `docs/PROCESS.md` (Treffer-Bewertung, Testregel).

| Fall | Art | Modus / Modell | Fixture |
|---|---|---|---|
| `4j-ist` | Regressionsfall (D14) | `PTc:IST`, Sonnet | Yoka-DAW `981425c` (4J nach Paket 6) |
| `4i-plan` | Vorhersagefall | `PTc:PLAN`, Opus | Yoka-DAW `589c2f3` (4I-Detailplan) |

## Aufbau

- `fixtures/<fall>/MANIFEST.md` + `repo/...`: byte-gleich per `git show` (Yoka-DAW nur gelesen). `PHASE_4_PLAN.md` ist ein Ausschnitt (Kopfblock, Zeilen mit `[Z.n]`). `run.ps1` prueft SHA-256 aller Dateien, auch auf Zusatzdateien.
- `cases/<fall>/prompt.txt`, `expected.md` (blind von einem Opus-Subagenten geschrieben und vor dem ersten Lauf committet, D18).
- `variants/<name>.txt`: Schnittliste fuer Rot-Varianten (D21). Zeilen `section|<Zeilenanfang>` (bis zur naechsten `#`-/`---`-Zeile), `block|<Zeilenanfang>` (bis zur naechsten Leerzeile), `line|<Zeilenanfang>`. `run.ps1` bricht ab, wenn ein Anfang nicht gefunden wird (Rot) und prueft nach dem Schnitt, dass er fehlt.
- `GRADER.md`: fester Auftrag des Bewertungs-Subagenten (D20).
- `results/<datum>_<fall>_<variante>[_<tag>].md|.karte.md|.json`: Kopf mit Messdaten und Bewertung, woertliche Karte, CLI-Ausgabe (`stream-json`, eine JSON-Zeile je Ereignis).

## Lauf

```powershell
powershell -File evals\run.ps1 -Case 4j-ist -Variant v -Model sonnet -MaxBudgetUsd 2
powershell -File evals\run.ps1 -Case 4i-plan -Variant v -Model opus -MaxBudgetUsd 3
powershell -File evals\run.ps1 -Case 4j-ist -Variant rot-ohne-3-4 -Model sonnet
powershell -File evals\run.ps1 -Case 4i-plan -Variant rot-ohne-2-3 -Model opus
powershell -File evals\run.ps1 -Case 4i-plan -Variant rot-ohne-2-3 -DryRun   # nur Schnitt pruefen
```

`-Variant v` = Repo-Fassung `agent/ptc.md` (Agent-Name `ptc-eval`, nie die deployte Kopie). Rot-Varianten werden zur Laufzeit im Temp-Ordner erzeugt und nie deployt. Optional `-PromptFile`, `-Tag`, `-AgentPath`.

Der Lauf startet `claude -p --agents <json> --agent <name> --tools "Read,Grep,Glob" --strict-mcp-config --no-session-persistence --permission-prompts none --output-format stream-json --verbose` mit Arbeitsordner = Temp-Kopie von `repo/`. MCP (mem0) ist aus: Memory ist keine Quelle.

## Gueltigkeit (D24)

Ein Lauf ist **ungueltig** bei Zugriff eines Werkzeugs auf einen Pfad ausserhalb der Temp-Kopie (aus den `tool_use`-Ereignissen), bei `is_error` (z. B. Budget), oder wenn die Karte fehlt. Ungueltige Laeufe werden protokolliert und nicht bewertet. Exit-Code 2.

## Bewertung

Kein Skript fuer die Zuordnung. Ein frischer Opus-Subagent bewertet nach `GRADER.md` (nur `expected.md` und Karte). Kein Score (D3): nur Zaehlungen je Klasse.

## Kosten

Token: `run.ps1` weist **Summe aller Arten** (inkl. Cache-Read, mehrfach gezaehlt je Turn) und **ohne Cache-Read** getrennt aus; massgeblich fuer das Budget ist USD. Grundlast je Lauf ca. 29 000 Token Cache (Claude-Code-Systemprompt, globale `CLAUDE.md`, Werkzeuge).
