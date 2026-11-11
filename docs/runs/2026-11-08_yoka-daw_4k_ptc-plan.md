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

## Treffer-Bewertung (2026-11-11, 1B Paket 2, D37)

**Verfahren:** frischer Opus-Subagent (`general-purpose`, Opus 5.5, nur Read/Grep/Glob), ohne PTc-Interna und ohne Erwartung. Material: Karte (unten), `docs/PROCESS.md` § Treffer-Bewertung, Plan bei `58f8edd` und bei `phase-4k` (§ Erkenntnisse aller Pakete, Reviews wörtlich), `git log --stat 58f8edd..phase-4k`, `phase-4k:docs/phase4k_abnahme.md` und `phase4_abnahme.md`; Bewertungsregel 1B (Treffer = durch die Umsetzung sachlich bestätigt, „umgesetzt“ allein reicht nicht); Pakete 6b/6c (nach dem Lauf hinzugekommen) zählen nicht als Verpasst. Kosten des Bewerters: 195 854 Token, 31 Werkzeugaufrufe, 319 s. Ersetzt den Abschnitt „Vorläufige Belege“ (Stand 2026-11-09).

### Ergebnis

| Treffer | Fehlalarm | Offen | Verpasst | Mehrwert |
|---|---|---|---|---|
| 11 (K1, K2, K4, K5, K7, K8, K10, K11, K12, K15, K16; K10, K12 schwach) | 1 (K6) | 5 (K3, K9, K13, K14, K17) | 10 (7 klar, 3 schwach) | 3 (K1 HART, K2, K4) |

### Prüfung durch die Session (neben dem Urteil)

- Stichproben gegen `phase-4k:docs/PHASE_4K_PLAN.md` bestätigt: Zeile 435 (WER-Dump nach dem Filter, ohne WER kein Dump), 437 (`daw_hung` über Herzschlag bei `ERROR_PIPE_BUSY`), 467 (2,0 GB frei, 31,2 GB gelöscht), 536 (`not_applied: ["block_size"]`); `phase4k_abnahme.md:75` (Befund 7, hart beendeter Prozess hält die Pipe).
- **Einverstanden** mit den Einstufungen. Zwei Abwägungen: K4 ist Treffer über einen Analogieschluss (harter Abbruch durch Claude Desktop statt `TerminateProcess` des Wächters); belastbar, weil 4J denselben Befund mit `taskkill /F` hatte. K5 und Verpasst 6 überlappen: PTc sah die Plattenachse, aber nur das Aufräumen danach, nicht den Platz davor.
- **Verpasst 4 (64 statt 256 Samples)** ist der teuerste Fall: Plan-gegen-Ist auf einer Messvoraussetzung, die seit 4B falsch war. Kandidat v1.2 (1B Paket 3): Messvoraussetzungen (Puffer, Takt, Gerät) verlangen einen Beleg, dass der Ist-Wert angewandt wurde, nicht nur angefordert (domänenneutral: „angefordert ≠ wirksam“). Zweiter Kandidat: eigene Korrekturen (K3-Entwurf) auf Wettläufe prüfen (Verpasst 3).
- Mehrwert 3 von 11 Treffern; alle drei liegen auf Lebenszyklus/Fehlerarten (Absturz, Hänger), die übrigen Treffer hätte die Testregel oder der erste ASan-Lauf der DAW selbst gezeigt.

### Urteil des Bewerters (wörtlich; Überschriften um zwei Ebenen tiefer gesetzt, sonst unverändert)

#### 1. Einstufung K1–K17

Pfadkürzel: `P_end` = b4k/PHASE_4K_PLAN_at_phase-4k.md, `P_vor` = b4k/PHASE_4K_PLAN_at_58f8edd.md, `Abn` = b4k/phase4k_abnahme.md, `Abn4` = b4k/phase4_abnahme.md

