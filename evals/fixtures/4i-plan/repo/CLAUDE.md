# Yoka-DAW – Einstieg für jede Session

Antworten auf Deutsch, knapp, Aktion zuerst. Verbindliche Projektregeln:
`.claude/skills/tracktion-daw/SKILL.md`. Prozess und Abnahme: `docs/PROCESS.md`.

## Vision
Private Studio-DAW für Windows auf Tracktion Engine + JUCE. Nachbau, keine Veröffentlichung (Ausnahme: privater Beta-Test mit Quelltext, D243).
VST3 Pflicht, CLAP optional (Phase 6). Jede Funktion läuft über den Befehls-Bus
und ist damit per KI/MCP steuerbar.
- Phasen 1–6: `docs/architektur_skizze.md` § Phasenplan
- Feature-Prioritäten Muss/Soll/Später: `docs/vision/feature_matrix.md`
- Grenzen aus der Nachprüfung: `docs/vision/nachpruefung.md`
  (Track-/Clip-Plugins 2 Kanäle → Surround später; CLAP braucht eigene Host-Schicht)
- Recherche-Grundlage: `docs/research/`
- Prioritäten: Stabilität > Echtzeit > Steuerbarkeit > Workflow/UI > Live

## Grundentscheidungen
| Thema | Entscheidung | Quelle |
|---|---|---|
| MCP | eigener Prozess, stdio zu Claude, Named Pipe zur DAW; die DAW ist die Vertrauensgrenze | SKILL.md § MCP, D69–D75 |
| Undo | inverse Aktionen (ValueTree + JUCE UndoManager); ein Befehl oder Tool = eine Transaktion | SKILL.md, D78 |
| Clip-Analysen | Cache neben dem Projekt; nur manuelle Korrekturen in der Projektdatei | SKILL.md § Daten |
| Build | Visual Studio + CMake; `yoka_core` STATIC (JUCE/Tracktion einmal je Konfiguration); Build-Ordner `C:\Yoka\Build\Yoka-DAW` (NVMe), Repo bleibt auf F:; Tests `.\scripts\run_tests.ps1` | D113, README |
| Fork | private Mirrors `yokadeeds-dev/tracktion_engine` und `yokadeeds-dev/JUCE`, Branch `yoka/main` | README |
| Ausführungsort | nur lokal, keine Cloud-Sessions | D112 (ersetzt D87) |

Alle Einzelentscheidungen: D1–D68 `docs/PHASE_2_PLAN.md`, D69–D136 `docs/PHASE_3_PLAN.md`, D137 ff. `docs/PHASE_4_PLAN.md`
(Details in den Unterphasen-Plänen `docs/PHASE_<n><X>_PLAN.md`).

## Architektur
`registry/commands.json` → Befehls-Bus `src/core/yoka/` → App `src/app/` (UI nur über den Bus)
· Pipe `src/core/yoka/ipc/` → MCP-Server `src/mcp/` (Python, uv) · Tools `registry/mcp_tools.json`.
Daten: `F:\Yoka\DAW-Daten`.

## Werkzeuge
- Lokal: `yoka-mcp` (`.mcp.json`, liest die laufende `YokaDAW.exe`), Nicker als eigener MCP-Server
  `ki-studio-mackie` (D86), Context7 über das Docker MCP Gateway (SKILL.md § Arbeitsweise).
- Cloud-Sessions werden nicht mehr genutzt (D112).

## Stand
Einzige Quelle: Statuszeile und § Fortschritt im aktuellen Phasenplan (`docs/PHASE_4_PLAN.md`)
auf dem Arbeitsbranch. Arbeitsbranch finden: `gh pr list` (offener Draft-PR der laufenden
Unterphase). `main` ist während einer Unterphase absichtlich älter.

## Offene Punkte
Liste in `docs/PHASE_4_PLAN.md` § Offene Punkte; Befunde C und E in `docs/PHASE_2_PLAN.md`.
Abgeschlossene Pläne (Phase 2, 3, Unterphasen mit Tag) und `docs/archiv/` nur bei Bedarf lesen.

## Arbeitsweise
- Eine Unterphase pro Session (D291, ersetzt D162): alle Pakete der Unterphase nacheinander von der Umsetzung bis zur Abnahme, ohne Rückfrage dazwischen; anhalten nur für Yoka (Hardware, GUI, Abnahme) oder bei echtem Blocker. Der Detailplan ist eine eigene Session. Vor dem Start `git fetch` und Branch laut Plan.
- Modell und Effort (D161): Detailpläne Opus 5.5, Effort medium (high bei echten Abwägungen); Umsetzung, Handproben, Abnahme-Protokolle Sonnet 5.5, Effort medium; schwierige Fehlersuche Opus 5.5. Beim Start einer Folge-Session `model` und Effort so setzen.
- Was in Plänen oder Entscheidungen steht, nicht erneut fragen. G4-Fragen nach Empfehlung entscheiden und als „nach Empfehlung" dokumentieren (D114).
- Fertige Aufgabe (grün, Review ohne Blocker, gepusht) → nächste Aufgabe laut Plan in derselben Session; Merge und Tag nach der letzten Aufgabe einer Unterphase durch Claude. Yoka nur für Hardware, GUI und Abnahmen (D114, `docs/PROCESS.md` § Ablauf und Freigaben).
- Yoka nie zum Lesen, Suchen oder Kopieren auffordern: selbst nachsehen.
- Jeder Unterphasen-Commit pflegt den Plan im selben Commit mit.
- Kein Arbeitsstand außerhalb des Repos. Jede Aufgabe endet mit grünen Tests (`run_tests.ps1`; zeigt nur Fehler, `-Full` für alles).
- Token sparen (D163): nur die Pläne lesen, die die Aufgabe braucht; große Dateien abschnittsweise; Testausgaben nicht vollständig in den Kontext holen.
