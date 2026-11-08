Kurzer Stand: Ich habe `PHASE_4J_PLAN.md`, `PROCESS.md` und die 4J-Stellen in `PHASE_4_PLAN.md` gelesen. Hier die Karte.

```
PTc-KARTE · 2026-11-08

OBJEKT : docs/PHASE_4J_PLAN.md (Unterphase 4J „Workflow"), Abgleich mit docs/PROCESS.md, CLAUDE.md, PHASE_4_PLAN.md (Statuszeile Z.4, Z.81, Z.279)
MODUS  : IST
STAND  : Paket 1–6 umgesetzt, Paket 7 und 8 offen
PRÄMISSE: geklärt (Auftrag nennt Objekt, Stand und Ziel)

HERKUNFT
  Gelesen        : PHASE_4J_PLAN.md komplett (1–351); PROCESS.md komplett; CLAUDE.md; PHASE_4_PLAN.md nur per Grep auf „4J" und Z.279
  Nicht gelesen  : Quellcode, git log, PHASE_4_PLAN.md § Offene Punkte außer Z.279, SKILL.md, Logs, docs/phase4j_abnahme.md (existiert laut Plan noch nicht)
  V verankert    : Plan-gegen-Plan- und Plan-gegen-PROCESS-Stellen (Zeilenangaben in den Befunden)
  S Selbstauskunft: alle Messwerte, Testergebnisse und Review-Urteile in „Erkenntnisse" (kein Log, kein Testlauf von mir geprüft; die Messwerte tragen teils Datum und Gerät)
  T Beleg        : keiner selbst geprüft. Projektklassen A/T/D/Y nach PROCESS.md:3-10
  [UNVERIFIZIERT]: jede Aussage über Code („Indexer greift nie auf den Message-Thread zu", „MoveFileExW-Pfad", Registerzahl 96)
  Degradiert     : Siehe Offene Fragen (O1–O3)

EBENEN
  Nano  : Schreibprimitive (`.part` + Ersetzen), Revision in der Autosave-Kopie, `createCopy` auf dem Message-Thread. Der Abbruchtest (Erk. :285-286) deckt das ab; die Ersetz-API im Plantext ist überholt (HART-1).
  Mikro : Komponenten haben Verträge und Testlisten (ProjectWriter, Versions, Autosave, SampleLibrary, PreviewPlayer, BrowserMath). Die Rot-Nachweise sind meist erbracht, bei Paket 1 :275 teilweise nicht.
  Meso  : Bus ↔ Autosave/Versionen/Browser/Preview, Datei-Persistenz, MCP-Katalog, Thread-Grenzen Indexer/Schreiber ↔ Message-Thread. Hauptbefunde stehen hier (LECK-1, LECK-3, LECK-4).
  Makro : Ziel „kein Datenverlust, Samples schnell finden". Die Index-Grenze ist verletzt (HART-2). Die Last-Summe (Wiedergabe + Index + Autosave auf F:) ist nicht abgedeckt (LECK-2).
  Meta  : Prozess (Reviews, Zeiten, Spiegeln in die Gesamtpläne). Mehrere Plan-gegen-Prozess-Abweichungen (LECK-5, LECK-6, SYNC).

SCHNITTSTELLEN-MATRIX
| A | B | Vertrag benannt? | Test über die Grenze? | Weg am Vertrag vorbei? | Befund |
|---|---|---|---|---|---|
| Bus (Revision) | AutosaveService | ja (D313: „Revision") | ja (Gesten-, Intervall-Tests) | Änderungen am Bus vorbei (Plugin-Fenster) lösen kein Autosave aus (:290); `flushState` setzt „geändert" nur bei abweichendem Plugin-Zustand (:282) | LECK-1 |
| AutosaveService | Message-Thread | ja (Kopie dort, XML im Schreib-Thread) | ja (Annahme 3, 4×250 Änderungen) | Schreib-Thread ↔ `project.save`/`open`/Beenden, die Autosave und Sitzungseintrag löschen: kein Test „Rest nach project.save" (:290) | LECK-3 |
| ProjectWriter | Dateisystem/Leser | ja (D311) | ja (Lock-Test, Abbruchtest 30/30) | nein; Plantext nennt aber die falsche API | HART-1 |
| restore_version/recover | laufender Betrieb (Wiedergabe, Aufnahme, Render, Freeze, Autosave-Schreiben) | nur „gespeichert oder discard_changes" (D312 :25, D314 :27) | nein | Zustandskreuz offen | LECK-4 |
| SampleIndexer | Platte F: ↔ Wiedergabe-Streaming ↔ Autosave | nur `ui_refresh` ±1 ms (D323) | Aussetzer-Grenze nur für Autosave und Vorschau, nicht für den Index | Index startet beim App-Start; `TempoDetect` ohne Zeitgrenze | LECK-2 |
| Vorschau-Edit | DeviceManager/Master-Meter | ja (D318) | ja (Summe ±8 %, Meter < −60 dB) | simuliertes Gerät, L-12 offen | ok, Messung in Paket 7 |
| clip.import_audio mit warp | Undo | ja (D319: „ein Undo-Schritt") | ja, aber nach 600 ms Wartezeit (:313) | Tracktion trägt asynchron einen Undo-Schritt nach | LECK-7 |
| Plan ↔ PHASE_4_PLAN.md | andere Sessions | Spiegel Z.279 | – | Z.279 nennt `replaceFileIn` als erledigt | HART-1 |
| Plan ↔ PROCESS.md | Review-Pflicht | PROCESS :43, :50, :75 | – | Paket 5 ohne Review; Blocker ohne zweiten Durchgang | LECK-5 |

QUERACHSEN
  Nebenläufigkeit : Audio-Thread laut Review unberührt (:314, S). Zeitkritisch sind Indexer/`TempoDetect` (CPU) mit Autosave- und Vorschau-Edit gleichzeitig; bei 64 Samples ist das nur einzeln gemessen (LECK-2). Der Zustand „Beenden während Autosave-Schreiben" ist ungetestet (LECK-3).
  Lebenszyklus    : Absturz/Neustart sind stark abgedeckt (30/30, Sitzungseinträge je PID+Token). Offen sind `.part`-Reste (Abbruchtest: 13 von 30 mit `.part`, :285), Reste „Später"/„Ohne Titel", Waisen von `<Projekt>.versions` bei gelöschtem oder verschobenem Projekt, und Migration von `versions.json`/`autosave.json`/`browser.json`. Es gibt nur `"version": 1`, keine Migrationsregel (Notiz, keine Stütze im Plan).
  Ressourcen      :
    - Autosave Message-Thread: Budget ja (≤ 20/50 ms) · Messbeleg offen (Paket 7) · Wachstum: Löschen nach Speichern, aber keine Aufräumregel für Reste · Konkurrenz: Ziel `F:\Yoka\DAW-Daten` liegt auf demselben Laufwerk wie Samples und Projekte → LECK-2.
    - Versionen (Platte): Budget nur als Anzahl (10, Bereich 1–100), kein Platzbudget; Projektgröße nirgends gemessen. Es stützt sich nichts ausdrücklich darauf → nur Notiz. Benannte Versionen wachsen unbegrenzt (Hypothese).
    - Index: Budget ≤ 3 min kalt, gemessen 261 s (:296) → HART-2. Index 4,2 MB, Cache-Aufräumen bei gelöschten Dateien ist nicht beschrieben (Notiz).
    - Suche und Vorschau: gemessen (3,4/4,0 ms; 8/10 ms RelWithDebInfo, simuliertes Gerät); Messwerte-Tabelle leer (SYNC-5).
  Fehlerarten     : Abbruch mittendrin abgedeckt. Teilfehler: Laden nach Kopie in `restore_version` fehlgeschlagen (offen, :276, :333). Leere/große Eingabe in Tags/BPM durch Grenzen abgedeckt. PID-Wiederverwendung ist gelöst (`<PID>-<Token>`), aber ohne Test (:290). Kaputte Dateien: `.invalid`/Neuaufbau getestet. Fehlende Abhängigkeit L-12: sauber in Paket 7/8 verschoben.

KONSISTENZ
  HART :
   HART-1  D311/Technik/Annahme 1 gegen Erkenntnis Paket 2 (V gegen V), schon gespiegelt.
     Plan :11 „File::replaceFileIn", :24 „(Windows `ReplaceFile`, atomar auf NTFS …)", :58 „`replaceFileIn` ersetzt … atomar", :106 „`.part` + `replaceFileIn`", :163-Ketten „atomar (D311)" in D312.
     Erkenntnis :286: „`ReplaceFile` (JUCE `replaceFileIn`) ist **nicht** atomar gegen Prozessabbruch … nutzt nun … `MoveFileExW`". Der Text „D311 korrigiert" steht nur in den Erkenntnissen, D311 selbst blieb unverändert.
     Gespiegelt: PHASE_4_PLAN.md Z.279 „eigener atomarer Schreibweg (`replaceFileIn`)"; Paket 8 Schritt 4 will „Speichern atomar" in den Skill schreiben, ohne dass die Korrektur dort sichtbar ist. Das ist die Eskalation SYNC → HART.
     Reichweite: ARCHITEKTURPRÄGEND (Datei-I/O-Vertrag, Skill).
   HART-2  D323 „erster Index ≤ 3 min ohne TempoDetect" gegen Messung „kalt 261 s" (:296, S mit Messwert). Die im Plan gesetzte Grenze ist überschritten. Der Test ist auf 300 s gelockert, die Entscheidung auf Paket 7 verschoben. Aufgabe 8 hat dafür keinen Haken (:191 nennt nur „Index kalt/warm" messen), obwohl Review-Blocker 2 genau das („Haken im Plan") verlangte und „Behoben" meldet (:302).
     Reichweite: QUERSCHNITTLICH (Muss-Zeile 198, Abnahmegrenze).
  LECK :
   LECK-1  Zustandspfad Plugin-Fenster/Plugin-Zustand → Autosave (§3.5). Pfad ohne Weg zum Persistenzauslöser: Änderungen am Bus vorbei lösen kein Autosave aus (:290 „entspricht D313"); `flushState` ist im Stillstand gar nicht in der Revision. Während der Wiedergabe trägt der Eintrag `plugins_flushed: false`. Das widerspricht dem Muss-Ziel „Kein Datenverlust" (:7). Es steht nur als „Mittel (2)" in den Erkenntnissen, nicht als offener Punkt oder Aufgabe mit Haken. Reichweite: QUERSCHNITTLICH.
   LECK-2  Summe unter Last (§2.3 Pkt. 4, Befundpflicht). D323 stützt Akzeptanz (Szenario 7, 1, 2) auf Aussetzer-Grenzen. Sie sind getrennt für Autosave (+1) und Vorschau (+0), der Index läuft aber ab App-Start parallel, ist auf F: platten-gebunden (261 s kalt, 31 s warm, :296) und `TempoDetect` dekodiert bis zu 20 549 Dateien ≤ 60 s ohne Zeitgrenze (:29). Die Index-Grenze betrifft nur `ui_refresh`. Autosave-Ziel, Projekt-Audio und Samples teilen F:. Reichweite: QUERSCHNITTLICH.
   LECK-3  Aufräum-Regel und Rennen Autosave ↔ Speichern/Beenden. Reste: `.part` im Autosave-Ordner, Autosave ohne Sitzungseintrag nach Tod zwischen `writeState` und `writeText` (:290 „wird nie aufgeräumt"), neben dem Projekt `<Datei>.part` nach Abbruch (13 von 30, :285), Reste bei „Später" und „Ohne Titel", `.versions` bei gelöschtem Projekt. Kein Test „Rest nach project.save" (:290). PASS-Kriterium 4 verlangt Aufräum-Regel oder offenen Punkt; beides fehlt im Plan. Reichweite: QUERSCHNITTLICH.
   LECK-4  Zustandskreuz (§2.2): `project.restore_version` und `project.recover` ersetzen das Projekt. Geprüft ist nur „gespeichert oder discard_changes"; Wiedergabe, Aufnahme, Render, Freeze und laufendes Autosave-Schreiben sind in D312/D314 nicht behandelt. Das Autosave nennt für Render/Freeze/Aufnahme Sperren (D313), Aufnahme/Render in `blockReason` sind ungetestet (:290). Testaufgabe: je Zustand ein Fall für `restore_version` und `recover`. Reichweite: QUERSCHNITTLICH.
   LECK-5  Review-Prozess (Plan ↔ PROCESS.md, V gegen V).
     (a) Paket 5 ohne Review (:325 „keine Zonen- und keine C++-Änderung"), obwohl `registry/mcp_tools.json`, `catalog.py`/`validate_catalog`, `runtime.py` (Resources `attach`) laut PROCESS.md:43 und :50 („`registry/*`") Kernänderung sind. Die Plan-Ausnahme „Review nur bei Zonenänderung" (:158) widerspricht PROCESS.md.
     (b) Blocker in Paket 1 (:276), 3 (:301), 6 (:332) wurden vom Implementierer behoben, ohne dokumentierten zweiten Durchgang (PROCESS.md:56 „Einen Blocker hebt nur der zweite Review-Durchgang auf", :75 verlangt ihn; Plan „Fertig, wenn … Review ohne Blocker").
     Reichweite: QUERSCHNITTLICH.
   LECK-6  Phasen-Kriterium D323 „Phasenabweichung ≤ 5 ms" (:36) gegen Szenario 2 „spielt im Takt mit" und Erkenntnis :308 „Signalsmith verschmiert Transienten um bis ≈ ±30 ms … der Start bleibt davon unberührt". Gemessen ist nur der Start (−0,45 ms); Wortlaut von D323 und der Messwerte-Zeile lässt offen, ob Start oder hörbare Transienten gemeint sind. Bei Transienten wäre ≤ 5 ms mit Signalsmith rechnerisch nicht einhaltbar (HART). Reichweite: LOKAL, Definition festlegen.
   LECK-7  Erfüllbarkeit „ein Undo-Schritt" (D319 :32, Szenario 3 :213) gegen Erkenntnis :313: „Nach einem Import trägt Tracktion asynchron noch Werte nach (… ein Undo-Schritt)". Die Tests warten 600 ms und nehmen dann die Basis. Die Abnahme prüft `query.history` unmittelbar nach der Geste. Das ist ein möglicher zweiter Schritt nach dem Import (der Mechanismus liefert ggf. N+1). Reichweite: LOKAL/QUERSCHNITTLICH.
   LECK-8  Paket 7 Schritt 1: „Autosave alle 10 s über Testeinstellung" (:191, D323), aber D315 setzt `interval_min` 1–60. Eine 10-s-Einstellung und ein Messfeld für den Message-Thread-Anteil („`performance.jsonl` bzw. einem Messfeld") sind weder im Befehls-Register noch in der Dateistruktur beschrieben (V; Code nicht gelesen). Ohne sie kann die Messung nicht laufen.
   LECK-9  Offene Punkte nur in Erkenntnissen („Offen (gering, bewusst)": :277, :291, :302, :315, :333), kein Eintrag in § Offene Punkte oder Haken. Betrifft u. a. `restore_version`-Ladefehler, Preview-3600-s-Grenze, `project.recover`-Stopp-Test, D169-Vorprüfung `save_version`. Zusammen mit LECK-1 wird PASS-Kriterium 4 und der Plan-Pflegerhythmus (CLAUDE.md, „offene Punkte") berührt.
   LECK-10 Sporadische Testfehler: Rack-Render `played=-29` zu `mixdown=-28,99` (:278, :288) und `FreezeTests.cpp:232` (1 von 3 isoliert rot, :288), Windows-Dialog `0xc0000142` (:278): „nicht gegen Baseline verglichen". Aufgabe 9 Schritt 3 verlangt grüne Läufe, ohne dass jemand die Ursache klärt. Der Vergleichs-Build `phase-4i` (Paket 7 Schritt 2) böte die Baseline.
  SYNC :
   SYNC-1  PROCESS.md-Tabelle (:32-45, „Stand 2026-10-28") enthält `src/core/yoka/project/**`, `browser/**`, `BrowserCommands.cpp` und `PreviewPlayer` nicht; nur Zeile :50 nennt `project/**` und `browser/**`. PROCESS.md:46 verlangt die Anpassung im selben Commit; Plan :54 und Paket 1 Schritt 1 haben sie zugesagt.
   SYNC-2  Plan-Text gegen Umsetzung (alle in Erkenntnissen dokumentiert, Entscheidungen nicht nachgezogen): D313 „keine Revision" vs. `publishSystemEvent` erhöht sie (:289); D313 `sessions\<PID>.json` vs. `<PID>-<Token>.json` (:289); D316 Schlüssel „Pfad relativ zum Ort" vs. `<Ortsname>/<rel klein>` (:300); D321 `import_audio` „group" vs. `single` (:321); D319/Fakt „`TrackCommands.cpp:73`, `track.add` (mit Datei)" vs. dort liegt nur `track.bounce`, `track.add` erhält neue Parameter (:311); D315 nennt `project.version_restored`/`project.recovered` als Ereignisse, die UI-Erkenntnis sagt „fehlen absichtlich" (:330); D320 `daw://library` gegen Erkenntnis :322.
   SYNC-3  Statuszeile Plan :3 „Paket 1 bis 6 abgeschlossen (2026-11-07 …)" vs. Paket 6 am 2026-11-08 (:327, :347). PHASE_4_PLAN.md Z.81 steht noch auf „Detailplan fertig", die Statuszeile Z.4 ist aktuell.
   SYNC-4  Zeiten-Tabelle (:342-347): Spalte „Ist" überall „nicht gemessen", Start/Ende nur als Datum. PROCESS.md:74 verlangt Start- und Endzeit „aus `git log`".
   SYNC-5  Messwerte-Tabelle (:234-238) hat leere Zeilen, obwohl Werte vorliegen: Abbruchtest (30/30 in Debug und RelWithDebInfo, :285), Index warm 31 s, kalt 261 s, Wiederholung 3,5 s, Suche 3,4/4,0 ms (:296).
   SYNC-6  Rot-Nachweis Paket 1 (:108) „altes `moveFileTo` → Lock-Test rot" nicht erbracht (:275), Test gilt nach PROCESS.md:83 erst als valide, wenn rot. Teilweise durch Abbruchtest in Paket 2 ersetzt (:286), aber im Plan nicht zurückgenommen oder umformuliert.
   SYNC-7  Belegzuordnung Abnahme (:211-218): „A usage.jsonl" (Szenario 1), „A `query.browser`/Messung Phase" (2). PROCESS.md:7 und :22 definieren A als `mcp_audit.jsonl` bzw. `performance.jsonl`. GUI-Gesten (Szenarien 1, 3, 4, 5) erscheinen nicht im MCP-Audit; die Zuordnung zu A/T fehlt (Regel 0.5-7, „Y nie allein").

OFFENE FRAGEN
  O1 Existiert ein dokumentierter zweiter Review-Durchgang für Paket 1/3/6? Quelle fehlt: `git log`, Commit-Nachrichten. Bis dahin steht LECK-5 (b) auf V (Plan fordert Wörtlichkeit, Erkenntnisse enthalten ihn nicht).
  O2 Enthält PHASE_4_PLAN.md § Offene Punkte schon Einträge für die „Offen (bewusst)"-Punkte? Quelle fehlt: nur Z.279 gelesen. Betrifft LECK-9; die Aussage bleibt abgeschwächt.
  O3 Existiert ein Messfeld/eine Option für 10-s-Autosave? Quelle fehlt: Quellcode. LECK-8 ruht auf Plan-Text, der es nicht beschreibt.

OPERATOREN
  Abwärts :
   Jetzt (vor Paket 7): D311/Technik/Annahme 1/Aufgabe 2 auf `MoveFileExW … REPLACE_EXISTING|WRITE_THROUGH` ändern, PHASE_4_PLAN.md:279 gleich. Aufgabe 8 Schritt 1 um die Messaufgaben unten und um den Haken „Index-Grenze entscheiden" ergänzen. Zweiten Review-Durchgang für Paket 1/3/6 und ein Review für Paket 5 nachholen (frischer Kontext, vollständiger Diff).
   Bis Abnahme: Messwerte-Tabelle füllen, Zeiten mit Uhrzeiten nachtragen, PROCESS.md-Tabelle (SYNC-1) ergänzen, Belegzuordnung der Szenarien eintragen, offene Punkte in § Offene Punkte oder als Haken in Paket 8 Schritt 3 verankern.
   Ab nächster Unterphase: Kernpfad-Tabelle bei neuen Ordnern im selben Commit anpassen; Plan-Entscheidungen bei Abweichung im selben Commit korrigieren statt nur in „Erkenntnisse" (Anti-Drift).
  Aufwärts (Hypothesen):
   Muster-Wiederholung: Wird „Erkenntnis statt Entscheidung korrigieren" in 4K wiederholt, wandern weitere überholte Aussagen in Gesamtpläne und Skill (siehe HART-1).
   Datenwachstum nach einem Jahr: Benannte Versionen und `.part`-/Autosave-Reste wachsen ohne Aufräumregel (Hypothese); bei XML-Projekten mit eingebetteten Plugin-Zuständen kann jede Version viele MB groß sein (nicht gemessen). Index wächst mit dem Sample-Bestand, Waisen-Einträge gelöschter Dateien sind nicht beschrieben.

VORENTSCHEIDUNG: FAIL
  Grund: HART-1 (überholte API-Aussage, gespiegelt) und HART-2 (Index-Grenze überschritten). Kriterium (3) ist durch LECK-2 und LECK-8 nicht voll erfüllt, Kriterium (4) durch LECK-3.

KORREKTURLISTE (priorisiert)
  1. PHASE_4J_PLAN.md:11, :24, :58, :106 und PHASE_4_PLAN.md:279 — `replaceFileIn` durch den tatsächlichen Weg (`MoveFileExW` mit `MOVEFILE_REPLACE_EXISTING | MOVEFILE_WRITE_THROUGH`) ersetzen; D311 „korrigiert" mit Verweis auf Erkenntnis :286, Annahme 1 und den Rot-Nachweis neu formulieren — ARCHITEKTURPRÄGEND
  2. PHASE_4J_PLAN.md:36 und :191 — Entscheidung zur kalten Index-Grenze treffen (Grenze auf z. B. „kalt ≤ 5 min" oder zweiter Lese-Thread, mit Laufwerkstyp von F:) und als Haken in Aufgabe 8 Schritt 1 eintragen; Messwerte :237 mit 261 s/31 s/3,5 s füllen — QUERSCHNITTLICH
  3. PHASE_4J_PLAN.md Aufgabe 8 — Last-Messung ergänzen (siehe Messaufgaben), Konkurrenz F: benennen — QUERSCHNITTLICH
  4. PHASE_4J_PLAN.md D313/D314 oder § Offene Punkte — Aufräumregel für `.part` (Projekt- und Autosave-Ordner), Autosave-Reste, `.versions`-Waisen; Test „Rest nach project.save"; Test „Beenden während Autosave-Schreiben" — QUERSCHNITTLICH
  5. PHASE_4J_PLAN.md D313 — Plugin-Fenster-Pfad: entweder Aufgabe mit Haken (Änderungserkennung für Plugin-Zustand, z. B. Flush-Vergleich im Timer) oder offener Punkt in PHASE_4_PLAN.md § Offene Punkte mit Verweis auf „Kein Datenverlust" — QUERSCHNITTLICH
  6. PHASE_4J_PLAN.md D312/D314 + Tests — Zustandskreuz für `restore_version`/`recover` (Wiedergabe, Aufnahme, Render, Freeze, laufendes Autosave) mit je einem Test; Aufnahme/Render in `blockReason` testen (:290) — QUERSCHNITTLICH
  7. PHASE_4J_PLAN.md (Erkenntnisse Paket 1/3/6/5) — zweiter Review-Durchgang für Paket 1, 3, 6 nachholen, Urteil wörtlich eintragen; Review für Paket 5 nachholen oder die Ausnahme :158 streichen — QUERSCHNITTLICH
  8. PHASE_4J_PLAN.md D323 und Messwerte-Zeile :240 — „Phasenabweichung" definieren (Start-Position vs. Transient) und die Messung entsprechend legen; Szenario 2 Beleg anpassen — LOKAL
  9. PHASE_4J_PLAN.md Szenario 3 (:213) / D319 — `query.history` erst nach Wartezeit und zusätzlich direkt nach der Geste prüfen; klären, ob der asynchrone Schritt (:313) dem Import zugerechnet wird — LOKAL
 10. PHASE_4J_PLAN.md :191 — Autosave-Testintervall 10 s (Mechanismus) und Messfeld für den Message-Thread-Anteil festlegen (Befehl, Option oder Umgebungsvariable), im Register beschreiben — LOKAL
 11. PROCESS.md:32-45 — `project/**`, `browser/**` (inkl. `PreviewPlayer` bei Audio-/Realtime), `BrowserCommands.cpp` eintragen — LOKAL
 12. PHASE_4J_PLAN.md D313, D316, D319, D321, D315 — Entscheidungstexte an die Erkenntnisse anpassen (SYNC-2), Statuszeile :3 und PHASE_4_PLAN.md Z.81 pflegen, Zeiten-Tabelle (Uhrzeiten, Ist) füllen — SYNC
 13. PHASE_4J_PLAN.md Szenarien :211-218 — Beleg je Szenario auf A/T nach PROCESS.md:3-22 abbilden (z. B. `performance.jsonl`, Testausgabe), `usage.jsonl` zuordnen oder streichen — SYNC
 14. PHASE_4J_PLAN.md Paket 7 Schritt 2 — Freeze- und Rack-Render-Suite 10× auf `phase-4i` und Arbeitsstand wiederholen, um Flaky-Tests zuzuordnen (LECK-10) — LOKAL

VORGESCHLAGENE MESSAUFGABEN
  M1  Index kalt reproduzierbar: Plattencache vor jedem Lauf leeren (Standby-Liste, z. B. RAMMap/Neustart), 3 Läufe kalt, 3 warm, Laufwerkstyp von F: festhalten; Grenze nach Entscheidung (Korrektur 2).
  M2  Last-Summe: 5 min Wiedergabe am L-12 bei 64 Samples, gleichzeitig kalter Voll-Index inklusive `TempoDetect`-Durchlauf, Autosave alle 10 s und eine Vorschau pro 6 s (20 in 2 min). Aussetzer ≤ Lauf ohne diese Last +1; zusätzlich Dauer des Autosave-Schreibens unter Last.
  M3  Platz: Projektdateigröße „Lasttest 2F" und „Abnahme 4J" messen; Platzbedarf von 10 automatischen Versionen + Autosave ausrechnen. Es stützt sich im Plan nichts darauf, daher nur Information.
  M4  Autosave-Schreiben gegen `project.save`/`open`/Beenden: 100 Wiederholungen mit zufälligem Abstand; danach Autosave-Ordner leer (außer bewusst verbleibende).
  M5  Undo-Schritte: `query.history` 0 s, 1 s, 5 s nach `clip.import_audio` mit `warp`; Zahl der Schritte gleich.

SELBST-FALSIFIKATION
  - HART-2 hängt an einer Messung aus den Erkenntnissen (S, mit Datum und Wert, kein Log). Der Plan-Wortlaut „≤ 3 min" (V) und die Selbstauskunft „261 s" (S) stehen gegeneinander; der Test wurde auf 300 s gelockert (:296). Belastbar nach Regel 6, soweit der Messwert stimmt.
  - LECK-1 stützt sich auf Review-Urteile (S) und D313 (V); wenn der Code Plugin-Änderungen doch erkennt, entfällt es (Code nicht gelesen).
  - LECK-7 stützt sich auf einen Hinweis (:313); ob der asynchrone Schritt nach der Abnahme-Geste messbar ist, ist offen (M5).
  - LECK-5(b) kann entfallen, wenn ein zweiter Durchgang in Commits existiert (O1).
  - LECK-9 ruht auf PHASE_4_PLAN.md, von dem ich nur Z.279 gelesen habe (O2).
  - SYNC-1 kann entfallen, wenn die Tabelle in einem Commit nach meiner Lesung nachgezogen wurde (nur Dateistand gelesen).

EINSCHRÄNKUNGEN
  Kein Quellcode, kein git log, keine Logs gelesen; alle Messwerte und Review-Urteile sind Selbstauskunft des Plans. Hypothesen sind als solche markiert (Datenwachstum, Muster-Wiederholung). Die Existenz einzelner Tests (z. B. „Rest nach project.save") habe ich aus den Review-Befunden im Plan abgeleitet, nicht im Code geprüft.
```