| K | Einstufung | Beleg E | Begründung | Mehrwert |
|---|---|---|---|---|
| 1 | **Treffer** | P_end:437 „pytest mit echter, belegter Pipe … und altem bzw. `stopped`-Herzschlag: vorher `assert 'daw_busy' == 'daw_hung'` (2 Fälle rot)“; `link.py` blieb unverändert, „der Fall entsteht beim Öffnen“ | Die Umsetzung bestätigt: Bei belegter Pipe kam vorher `daw_busy`, und der Hänger zeigt sich beim Öffnen, nicht als Zeitüberschreitung im Link. Die ursprüngliche Erkennung und ihr Rot-Nachweis wären fachlich falsch gewesen. | ja: Ein Test nach Originalplan (Server nimmt an und antwortet nie) hätte eine falsche Umsetzung grün bestätigt. Der Review prüft den Diff, nicht das Konzept. |
| 2 | **Treffer** | `juce_SystemStats.cpp:253` „return EXCEPTION_EXECUTE_HANDLER;“; P_end:435 „Mit `SetErrorMode (SEM_NOGPFAULTERRORBOX)` im Kind entstand **kein** Dump“ und Dump `yoka_tests.exe.9192.dmp` „nach dem Filter geschrieben“ | Aus dem Code belegt: Der JUCE-Handler verdrängt WER. Empirisch belegt: Läuft WER nicht, entsteht kein Dump, und mit `EXCEPTION_CONTINUE_SEARCH` entsteht er. | ja: Ein In-Process-Dump über den JUCE-Handler wäre im Test grün gewesen. Dass WER-Dumps wegfallen und Heap-Schäden den Filter nie erreichen, hätte weder ein Test noch ein Review gezeigt. |
| 3 | **Offen** | P_end:434 „64 atomare Plätze … `compare_exchange` … Der Filter setzt zuerst ein Flag `crashing()`“ | Der lock-freie Weg funktioniert (Rot-Nachweis ohne `closeAllPipeHandles`). Ein Deadlock des ursprünglichen PipeServer-Abbaus wurde aber nie gezeigt, die Gefahr ist nur aus dem Code plausibel. | unklar |
| 4 | **Treffer** | Abn:75 Befund 7 „hart beendet … blieb ohne Fenster mit 2 Threads und `zml12asio.dll` hängen, hält die Pipe“; P_end:439 „`exit` bis Prozessende 32–35 ms“, 10 Läufe ohne `shutdown_stuck` | Ein harter Abbruch (entspricht `TerminateProcess`) befreit nichts, er erzeugte den Hänger sogar. Ein Wächter mit `TerminateProcess` wäre also wirkungslos bzw. schädlich gewesen. Die `exit`-Zeile hat den normalen Abbau als unauffällig eingegrenzt (Abn:64). | ja: Kein Test und kein Review hätte gezeigt, dass `TerminateProcess` beim Kernel-Hänger nicht greift. Belegt hat es erst der Abnahme-Block. |
| 5 | **Treffer** | P_end:467 „Vorher 2,0 GB frei, danach alte Vergleichs-Builds gelöscht (31,2 GB)“; P_end:357 „Rest aus 4J: `Yoka-DAW-4i` 2,0 GB + `src-phase-4i` 0,2 GB“ | Ohne Aufräumregel blieben die Vergleichs-Ordner aus 4J liegen, und der Plattenplatz wurde tatsächlich knapp. | unklar: Der Engpass trat trotz K5 auf (die Regel greift erst nach der Abnahme) und fiel im Betrieb auf, nicht durch Test oder Review. |
| 6 | **Fehlalarm** (folgenlos) | `ProjectWriter.cpp:93` „edit.resetChangedStatus();“; Karte:13 „die Folgerung (kein Timer-Abbruch) bleibt richtig“ | Sachlich richtig, aber nach eigener Aussage des Prüfers ohne Folge für Umsetzung oder Ergebnis. | nein |
| 7 | **Treffer** | P_end:419 „Rot-Nachweis: … ‚Änderung 50 ms nach open‘ (vorher ungeändert) … rot“; Aufrufstellen `openFileAsProject`, `project.new`, `project.recover` | Bestätigt: `open` rief die Markierung nicht auf, der Test brauchte die neuen Aufrufstellen. Der Schutztest war vorher grün und hat keinen Fehler gefangen. | nein: Der geplante Test „Änderung 50 ms nach open“ wäre ohne die Aufrufstellen rot geblieben, das Problem wäre also auch so aufgefallen. |
| 8 | **Treffer** | P_end:420 „Prüfstelle: `ProjectSession::failNextLoadForTests`. Kein Probeladen. **Rot-Nachweis:** ohne Rollback Fehlercode `internal` und Datei bleibt die Version“ | Bestätigt: Die echte Lücke „EDIT-Wurzel da, Laden scheitert nach der Kopie“ bestand. Dass die ursprünglich geplanten Fälle nicht rot werden konnten, zeigt die Umsetzung nicht direkt. | unklar: Die Testregel (Rot-Nachweis) hätte die nie roten Fälle wohl gezeigt, die echte Lücke aber nicht sicher. |
| 9 | **Offen** | P_end:191 „~~Aufgabe 3: Befund B1 (D334)~~ → nach Phase 5 (G4-1 Yoka B)“ | B1 wurde durch Yokas G4-Antwort gestrichen, die Messung lief nie. Nicht entscheidbar. | – |
| 10 | **Treffer** (schwach) | P_end:559 „Prüfwerkzeuge neu … 7,8 min … Wiederholung 0/0/0 (12,4 min) … 18,6 min“; P_end:474 „schlug `yoka_tests` in Release einmal fehl, als parallel andere Läufe liefen“ | Schritt 0 war nötig, fehlte in der Schätzung und lief seriell. Gleichzeitige Läufe schaden nachweislich. Die Menge war überschätzt: rund 55 min statt +2–2,7 h. | unklar (reine Zeitplanung, geringe Folge) |
| 11 | **Treffer** | P_end:486 „`Freeze`, `LevelQuery` (Zeitgrenzen, PTc K11) und der Testfall ‚the index of 20 000 files*‘ (Zeitgrenze 2500 ms, unter ASan 3958 ms). Fehlschläge ohne ASan-Bericht gelten nicht als Befund“; P_end:487 `--measure` unter ASan „sauber beendet“ | Zeitgrenzen-Fehlschläge unter ASan traten wie vorhergesagt ein, die Ausschlussliste war nötig. Der `--measure`-Lauf ergab keinen Befund. | nein: Der erste ASan-Lauf hätte die roten Zeitgrenzen sofort gezeigt. |
| 12 | **Treffer** (Prämisse) | Abn:75 „hält die Pipe … Windows-Neustart zur Freigabe“; P_end:560 „Windows-Neustart“ | Bestätigt: Ein hängender Prozess sperrt Pipe und L-12 bis zum Windows-Neustart. Der konkret abgesicherte Fall (Hänger in Paket 2, Exe-Kopie) trat nicht ein (P_end:439 „Hänger nicht nachgestellt“). | unklar |
| 13 | **Offen** | P_end:425 (i) „Rot-Nachweis: `file_path` … weggelassen → rot“; P_end:455 „Kein Rückfall … kein Review D292“, „ein Foto bei 150 % mit Fremd-VST3 wurde nicht gemacht“ | Teil (i) stimmte formal mit der Testregel überein, deckte aber keinen Fehler auf. Der bedingte Review war folgenlos (der Rückfall griff nicht), die Prüfung mit Fremd-VST3 wurde nicht ausgeführt. | nein |
| 14 | **Offen** | P_end:386–413, :572 (Abschnitt und Zeile „Plan, PTc“ gefüllt) | Im Material ist nur die Einarbeitung zu sehen, nicht der kritisierte Vorher-Stand. Die Umsetzung bestätigt nichts inhaltlich. | nein |
| 15 | **Treffer** | P_end:421 „über das bestehende Event `browser.preview_changed` (`playing: false`, `reason: "limit"`), kein neues Event (PTc K15)“; `preview_stopped` kommt in `registry/` und `src/` nicht vor | Das Event gab es nicht. Die Korrektur sparte Änderungen an Register und Katalog. | nein: Der Register-Zähltest (siehe P_end:528) und der Drift-Test hätten ein neues Event angezeigt. |
| 16 | **Treffer** | Abn4:17 „Teil 2: phase4a_abnahme.md Szenarien 1–6 … `ModalState`-Restlücke als akzeptierter Rest (D337)“; P_end:552 „`PROCESS.md` § Upstream-Prüfung ergänzt (D328, PTc K16)“ | Bestätigt: Kriterium 7, Teil 2 hatte vorher keinen Beleg und brauchte ausdrücklich die 4A-Abnahme. | unklar: Das Gerüst `phase4_abnahme.md` (D335 (7), „je mit Beleg“) hätte die Lücke vermutlich auch gezeigt. |
| 17 | **Offen** | `YokaLookAndFeel.cpp:166` (späterer Stand) „> theme::fontSize (1.0f)“; P_end:460 „`getLabelFont` mit relativer Schwelle (PTc K17)“ | Umgesetzt und aus dem Code schlüssig. Eine Auswirkung wurde aber nie beobachtet (Abn:54, Szenario 1 mit Schrift 15 ohne Anmerkung). | nein |

