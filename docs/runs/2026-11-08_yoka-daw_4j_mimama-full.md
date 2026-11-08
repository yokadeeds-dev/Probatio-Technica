# Lauf 2026-11-08 · Yoka-DAW 4J · MiMaMa:FULL (Vorläufer von PTc)

| Feld | Wert |
|---|---|
| Datum | 2026-11-08 |
| Projekt | Yoka-DAW (`F:\Yoka\Workspace\Yoka-DAW`, Branch `phase-4j-workflow`) |
| Objekt | `docs/PHASE_4J_PLAN.md`, Stand: Pakete 1–5 committet, Paket 6 im Arbeitsbaum |
| Werkzeug | MiMaMa v1.1 (`~/.claude/agents/mimama.md`), unverändert |
| Modus | `MiMa:FULL` mit vorab geklärter Prämisse, Zusatzabschnitt „PASSUNG" |
| Modell | Opus 5.5 (Subagent, vom Aufrufer geerbt) |
| Token | ≈ 121 838 |
| Dauer | 257 s |
| Werkzeug-Aufrufe | 8 |
| Art | **rückblickend, kontaminiert** (D14): der Plan enthielt seine Erkenntnisse schon; PTc v1.0 wurde aus diesem Lauf abgeleitet |

## Auswertung

Nachgeprüft am 2026-11-08 durch die aufrufende Session (Grep/Read gegen die Dateien):

| Befund | Einstufung | Beleg |
|---|---|---|
| `PHASE_4_PLAN.md:279` nennt `replaceFileIn`, umgesetzt ist `MoveFileExW` (gewanderte Falschaussage) | Treffer | E: Zeile 279 gelesen; Erkenntnisse Paket 2 |
| Planvorlage „Katalog → Review nur bei Zonenänderung" (4I:151, 4J:157) ohne D-Nummer gegen `PROCESS.md:50` (`registry/*` Review-Pflicht) | Treffer | E: Grep über `docs/`, keine deckende Entscheidung |
| Zeiten-Tabelle: alle Pakete „nicht gemessen" gegen `PROCESS.md:74` | Treffer | E: Zeilen 342–347 |
| D-Drift: D311, D313, D316, D319, D321, D323 weichen von der Umsetzung ab (6 von 14) | Treffer | E: D-Tabelle Z. 23–36 gegen Erkenntnisse Paket 2–5 |
| Plugin-Fenster-Änderungen lösen kein Autosave aus | Treffer (bekannt, nach D313 gewollt), als offener Punkt gemeldet | E: Review Paket 2 |
| Kalter Index 261 s > 180 s, Entscheidung nicht als Aufgabe verankert | Treffer | E: Erkenntnisse Paket 3, Paket 7 ohne Checkbox |
| Degradierte Punkte (Ausgangssumme, Undo-Schritt beim Speichern, Cache-Aufräumer, `daw://library`-Last, zwei Instanzen) | Offen | – |

- **Fehlalarme unter den nachgeprüften Befunden:** keine.
- **Folgewirkung:** Wegen des Review-Befunds wurde das Review von Paket 5 nachgeholt (Vorlage `code-reviewer`, Opus, vollständiger Diff `git show ef3986d`, ≈ 179 303 Token, 158 s). Ergebnis: **ein echter Blocker** – `tests/mcp/test_live_pipe.py:579` liest nach der Umstellung von `import_audio` auf `single` noch `data.steps[0].data.id`; unbemerkt, weil die Live-Tests ohne DAW übersprungen werden. Korrektur als Yoka-DAW-Paket 7b eingeplant (Koordinator-Session „Yoka DAW continuation", Yokas „Ja" vom 2026-11-08).
- **Mehrwert gegenüber Tests und Review:** Alle Treffer lagen auf der Meta-Ebene (Plan, Register, Prozessregeln) oder an Schnittstellen. Keiner davon wäre von den Tests gefunden worden. Der Blocker wäre von einem Review gefunden worden – aber das Review war ausgelassen worden, und genau das hat der Lauf gemeldet.

