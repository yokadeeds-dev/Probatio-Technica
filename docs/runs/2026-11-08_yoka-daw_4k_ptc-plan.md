# Lauf 2026-11-08 · Yoka-DAW 4K · PTc:PLAN (erster Vorhersagetest, 1B)

| Feld | Wert |
|---|---|
| Datum | 2026-11-08, 23:47–23:54 |
| Projekt | Yoka-DAW (`F:\Yoka\Workspace\Yoka-DAW`, Branch `phase-4k-abschluss`) |
| Objekt | `docs/PHASE_4K_PLAN.md`, unkommittierter Detailplan auf Basis `b393378`; nach Einarbeitung committet als `58f8edd` (23:57) |
| Werkzeug | **PTc v1.1.0** (deployt 2026-11-08 19:36, `phase-1d-a`) |
| Modus | `PTc:PLAN` |
| Modell | Opus 5.5, Effort medium (Subagent `ptc`) |
| Token | **168 504** (Agent-Abrechnung); Selbstschätzung des Agenten 95–110 k |
| Dauer | 425 s (≈ 7,1 min) |
| Werkzeug-Aufrufe | 50 |
| Art | **Vorhersagetest, unkontaminiert** (D14): PTc kannte den 4K-Plan nicht; v1.0 stammt aus 4J, v1.1 aus den 1C-Fixtures (4J, 4I) |
| Quelle | Yoka-DAW `58f8edd:docs/PHASE_4K_PLAN.md` § Erkenntnisse „PTc:PLAN" (Karte wörtlich unten); Token und Dauer aus § Zeiten |

## Ergebnis des Laufs

- **Vorentscheidung: FAIL** (1 HART, PASS-Bedingung 4 verletzt), mit der Einschätzung „mit Korrekturen tragfähig, nach K1–K5 PASS".
- **17 Korrekturen**, alle von der 4K-Plan-Session nach D114 übernommen; kein erneuter PTc-Lauf.

| K | Kurzinhalt | Stufe / Reichweite | Ebene / Achse |
|---|---|---|---|
| 1 | `daw_hung` vom heutigen `daw_busy` nicht unterscheidbar, Rot-Nachweis falsch → Herzschlag | **HART**, querschnittlich | Meso (Pipe), Erfüllbarkeit |
| 2 | Crash-Handler verdrängt WER-Dumps | querschnittlich | Lebenszyklus (Absturz) |
| 3 | Crash-Handler braucht Message-Thread und Joins → Deadlock-Gefahr | querschnittlich | Nebenläufigkeit, Lebenszyklus |
| 4 | Ausnahme vom Wächter wirkungslos, Rundown-Fall blind | lokal | Lebenszyklus (Beenden) |
| 5 | Neue Build-Ordner ohne Aufräumregel | lokal | Ressourcen (Platte, PASS-Bed. 4) |
| 6 | Fakt 4 falsch (`resetChangedStatus`) | SYNC | Meta |
| 7 | Aufrufstellen `markChangedAfterLoad` fehlen | lokal | Mikro, Zustandspfade |
| 8 | Rot-Nachweis D332 (d) kann nicht rot werden; Vorab-Ladung verdoppelt Ladezeit | lokal | Testregel, Ressourcen (Thread-Zeit) |
| 9 | B1 nicht am Endstand gemessen | querschnittlich | Makro, Messbeleg |
| 10 | Paket 9 Schritt 0: Zeit und Konkurrenz mit L-12-Läufen | lokal | Ressourcen (Zeit, Gerät) |
| 11 | ASan-Fehlalarme durch Zeitgrenzen | lokal | Fehlerarten, Testregel |
| 12 | Hängende Instanz im Test sperrt Build und L-12 | lokal | Lebenszyklus, Konkurrenz |
| 13 | (i) ohne Rot-Nachweis; bedingtes Review Plugin-Host | lokal | Meta (Prozessregel) |
| 14 | Selbstbeschreibung „PTc eingearbeitet" vor dem Füllen | SYNC | Meta (Plan-gegen-Ist im Plan selbst) |
| 15 | Falscher Eventname | SYNC | Meso (Register/Katalog) |
| 16 | Regel- und Zielspiegelung (GELB-Regel, § Ziel) | SYNC | Meta |
| 17 | Feste Schriftschwelle, fehlende Datei in Struktur | lokal | Mikro |