#### 2. Verpasst

Nur ursprüngliche Pakete 1–9, ohne 6b/6c.

1. **Revision zählt Ereignisse (Schnittstelle, Paket 1).** P_end:419: „**nicht** Ereignisse, weil `publishSystemEvent` die Revision hochzählt“, deshalb wurde ein neuer `getMutationCount()` nötig. Erkennbar war das aus P_vor:27 (D332 b/c: „merkt sich die Revision“) und dem Bus-Code. K7 hat den Revisionsansatz sogar mitgetragen. Gefunden hat es der Umsetzer.
2. **Lint-Verbot `closeAudioDevice` (Schnittstelle Plan ↔ Lint, Paket 2).** P_end:440: „trifft das Verbotsmuster `closeAudioDevice` im Lint `tests/lint/check_bus_only.ps1`“. Erkennbar war das, weil P_vor:28 (D333 (2)) das Schließen des Geräts in `AppContext` plant und die Lint-Regel im Repo stand. Gefunden haben es Test und Review.
3. **Wettlauf im Absturz-Filter (Threads, Paket 2).** P_end:434: „danach legt die Annahme keine neue Instanz an … sonst belegte der abgestürzte Prozess den Namen gleich wieder“. Der Entwurf aus K3 schloss nur die Handles und übersah, dass der Annahme-Thread während des Filters weiterläuft. Gefunden hat es der Umsetzer beim Durchsehen.
4. **L-12-Treiber hält 64 Samples (Plan gegen Ist, Erfüllbarkeit, Paket 7).** P_end:536: „`not_applied: ["block_size"]` … alle ‚256er‘-Lasttests seit 4B liefen mit 64“. Erkennbar war das aus drei Quellen:
   - D331 (P_vor:26) setzt 256 voraus, ohne den tatsächlich angewandten Puffer zu prüfen.
   - `not_applied` gab es schon im Code: Paket 7 (`f67005b`) änderte kein `src/`.
   - Der Widerspruch „Überläufe trotz 0,7–2,3 ms von 5,33 ms“ stand in D208.

   Gefunden hat es die eigene Messung des Projekts.