## Passung (Grundlage für PTc v1.0)

Gut: Meso, Meta, Quellen-Bindung, Risikokontrolle. Schlecht: 3 Eimer, „Kulturelle Akzeptanz", „Politische Machbarkeit", Kritische-Masse-Schwelle, Zuordnung der 14 Kriterien zu Mikro/Makro, binärer Cross-Flow. Fehlend: Schnittstellen-Matrix, Plan-gegen-Ist, Belegklasse Selbstauskunft, Threads, Lebenszyklus, Fehlerarten, harte Budgets, Testbarkeit, Datenformat-Migration, dreistufige Konsistenz, Software-Eimer. Umsetzung in `agent/ptc.md` § 11.

---

## Karte (wörtlich, wie vom Subagenten geliefert)

MiMaMa-KARTE · 2026-11-08

OBJEKT: Detailplan der Unterphase 4J „Workflow" der Yoka-DAW (`F:\Yoka\Workspace\Yoka-DAW\docs\PHASE_4J_PLAN.md`, 342 Zeilen)
Modus: FULL
PRÄMISSE: vorab geklärt (vom Auftraggeber). Zusatz: Der Plan ist **teilweise schon umgesetzt**. Laut Statuszeile ist „Paket 1 bis 5 abgeschlossen", Pakete 6 bis 8 sind offen. Geprüft wird darum ein Hybrid: Plan (D-Tabelle, Aufgaben) plus Umsetzungsprotokoll (Erkenntnisse).

**EBENEN-ÜBERSETZUNG (Software):**

| Ebene | Übersetzung | Beispiele aus dem Plan |
|---|---|---|
| Nano | einzelne Operation oder Invariante (ein Systemaufruf, eine reine Funktion, ein Thread-Übergang) | `MoveFileExW`, `createCopy()`, `BpmGuess.h`, `.part`-Datei |
| Mikro | einzelne Komponente oder ein Bus-Befehl mit eigenem Test | `ProjectWriter`, `AutosaveService`, `SampleIndexer`, `PreviewPlayer`, `browser.*` |
| Meso | Schnittstellen zwischen Teilsystemen | Bus-Revision und Autosave, Plugin-Host und Autosave, Browser über Import und Warp zum Undo, Vorschau-Edit und Ausgang/Meter, Versionen und Cache-Aufräumer, Register und MCP-Katalog |
| Makro | laufende DAW als Ganzes plus Nutzerziel | „Kein Datenverlust und Samples schnell finden", Echtzeit-Grenzen D323, Feature-Matrix 196/198 |
| Meta | Regel- und Prozessebene, Selbstbeschreibung | D-Tabelle, PROCESS.md (Testregel, Review, Zeiten), D291 (eine Session), Spiegelung in `PHASE_4_PLAN.md`, Tool-Budget D309 |

**HERKUNFT (Quellen-Bindung):**

**Quelle liegt vor:** ja, selbst gelesen:
- `PHASE_4J_PLAN.md`, vollständig
- `CLAUDE.md`, vollständig
- `docs/PROCESS.md`, vollständig
- `PHASE_4_PLAN.md`: Zeilen 1–4, 248–297 und Grep-Treffer 56, 58, 81, 84

**Nicht gelesen:**
- Quellcode
- git log
- frühere Phasenpläne
- die MMM-Spec (optional, nicht geladen; es wird nichts über sie behauptet)

