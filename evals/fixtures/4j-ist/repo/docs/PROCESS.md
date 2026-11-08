# Prozess und Abnahme

## Belegklassen

| Klasse | Quelle | Gewicht |
|---|---|---|
| **A** | Audit-Log `F:\Yoka\DAW-Daten\Logs\mcp_audit.jsonl` | Primärer Nachweis für MCP-Aufrufe |
| **D** | Desktop-Log `%LOCALAPPDATA%\Claude\Logs\mcp-server-yoka-mcp.log` | Unterstützender Nachweis für Protokoll- und Clientverhalten |
| **T** | Testausgabe (`ctest`, Build, Skript) | Nachweis für automatisierte Prüfungen |
| **Y** | Yokas Meldung im Chat | Nur Kontext, kein Prüfnachweis |

## Abnahmeregeln

1. Eine Abnahme braucht mindestens einen Beleg der Klasse **A** oder **T**.
2. **Y** trägt eine Abnahme nie allein.
3. Jede Abnahme-Zeile nennt Quelle und Zeitstempel, bei MCP zusätzlich die `call_id`.
4. "Fertig" heißt: Der konkrete Nachweis liegt vor, nicht nur eine plausible Beschreibung.
5. MCP-Abnahmen laufen über einen Client, der nicht die implementierende Session ist (z. B. Claude Desktop). Der Client wird in der Abnahme-Zeile genannt.

Geltung: ab Phase 3C. Frühere Abnahmen (2E, 2F, 3B) bleiben unverändert.

Hardware- und GUI-Schritte (ASIO, L-12, Oberfläche) sind nur von Hand prüfbar. Yokas Meldung (Y) allein reicht auch dort nicht (Regel 2): Zusätzlich muss ein Log oder Testlauf den Zustand belegen, z. B. `F:\Yoka\DAW-Daten\Logs\performance.jsonl` (zählt als A) oder ein `query.performance`-Ergebnis.

## Reviews

- **Normale Änderungen:** Tests plus Handabnahme durch Yoka.
- **Kernänderungen:** zusätzlich ein unabhängiger Review-Subagent mit frischem Kontext.
- **Kernbereiche:** Befehls-Bus, Session-/Dateiformat, Undo/Revision, Plugin-Host, Datei-I/O, MCP-Pipe, Audio-/Realtime-Pfade.

**Kernänderung = Änderung an einem dieser Pfade** (gegen den Baum geprüft, Stand 2026-10-28):