5. **Zeitschätzung Paket 5 (Ressource Zeit).** P_end:577: Schätzung 1–1,5 h, Ist 4,7 h. Laut Plan kostet jeder neue Build-Ordner 30–45 min Neubau (P_end:567). Paket 5 braucht mindestens zwei volle Neubauten (vorher und nachher) plus Volltests. Die Schätzung war also schon in sich nicht stimmig. K10 betraf nur Paket 9.
6. **Freier Platz auf C: vor den neuen Build-Ordnern (Platte; teilweise in K5).** P_end:467: „Vorher 2,0 GB frei … Ausnahme vom 35-GB-Minimum“. Der Plan legt rund 14 GB neue Ordner an (P_end:357), ohne vorher den freien Platz zu prüfen. K5 regelt nur das Aufräumen nach der Abnahme.
7. **ASan bricht beim ersten Fremdfehler ab und fängt den CrashFilter-Test ab (Fehlerarten, Paket 6).** P_end:485: „MSVC 14.44 kennt **keine** Ignorierliste … ASan bricht beim ersten Fehler ab“. P_end:486: `CrashFilter`, „ASan fängt ihn vor dem eigenen Filter ab“. D330 (4) nahm an, Fremdfehler gehen nur in die Offenen Punkte, während der Lauf weitergeht. K11 sah nur Zeitgrenzen, und den Crash-Test hatte K2 selbst eingeführt. Schwach dazu: C1060 durch Speichermangel beim parallelen ASan-Neubau auf 16 GB (P_end:483).
8. **DAW-Lebenszyklus beim Neustart von Claude Desktop (Lebenszyklus, Paket 9).** Abn:75, Befund 7. P_vor:293 verlangt „Claude Desktop ganz beenden“, und Annahme 2 (P_vor:87) sagt „nie ein laufendes YokaDAW mit ASIO killen“. Der Plan legt aber nicht fest, aus welchem Prozessbaum die DAW in Paket 9 gestartet wird. Das kostete einen Windows-Neustart mitten im Block.
9. **(schwach) Datei-Drop unter globalem Skalierungsfaktor (Schnittstelle, Paket 4).** Abn:71, Befund 3: „bei Skalierung 125/150 % nicht an“. D341 und die Annahmen 5/6 prüfen nur Plugin-Fenster und Layout, nicht die OS-Koordinaten beim Drag & Drop.
10. **(schwach) Kontrast-Paarliste unvollständig (Erfüllbarkeit D340 (4), Pakete 3–5).** P_end:450, :462 (weiß auf `select` 2,53 : 1), :473 (`play` 2,3 : 1, `record` 3,9 : 1). D340 verlangt „alle Text-/Hintergrund-Paare“, die Liste umfasste aber nur bekannte Paare.