**Wichtige Einschränkung:** Alle Aussagen zum Umsetzungsstand sind **Selbstauskunft des Plans** („Erkenntnisse"). Gegen den Code habe ich sie nicht geprüft.

**Verankert (wörtlich):**
- D311: „`File::replaceFileIn` (Windows `ReplaceFile`, atomar auf NTFS …)". Dagegen Erkenntnis Paket 2: „`ReplaceFile` (JUCE `replaceFileIn`) ist **nicht** atomar gegen Prozessabbruch … nutzt nun auf Windows `MoveFileExW (…)`".
- `PHASE_4_PLAN.md:279`: „erledigt 2026-11-07: eigener atomarer Schreibweg (`replaceFileIn`)".
- D313: „im Stillstand `flushState` (Plugin-Zustände)" und „kein Undo, keine Revision". Dagegen Erkenntnis Paket 2: „Annahme 2 rot … schreibt `getStateInformation` je Plugin nur in die **Kopie**" und „`publishSystemEvent` erhöht die Revision (D313 wollte keine)". Außerdem `sessions\<PID>.json` → „`<PID>-<Token>.json`".
- D316: „Schlüssel = Pfad relativ zum Ort". Dagegen Erkenntnis Paket 3: „Schlüssel ist `<Ortsname>/<rel klein>`: ein umbenannter Ort … verwaist seine Tags".
- D319: „`TrackCommands.cpp:73`". Dagegen Erkenntnis Paket 4: „dort liegt nur `track.bounce`".
- Fakt 11 und D321 („`import_audio` ist `group`", „bekommt die Schritte"). Dagegen Erkenntnis Paket 5: „Das Tool ist jetzt **`single`** statt `group`. Die Katalogprüfung erlaubt in Gruppen nur undo-fähige gelbe Befehle (D78)".
- D323: „erster Index ≤ 3 min". Dagegen Erkenntnis Paket 3: „kalt (Plattencache leer) 261 s → … **überschritten**" und „Entscheidung … im Messlauf Paket 7". Paket 7, Schritt 1 nennt nur „Index kalt/warm … Werte unter ‚Messwerte'", keine Grenzentscheidung.
- Review Paket 2: „‚pending' zählt nur die Bus-Revision, Änderungen am Bus vorbei (Plugin-Fenster) lösen kein Autosave aus (entspricht D313)".
- Zeiten-Tabelle: Ist je Paket „nicht gemessen", Start und Ende nur als Datum. PROCESS.md:74 verlangt: „trägt die Session je Paket Start- und Endzeit … ein".
- Plan Paket 5: „Katalog → Review nur bei Zonenänderung". Erkenntnis: „Kein Review: keine Zonen- und keine C++-Änderung". Dagegen PROCESS.md:43 (`registry/mcp_tools.json` unter „MCP-Zonen und Katalog"), PROCESS.md:50 („Kernpfade (Review Pflicht): … `registry/*`") und PROCESS.md:46 („Bei Unsicherheit gilt die Änderung als Kernänderung"). Paket 5, Schritt 1 ändert `registry/mcp_tools.json`.
- Messwerte-Tabelle: Abbruchtest, Index und Suche sind leer, obwohl die Erkenntnisse Werte nennen („6 von 6 Läufen", „warm 31 s, kalt 261 s", „Median 3,4 ms"). Die Vorschau-Zeilen sind dagegen gefüllt.
- Paket 8, Schritt 2: „Messwerte aus Aufgabe 8 übernehmen". Paket 8, Schritt 4: „D310–D323 spiegeln". Ein Abgleichschritt D-Tabelle gegen Erkenntnisse fehlt.
- CLAUDE.md:52: „Was in Plänen oder Entscheidungen steht, nicht erneut fragen."
- Katalog „29 von 30, ein Platz bleibt für 4K" (D321). `import_audio` trägt `locations` und `rescan` (D321).

**[UNVERIFIZIERT]:**
- Übereinstimmung des Codes mit den Erkenntnissen.
- Ob Paket 5 auch `catalog.py` geändert hat (`validate_catalog prüft attach` legt es nahe).
- Ob frühere Unterphasen ihre D-Tabellen vor dem Spiegeln abgeglichen haben.
- Ob eine Ausnahme „Katalog: Review nur bei Zonenänderung" in einem anderen Dokument existiert.

**Degradierte Befunde (nur Ableitung, nicht als Bruch gewertet):**
- Übersteuerungsrisiko am Ausgang durch Vorschau plus Projekt ohne Meter
- wirkungsloser Undo-Schritt beim expliziten Speichern
- Cache-Aufräumer gegen Freeze-Dateien alter Versionen
- `daw://library`-Neulesen 2×/s im Zusammenspiel mit Befund B1
- zwei gleichzeitige Instanzen auf `versions.json`

**EBENEN-ANALYSE:**

**Nano: stark.** Die atomare Ersetzung ist mit einem Abbruchtest (30 Abbrüche je Lauf) an echter Prozessbeendigung geprüft. Der Test hat die Lücke in `ReplaceFile` selbst gefunden. Rot-Nachweise sind ehrlich dokumentiert, auch der zunächst nicht erbrachte. Die BPM-Muster sind reine Funktionen mit Negativfällen (`808`, `2024`, `Vol120`).

**Mikro: stark.** Jede Komponente hat einen klaren Vertrag, eine Testliste und eine „Fertig, wenn"-Bedingung. Für ungeprüfte Annahmen sind Rückfälle festgelegt. Annahme 2 griff tatsächlich: rot, danach Rückfall umgesetzt.

**Meso: überwiegend tragfähig, zwei Lecks.** Viele Schnittstellen wurden aktiv abgefangen (Index-Ereignisse → `publishNeutralEvent`; Vorschau nicht im Projekt-Meter → Annahme 6; Cache-Aufräumer gegen `.versions` → Test; Import plus Warp → eine Transaktion; Katalogregel D78 → `single`). **Leck 1, Plugin-Host → Autosave:** Änderungen im Plugin-Fenster gehen am Bus vorbei und lösen kein Autosave aus. **Leck 2, Katalog → Review-Regel:** Paket 5 lief ohne Review, obwohl PROCESS.md `registry/*` als Review-Pflicht führt.

**Makro: Ziel abgedeckt, ein Grenzwert offen.** Feature-Matrix 196 und 198 vollständig adressiert. Echtzeit-Grenzen beziffert; Vorschau-Werte (8 ms, −0,45 ms) weit innerhalb. Der kalte Index verletzt die Grenze (261 s gegen 180 s); Entscheidung verschoben, aber nicht als Aufgabe verankert. Gerätemessungen am L-12 stehen aus (Paket 7/8).

**Meta: deutlichste Bruchstellen.** (a) Selbstbeschreibung driftet: 6 von 14 D-Einträgen weichen von der Umsetzung ab, die falsche Atomaritäts-Aussage ist schon in `PHASE_4_PLAN.md:279` gewandert, Paket 8 spiegelt ohne Abgleichschritt. (b) Toter Lernkreis: Zeiten „nicht gemessen". (c) Regelkonflikt: plan-lokale Review-Ausnahme gegen PROCESS.md:50 und :46.

**OPERATOREN:**

*Abwärts, jetzt vor Paket 6:* (1) D311, D313, D316, D319, D321, D323 mit „geändert, siehe Erkenntnis Paket X" markieren. (2) `PHASE_4_PLAN.md:279` korrigieren. (3) Paket 7: Checkbox „Grenze kalter Index entscheiden". (4) Paket 8, Schritt 4: „D-Tabelle gegen Erkenntnisse abgleichen" vor dem Spiegeln. (5) Review Paket 5 nachholen oder D-Entscheidung „Katalog-Ausnahme". Yoka muss jetzt nichts tun.
*Mittelfristig:* Messwerte aus Paket 2 und 3 übernehmen; Plugin-Fenster-Lücke unter Offene Punkte (Vorschlag: Zustands-Prüfsumme im Stillstand); Zeiten mit Uhrzeit.
*Langfristig:* Strategie für den MCP-Katalog vor dem letzten Platz; D-Tabelle als lebendes Register.

*Aufwärts (Hypothesen):* Wiederholt sich „D-Tabelle eingefroren, Abweichungen nur im Erkenntnis-Log, Spiegeln bei Abnahme" in jeder Unterphase, wächst die Zahl veralteter Einträge im zentralen Register, auf das sich Folgesessions ohne Rückfrage verlassen (CLAUDE.md:52). Kalter Index plattengebunden, grob linear: 50 000 Dateien ≈ 10 min. Katalog 29/30: Funktionen wandern in vorhandene Tools. Verwaiste Autosaves und `.part`-Dateien sammeln sich an. Kritische-Masse-Heuristik: nicht anwendbar.

**CROSS-FLOW (C_int): PASS (knapp, bedingt).** Technische Kette kohärent; Meso-Lecks sind Teil-Lecks. Grenzfall Meta: D-Tabelle widerspricht dem Stand – gewertet als Synchronisations-Leck, weil der Plan Abweichungen unter „Erkenntnisse" vorsieht. Bei strenger Wertung kippt Bedingung (1) auf FAIL, spätestens wenn Paket 8 D311 ungeprüft spiegelt.

**EIMER: PROVOLUTIONÄR RELEVANT** (umgedeutet: „systemtragend über alle Software-Ebenen"); gesellschaftlich wäre es PRIVAT.

**14 KRITERIEN:** Ø = 2,43 · Mikro = 2,67 · Makro = 2,20 · Brücke = 2,33 (Einzelwerte: K1 3, K2 3, K3 2, K4 3, K5 3, K6 2, K7 2, K8 2, K9 3, K10 2, K11 2, K12 2, K13 2, K14 3).

**VORENTSCHEIDUNG: PASS.** Sinnvoller Folgeschritt: die Jetzt-Korrekturen 1–5 vor Paket 6.

**PERSPEKTIVEN:** (1) Schwachpunkt ist nicht die Technik, sondern die Rückführung von Erkenntnissen in die Selbstbeschreibung. (2) Größte verbliebene Verlustquelle liegt außerhalb des Busses: Plugin-Fenster. (3) Das Tool-Budget wirkt lokal ordnend, global bedeutungsverdichtend. (4) Die Lernschleife Schätzung → Ist wird nicht gefüttert.

**SELBST-FALSIFIKATION:** Degradiert: Ausgangssumme, Undo-Schritt beim Speichern, Cache-Aufräumer, `daw://library`-Last, zwei Instanzen. Existenz-Hedge: Gibt es eine Entscheidung, die „Katalog: Review nur bei Zonenänderung" legitimiert? In den gelesenen Quellen nicht. Verbleibende Befunde ruhen auf beidseitig zitierten Stellen derselben Quellen. Memory-Angaben („4H–4K offen") bewusst nicht verwendet.

**PASSUNG (Meta-Feedback):** Nano umgedeutet · Mikro passt · Meso passt sehr gut · Makro umgedeutet, dünn bei Einzelnutzer · Meta umgedeutet, ergiebig · Abwärts umgedeutet, Temporal-Split passt · Aufwärts stark umgedeutet, Schelling-Schwelle passt nicht · 3 Eimer passen schlecht · Cross-Flow binär hakt · K1/K4/K7/K11/K14 passen · K2/K3/K5/K6/K12 umgedeutet · K8/K9 stark umgedeutet · K10 Skalenrichtung unklar · Kriterien-Ebenen-Zuordnung passt nicht · Quellen-Bindung passt sehr gut, Klasse „Selbstauskunft" fehlt · PASS-Schwellen zu lasch.

**Was für Software fehlt:** (1) Schnittstellen-Matrix. (2) Plan-gegen-Ist-Drift-Prüfung. (3) Belegklassen Selbstauskunft/Test/extern. (4) Achsen Nebenläufigkeit und Lebenszyklus. (5) Fehlermodus-Raster. (6) Harte Budgets. (7) Testbarkeit, Datenformat-Migration. (8) Mehrstufiger Cross-Flow. (9) Software-Eimer.

*Hinweis zur Wiedergabe:* Ebenen-Analyse, Operatoren, Kriterien-Tabelle und Passungs-Tabelle sind hier in verdichteter Listenform wiedergegeben; Zitate, Befunde, Zahlen und Urteile sind unverändert.