**Verteilung:** Meta/Prozess 5 (K6, K13, K14, K15, K16), Lebenszyklus/Nebenläufigkeit 5 (K2, K3, K4, K11, K12), Ressourcen 3 (K5, K8 teilweise, K10), Meso/Erfüllbarkeit 1 (K1), Mikro 3 (K7, K9, K17).

## Kosten

- 168 504 Token, ≈ 1,4 × des 4J-Vorlaufs (≈ 122 000) und über dem D7-Richtwert „etwa ein Review". Treiber: 50 Werkzeugaufrufe (4J: 8). PTc hat Code gelesen (Datei:Zeile-Belege in fast jeder Korrektur), der 4J-Vorlauf nicht.
- Die Selbstschätzung des Agenten lag um ≈ 60 000 Token zu niedrig. → Token nur aus der Agent-Abrechnung übernehmen (für 1D, Kostenregel).

## Vorläufige Belege aus der 4K-Umsetzung (E, Stand 2026-11-09 06:45)

Aus `PHASE_4K_PLAN.md` § Erkenntnisse „Paket 1" (Commit `3ff49f9`). Nur Übernahme und Umsetzung, **noch keine Treffer-Bewertung** (die folgt in 1B Paket 2 nach der 4K-Umsetzung):

- K7: Aufrufstellen umgesetzt (`openFileAsProject`, `project.new`, `project.recover`), zwei Rot-Nachweise erbracht, Schutztest ergänzt.
- K8: ohne Probeladen umgesetzt, Rot-Nachweis über die Prüfstelle `failNextLoadForTests` erbracht.
- K13: (i) mit Rot-Nachweis umgesetzt.
- K15: `browser.preview_changed` mit `reason: "limit"`, ausdrücklich „kein neues Event (PTc K15)".
- K1–K4 betreffen Paket 2 („Beenden, `daw_hung`", Commit `4d51a85`); Auswertung in 1B Paket 2.

---

## Karte und Einarbeitung (wörtlich aus Yoka-DAW `58f8edd:docs/PHASE_4K_PLAN.md`)

### PTc:PLAN (2026-11-08, Subagent `ptc`, Opus 5.5, Effort medium)

Lauf auf den unkommittierten Detailplan (Basis `b393378`). Token und Dauer unter „Zeiten“. Wörtlich:

**VORENTSCHEIDUNG:** **FAIL** (1 HART, PASS-Bedingung 4 verletzt). Der Plan ist **mit Korrekturen tragfähig**: Reihenfolge D342 und Paketschnitt stimmen, nach K1–K5 erwarte ich PASS.

**KORREKTURLISTE (priorisiert)**
1. **HART, daw_hung nicht erfüllbar.** D333 (4) will einen Hänger an „Zeitlimit beim Verbinden trotz vorhandener Pipe“ erkennen. Genau das ist heute schon `daw_busy` (winpipe.py:152-158, ERROR_PIPE_BUSY → WaitNamedPipe → daw_busy). Der 4J-Fall war `daw_busy` („Maximal 8 KI-Verbindungen“, phase4j_abnahme.md:82/100). Der geplante pytest-Server, der annimmt und nie antwortet, liefert heute `daw_timeout` (link.py:192-198), nicht `daw_busy`; der Rot-Nachweis in PHASE_4K_PLAN.md:126 ist also falsch. → Unterscheidungsmerkmal festlegen. Vorschlag: Die DAW schreibt einen Herzschlag mit PID und Zeit nach DataFolders, z. B. alle 1 s vom Accept-Thread; Pipe belegt plus veralteter Herzschlag = `daw_hung`, 8 echte Verbindungen = `daw_busy`. Den Test auf den Fall ERROR_PIPE_BUSY mit veraltetem Herzschlag umstellen. QUERSCHNITTLICH.
2. **Crash-Handler verdrängt WER-Dumps.** JUCE `handleCrash` gibt `EXCEPTION_EXECUTE_HANDLER` zurück (juce_SystemStats.cpp:250-253). Die 4J-Dumps `YokaDAW.exe.<pid>.dmp` (phase4j_abnahme.md:88/90; WER-Ort %LOCALAPPDATA%\CrashDumps, phase1_status.md:121) kamen vermutlich aus WER und entstünden dann nicht mehr. Bei Stapelüberlauf (0xc00000fd) ist ein In-Process-Dump unsicher, Heap-Schaden (0xc0000374) erreicht den Filter nicht (Windows-Verhalten: Hinweis, nicht gelesen). → D333 (1) ändern: kein JUCE-Handler, sondern eigener Filter, der nur die Pipe schließt und `EXCEPTION_CONTINUE_SEARCH` zurückgibt; Dumps bleiben bei WER LocalDumps (Registry-Schlüssel in UPSTREAM.md § Umgebung dokumentieren). Test: künstlicher Absturz → WER-Dump vorhanden. QUERSCHNITTLICH.
3. **Crash-Handler und Threads.** PHASE_4K_PLAN.md:28 (1) „schließt danach die Pipe-Handles“. Der PipeServer-Abbau braucht den Message-Thread und Joins (PipeServer.cpp:218-238), im Absturz drohen ein Deadlock und genau die belegte Pipe. → Rohe Handle-Liste lock-frei führen (atomares Array), im Filter nur `CloseHandle`, keine Heap- oder JUCE-Aufrufe. Im Plan festschreiben. QUERSCHNITTLICH.
4. **Ausnahme vom Wächter ohne Wirkung, Rundown-Fall blind.** `TerminateProcess` entspricht `taskkill /F`, und das wirkte nachweislich nicht (PHASE_4_PLAN.md:292, phase4j_abnahme.md:100, D333 selbst). 4B zeigte „HasExited“ mit Kernel-Threads, der Hänger liegt also vermutlich nach dem eigenen Abbau. → Wächter nur für den Dump. Letzte shutdown-Zeile `exit` vor `return`. Paket 2 Schritt 3: nach der letzten Zeile die Zeit bis zum Prozessende und `pipe_probe` messen; bleibt der Prozess hängen, `procdump -ma` von außen (Empfehlung PHASE_4_PLAN.md:292). Autosave `shutdownClean` vor das Schließen des Geräts legen (heute AppContext.cpp:122-123 vor der Engine). LOKAL.
5. **Aufräumregel Build-Ordner (PASS-Bedingung 4).** Neu sind `Yoka-DAW-release`, `-analyze`, `-asan`, `-4j` (PHASE_4K_PLAN.md:24/25/200), ohne Aufräumregel. → `-4j` nach der Abnahme löschen, die anderen drei bleiben (je Unterphase), Platz einmal messen und in „Messwerte“ eintragen. LOKAL.
6. **Fakt 4 falsch.** „setzt nur bei Speichern unter resetChangedStatus()“ (PHASE_4K_PLAN.md:56) stimmt nicht: Auch das normale Speichern setzt zurück (ProjectWriter.cpp:92-93). → Fakt korrigieren; die Folgerung (kein Timer-Abbruch) bleibt richtig. SYNC.
7. **D332 (b)/(c) Aufrufstellen fehlen.** `markChangedAfterLoad` wird nur von `project.recover` gerufen (ProjectCommands.cpp:454), nicht von `openFileAsProject` (:97-109) oder `project.new` (:542-545). Der Test „Änderung 50 ms nach open“ (PHASE_4K_PLAN.md:109) braucht diese Aufrufe. → Aufrufstellen nennen, dazu ein Schutztest „open/new/restore ohne Änderung → nach 800 ms ungeändert“ (Review 4J, phase4j_abnahme.md:98). LOKAL.
8. **D332 (d) Rot-Nachweis.** „Gültiges XML ohne EDIT“ und „abgeschnittene Datei“ lehnt der Code schon heute vor dem Kopieren ab (ProjectCommands.cpp:366-367), diese Tests können nicht rot werden. Echte Lücke: EDIT-Wurzel vorhanden, aber `loadEdit` liefert nullptr nach dem Kopieren (:102-105, :374). → Rot-Nachweis nur über die Prüfstelle. Die Vorab-Ladung streichen: sie verdoppelt die Ladezeit auf dem Message-Thread, und das Zurückkopieren deckt den Fall ab. LOKAL.
9. **B1 nicht am Endstand gemessen.** Paket 2 misst B1, danach ändern Paket 3/4 das Zeichnen der Kanalzüge. D342 Begründung (1) verlangt Prüfung am Endstand (PHASE_4K_PLAN.md:42), Szenario 5 nutzt „Messwert B1“ (:235). → In Paket 7 Schritt 3 die B1-Messung bei 100 % und 150 % wiederholen. QUERSCHNITTLICH.
10. **Paket 9 Schritt 0: Zeit und Konkurrenz.** Drei vollständige Neubauten plus ASan-Lauf „direkt vor dem Block“ (:226) fehlen in der Schätzung (:303, rund +2–2,7 h) und konkurrieren mit L-12-Messläufen. → Schritt 0 seriell und vollständig vor dem Ruf an Yoka; Messläufe erst danach; Zeiten anpassen. LOKAL.
11. **ASan-Fehlalarme durch Zeitgrenzen.** Echtzeitnahe Tests (Freeze, LevelQuery) sind schon unter Last rot (phase4j_abnahme.md:96, PHASE_4_PLAN.md:280); D330 (2) verlangt `yoka_tests` vollständig. → `run_asan.ps1` wertet nur ASan-Berichte als Befund; zeitkritische Tests über eine Ausschlussliste mit Begründung. Zusätzlich ein kurzer `--measure`-Lauf mit Gerät (Windows Audio), damit das neue Schließen des Geräts unter ASan läuft. LOKAL.
12. **Hängende Instanz im Test sperrt den Build.** Paket 2 Schritt 3 (:127), 10× ASIO Start/Stop: Ein nachgestellter Hänger sperrt Exe und L-12 bis zum Windows-Neustart (PHASE_4_PLAN.md:292). → Die Läufe mit einer Kopie der Exe in einem eigenen Ordner fahren; „Für Yoka“ um „Windows-Neustart, falls Hänger nachgestellt“ ergänzen; Paket 7 hängt am freien L-12. LOKAL.
13. **Testregel und Review.** (i) ist ein Regressionstest ohne Rot-Nachweis (PHASE_4K_PLAN.md:115 „a–f, h“) und widerspricht PROCESS.md:86 → (i) mit absichtlich falscher Implementierung rot zeigen. Paket 4: Greift der Rückfall aus Annahme 5 (Plugin-Fenster gegenrechnen, PluginEditorWindows), ist der Kernbereich Plugin-Host berührt (PROCESS.md:28, :46) → Review D292 bedingt vorsehen. Annahme 5 zusätzlich mit einem echten Fremd-VST3 aus „Lasttest 2F“ prüfen. LOKAL.
14. **Selbstbeschreibung vorweggenommen.** „PTc:PLAN gelaufen und eingearbeitet“ steht in PHASE_4K_PLAN.md:3, PHASE_4_PLAN.md:3, :84 und :395 („Vorentscheidung und Korrekturliste in den Erkenntnissen“), aber die Erkenntnisse enthalten nichts davon und die Zeile „Plan, PTc“ (:293) ist leer. → Vor dem Commit füllen oder umformulieren. Wird es so committet, wird daraus HART (gespiegelt). SYNC.
15. **Eventname.** D332 (e) nennt `browser.preview_stopped`; registriert ist `browser.preview_changed` mit `reason` (commands.json:806, mcp_tools.json:550, AppContext.cpp:109-112). → `browser.preview_changed` mit `reason: "limit"` nutzen; sonst kommen Registry und Katalog als Kernpfade dazu. SYNC.
16. **Regel- und Zielspiegelung.** D328 und Paket 1 Schritt 1 („mitnehmen nach D310“) widersprechen PROCESS.md:81 (GELB → Abgleich zuerst; mitten in einer Unterphase nichts abgleichen). G4-2 (B) und der Rückfall aus D334 (nanoKONTROL2 → Phase 5) weichen von § Ziel ab (PHASE_4_PLAN.md:17, :19, :20). Kriterium 7, Teil 2 („Stabilitätspunkte aus Phase 3“) hat kein Szenario, und die ModalState-Restlücke geht laut D337 nach Phase 5. → Paket 8: PROCESS.md:81 um die Regel „GELB nur strukturell“ ergänzen; § Ziel mit Verweis auf D331/D334 versehen; `phase4_abnahme.md` belegt Kriterium 7, Teil 2 ausdrücklich (4A-Abnahme) und führt die Restlücke als akzeptierten Rest. SYNC.
17. **Kleinigkeiten Paket 4.** `getLabelFont` nutzt eine feste Schwelle von 14 px (YokaLookAndFeel.cpp:78). Bei Schrift 15/17 gilt jedes Label als „groß“ und folgt der Einstellung nicht mehr → Schwelle relativ zu `theme::fontSize()` setzen. `ViewSettings.h` (Ort von ansicht.json) fehlt in der Dateistruktur (:91). LOKAL.

**Offene Frage des Agenten:** Verträgt Tracktion `closeDevices` vor dem Abbau von Edit, Vorschau-Edit und NotePreview? → Paket 2 Schritt 1 (D333 (2)).

**Einarbeitung (nach D114, alle Punkte übernommen):** K1 → D333 (4) Herzschlag `pipe_heartbeat.json`, Paket 2 Schritt 2 mit Rot-Nachweis `ERROR_PIPE_BUSY` + alter Herzschlag. K2, K3 → D333 (1) eigener lock-freier Filter, `EXCEPTION_CONTINUE_SEARCH`, WER-Dumps bleiben. K4 → D333 (2)/(3): Zeile `exit`, Autosave vor dem Gerät, Wächter ohne `TerminateProcess`, Annahme 2 misst `exit` → Prozessende, `procdump` von außen. K5 → D330 Aufräumregel, Paket 9 Schritt 4, Messwert-Zeile. K6 → Fakt 4. K7 → D332 b/c Aufrufstellen und Schutztest, Paket 1 Schritt 3. K8 → D332 d ohne Probeladen, Paket 1 Schritt 4. K9 → Paket 7 Schritt 3. K10 → Paket 9 Schritt 0 nur bei Code-Änderung seit Paket 6, seriell vor dem Ruf an Yoka; Zeiten. K11 → D330 (2). K12 → Annahme 2 (Kopie der Exe), „Für Yoka“ 0a. K13 → D332 i mit Rot-Nachweis, Annahme 5 mit Fremd-VST3 und bedingtem Review. K14 → diese Abschnitte und „Zeiten“ vor dem Commit gefüllt. K15 → D332 e `browser.preview_changed`. K16 → D328, Paket 8 Schritt 2a, Szenario/Beleg Kriterium 7 Teil 2 in `phase4_abnahme.md`. K17 → D341, Dateistruktur. Kein erneuter PTc-Lauf (der Agent erwartete nach K1–K5 PASS; optional PTc:IST vor der Abnahme, D336).