**Nicht vorhersehbar:**
- C1083-Lesefehler bei Neubauten (P_end:475, :559)
- Regex- und `C`-Präfix-Fehler aus dem Altbestand (P_end:480)
- `SEM_NOGPFAULTERRORBOX` im Testkind (P_end:435)
- Lastabhängige Wackeltests `FreezeTests:263`, `ProjectCacheTests:308` (P_end:474, :563)
- Auto-Modus lehnt die Sonnet-Session ab (P_end:534)
- Befund 8 „Nicker nicht gefragt“, Verhalten von Claude Desktop (Abn:77)
- Befunde 1, 2, 4: Altverhalten aus 4H, D213 und 4F, nicht Gegenstand des Plans (Abn:69–72)

**Randnotiz:** Befunde 5 und 6 (Mehrfachauswahl im Mixer, Stem-Export bricht am Effekt-Bus ab) und das Review in 6c (`masterDetails` ohne `channels`) gehören zu 6b/6c und zählen nicht.

#### 3. Zählung

| Treffer | Fehlalarm | Offen | Verpasst | Mehrwert |
|---|---|---|---|---|
| 11 (K1, 2, 4, 5, 7, 8, 10, 11, 12, 15, 16) | 1 (K6) | 5 (K3, 9, 13, 14, 17) | 10 (davon 3 schwach: Nr. 6, 9, 10) | 3 (K1, K2, K4) |

#### 4. Gesamturteil

Der Prüfer traf den Kern der riskanten Unterphase: Erkennung des Hängers, WER-Dumps und die Wirkungslosigkeit von `TerminateProcess` wurden durch Rot-Nachweis, Dump-Befund und Befund 7 sachlich bestätigt. Echten Mehrwert über Tests und Reviews des Projekts liefern aber nur diese drei Befunde. Die übrigen Treffer hätte das Projekt mit seiner Testregel, dem Register-Test oder dem ersten ASan-Lauf selbst gefunden, oder sie sind Prozess- und Zeitpunkte mit geringer Folge. Fünf Befunde bleiben offen, meist weil der Fall nicht eintrat oder entfiel, einer war folgenlos. Die schwerste Lücke ist der verpasste 64-Samples-Befund (D331 gegen Ist): Der Widerspruch stand bereits in D208, und er hat die Lasttests seit 4B entwertet. Dazu kommen übersehene Schnittstellen (Revision zählt Ereignisse, Lint-Verbot) und Lücken im Lebenszyklus des eigenen Crash-Filter-Entwurfs und von Szenario 7.

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