| Bereich | Pfade |
|---|---|
| Befehls-Bus, Register | `src/core/yoka/CommandBus.*`, `CommandRegistry.*`, `CommandResult.*`, `ParamValidator.*`, `registry/commands.json` |
| Undo/Revision, Events | `src/core/yoka/EventLog.*`, `src/core/yoka/commands/EditCommands.cpp`, Undo-Verhalten in `registry/commands.json` |
| Session-/Dateiformat | `src/core/yoka/ProjectSession.*`, `src/core/yoka/commands/ProjectCommands.cpp`, `src/core/yoka/DrumMap.*` (Drum-Map `YOKA_DRUMMAP` im Projekt, 4E) |
| Plugin-Host | `src/core/yoka/PluginScanner.*`, `WatchedPluginScanner.*`, `ProcessWatch.*`, `src/core/yoka/commands/PluginCommands.cpp`, `PluginHelpers.h` |
| Datei-I/O | `src/core/yoka/DataFolders.h`, `UsageLog.*`, `GroovePool.*`, `GrooveFile.h` (`grooves.xml`, 4E), `ProjectCache.*` (Render-Cache je Projekt, D269–D273), `src/core/yoka/ipc/AuditLog.*`, Dateizugriffe in `src/core/yoka/commands/` |
| Routing, Automation, Struktur (4G) | `src/core/yoka/RoutingGraph.h`, `AutomationMath.h`, `src/core/yoka/commands/RoutingCommands.cpp`, `RoutingHelpers.h`, `AutomationCommands.cpp`, `AutomationHelpers.h`, `MarkerCommands.cpp`, `TrackCommands.cpp` (`track.move`, Ordner, Ausgang), `ProjectCache.*` (`migrateBusFolders`, `fixOutputTexts`) |
| Racks (4H) | `src/core/yoka/RackModel.h`, `PadNoteFilter.*` (Audio-Thread), `src/core/yoka/commands/RackCommands.cpp`, `RackHelpers.h`, `PluginHelpers.h` (Plugins in Racks), `PluginCommands.cpp` (`macro:N`, Sperre für Racks), `AutomationHelpers.h` (Rack-Ziele) |
| Controller und OSC (4I) | `src/core/yoka/controller/**` (MIDI-Thread: FIFO und Bit-Tabelle, Datei-I/O der Belegung, Gesten), `src/core/yoka/commands/ControllerCommands.cpp`, `src/app/ControllerIO.*` (Geräte, OSC-Socket), Fork-Patch `consumesMessage` (`tracktion_PhysicalMidiInputDevice.*`) |
| MCP-Pipe | `src/core/yoka/ipc/**`, `src/core/yoka/ModalState.*` (D155), `src/mcp/yoka_mcp/link.py`, `winpipe.py` |
| MCP-Zonen und Katalog | Zonen in `registry/commands.json`, `registry/mcp_tools.json`, `src/mcp/yoka_mcp/catalog.py`, `runtime.py` |
| Audio-/Realtime-Pfade | `src/core/yoka/AudioMetrics.*`, `src/core/yoka/MasterAnalysis.*`, `src/core/yoka/ProjectSession.*`, `src/core/yoka/commands/AudioCommands.cpp`, `InputCommands.cpp`, `TransportCommands.cpp`, `PerformanceCommands.cpp`, `NotePreview.*` (Vorhören im Audio-Graph, 4E), `WarpMath.h`, `commands/WarpCommands.cpp`, `commands/TrackCommands.cpp` (Freeze-Vorprüfung, D267), `RenderService.*` (Quellen-Wartezeit), `src/app/AppContext.*` |

Bei Unsicherheit gilt die Änderung als Kernänderung. Neue Dateien in diesen Ordnern gehören dazu; ändert sich der Baum, wird diese Liste im selben Commit angepasst.

### Review-Subagent

**Kernpfade** (Review Pflicht): `CommandBus.*`, `registry/*`, `commands/`, `DataFolders.h`, `ModalState.*`, `src/app/AppContext.*`; ab 4J zusätzlich `src/core/yoka/project/**` (Speichern, Versionen, Autosave: Datei-I/O, Thread) und `src/core/yoka/browser/**` (Index-Thread, Datei-I/O, Vorschau-Edit: Audio).

Bei Kernänderungen den Agenten `code-reviewer` aufrufen (`.claude/agents/code-reviewer.md`, nur lesende Tools): Read, Grep, Glob, ohne Bash. Gegen Selbst-Review gilt D292:

- **Anderes Modell:** Der Reviewer läuft fest auf Opus 5.5 (`model: opus` im Agenten), die Umsetzung auf Sonnet 5.5 (D161). Läuft eine Umsetzung selbst auf Opus (schwierige Fehlersuche), bleibt der Reviewer trotzdem ein frischer Agent ohne Begründungen.
- **Diff mechanisch, nicht ausgewählt:** Vor dem Commit der Aufgabe `git add -N .` (neue Dateien sichtbar machen), dann die **vollständige** Ausgabe von `git diff HEAD` mitgeben, ohne Pfadfilter und ohne Kürzung. Der zweite Durchgang nach Korrekturen bekommt wieder den vollständigen Diff plus die Blocker-Liste des ersten.
- **Urteil wörtlich festhalten:** Das Ergebnis („kein Blocker" bzw. die Blocker-Liste) steht wörtlich in § Fortschritt des Unterphasen-Plans, im selben Commit. Einen Blocker hebt nur der zweite Review-Durchgang auf, nicht der Implementierer; hält der Implementierer einen Blocker für falsch, trägt er Befund und Gegenargument ein und hält an (echter Blocker laut D291).
- **Prüfwerkzeuge ohne KI (geplant, D292):** statische Analyse (MSVC `/analyze` oder clang-tidy) auf den Kernpfaden und ein Testlauf mit AddressSanitizer. Eigenes Paket an einer Unterphasen-Grenze (PHASE_4_PLAN.md § Offene Punkte); bis dahin gilt nur der Review-Subagent.

- **Erhält:** Aufgabe, Diff, relevante Pläne/ADRs, Testergebnisse.
- **Erhält nicht:** die Begründungen des implementierenden Agenten.
- **Prüft:** Absicht, Annahmen, Fehlerfälle, Undo, Audit.
- **Realtime-Checkliste** (bei Änderungen am Audio-Pfad):
  - Allokationen im Audio-Thread
  - Locks und mögliche Prioritätsinversion
  - Graph-Rebuilds während der Wiedergabe
  - Blockierende I/O
- **Ergebnis:** "kein Blocker" oder Blocker mit Datei, Zeile und Begründung.

## Ablauf und Freigaben

Gilt ab 3C Aufgabe 5 (D114, Yoka 2026-10-26).

- **Folgeaufgaben (D291, ersetzt D162):** Ist eine Aufgabe fertig (Tests grün in Debug und RelWithDebInfo, Review ohne Blocker, Commit gepusht), arbeitet Claude die nächste Aufgabe und das nächste Paket der Unterphase in **derselben Session** ab, von der Umsetzung bis zur Abnahme. Anhalten nur für Yoka (Hardware, GUI, Abnahme, „Für Yoka" im Plan) oder bei einem echten Blocker. Der Detailplan bleibt eine eigene Session (D161). Modell und Effort je Paket laut Plan.
- **Zeitschätzung (Yoka 2026-11-06):** Beim Start jeder Umsetzungs-Session einer Unterphase gibt Claude Yoka eine grobe Schätzung „Start Paket 1 bis erster Eingriff Mensch“ (Spanne in Stunden, je Paket kurz, und wann Yoka gebraucht wird). Damit die Schätzung besser wird, trägt die Session je Paket Start- und Endzeit in den Fortschritt des Unterphasen-Plans ein (Tabelle „Zeiten“, Endzeit aus `git log`).
- **Review-Korrekturen:** Wurden Blocker behoben, prüft ein zweiter Review-Durchgang die Korrekturen, bevor die Aufgabe als fertig gilt.
- **G4-Fragen:** Claude entscheidet nach der eigenen Empfehlung und trägt die Entscheidung als „nach Empfehlung" mit Begründung in den Plan ein. Yoka kann sie jederzeit ändern.
- **Merge und Tag:** Nach der letzten Aufgabe einer Unterphase merged Claude den PR nach `main` (Merge-Commit) und setzt den Tag `phase-<n><X>`.
- **Upstream-Prüfung (D208):** Vor jedem Detailplan `.\scripts\upstream_check.ps1`; bei GELB oder ROT zuerst den Abgleich nach [UPSTREAM.md](UPSTREAM.md) § B als eigenes Paket, dann den Detailplan. Mitten in einer Unterphase wird nichts abgeglichen.
- **Yoka:** nur für Schritte, die ein Mensch machen muss (Hardware, GUI, Abnahme mit Claude Desktop), und für die Abnahme am Ende einer Unterphase bzw. Phase. Die Abnahmeregeln oben gelten unverändert.

## Testregel

Ein Schutz-, Fehlerfall- oder Regressionstest gilt erst als valide, wenn er mindestens einmal gegen eine absichtlich fehlerhafte Implementierung rot war. Smoke- und Dokumentationstests sind ausgenommen.
