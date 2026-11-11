# Lauf 2026-11-10 · Yoka-DAW 5A · PTc:PLAN (zweiter Vorhersagefall, 1B)

| Feld | Wert |
|---|---|
| Datum | 2026-11-10, vor dem Detailplan-Commit `fdaf43c` (17:21); Uhrzeit des Laufs in der Yoka-DAW nicht protokolliert (Zeile „Plan, PTc“ nennt nur das Datum) |
| Projekt | Yoka-DAW (`F:\Yoka\Workspace\Yoka-DAW`, Branch `phase-5a-befunde`) |
| Objekt | `docs/PHASE_5A_PLAN.md`, unkommittierter Detailplan auf Basis `35df51b`; nach Einarbeitung committet als `fdaf43c` |
| Werkzeug | **PTc v1.1.0** (deployt 2026-11-08 19:36; `~/.claude/agents/ptc.md` am 2026-11-11 byte-gleich mit `agent/ptc.md`, letzte Änderung 2026-11-08 19:18) |
| Modus | `PTc:PLAN` |
| Modell | Opus 5.5, Effort medium (Subagent `ptc`) |
| Token | **216 165** (Agent-Abrechnung, Quelle „Agent“ in § Zeiten) |
| Dauer | 621 s (≈ 10,4 min) |
| Werkzeug-Aufrufe | 110 |
| Art | **Vorhersagetest, unkontaminiert** (D14): PTc kannte den 5A-Plan nicht; v1.1 stammt aus 4J/4I |
| Quelle | Yoka-DAW `fdaf43c:docs/PHASE_5A_PLAN.md` § Erkenntnisse „PTc:PLAN“; Kennzahlen aus § Zeiten, Zeile „Plan, PTc“ |
| Protokoll | 2026-11-11 nachgetragen (1B, toter Lernkreis: im PTc-Repo war der Lauf nicht erfasst) |

## Ergebnis des Laufs

- **Vorentscheidung: FAIL** (2 HART: K1, K3), „mit Korrekturen tragfähig“.
- **18 Korrekturen** und ein G4-Kandidat, alle nach D114 der Yoka-DAW eingearbeitet. Die wörtliche Karte des Agenten hat die DAW-Session nicht in den Plan übernommen, nur eine Einarbeitungsliste (unten wörtlich). K12–K18 stehen dort zusammengefasst in einer Zeile.

## Übernahme

| K | Inhalt (Kurzfassung der Einarbeitungsliste) | Übernommen nach |
|---|---|---|
| 1 (HART) | Spur ohne Clip mit Live-Eingang bekäme keinen Injektor | D376, Test, A1 |
| 2 | `nodeID` 0 des `SilentNode`, `ShareOutputBuffer` | D376 Graph-Regeln, Fork-Test, Review-Checkliste |
| 3 (HART) | Paket 5 ist Review-Pflicht (`src/mcp/**`, Prompt) | D386, Paket 5.3 |
| 4, 5 | Pre-Lage durch `plugin.add`, Bounce, Controller-Zählung `send:<n>` | D381, Tests (f)–(h) |
| 6 | Verschmelzen über `coalesce_key`, `level_db` optional, `alreadySatisfied`, Mute | D381, A7 |
| 7 | „Didn't find any audio“ statisch (`hasAudio`), über `TRANS` | A5, Prüfstelle Test (b) |
| 8 | `sanityCheckName` löscht „Spur A“ | zweiter Fork-Patch D383, A8, Test |
| 9 | Marker-Zeile liegt im Lineal | Fakt 9, `rulerHeight`, Zonen-Test |
| 10 | Rot-Nachweis traf die Verdrahtung nicht | `mixerClick`, Spur-Anker, Rückruf |
| 11 | Belege der Szenarien 1, 3, 7, 8 | Szenarien korrigiert |
| 12–18 | Skalierungen 100–175 %, Anweisung ≤ 2 000 Zeichen, Review Paket 4 fest, Pre-Schalter Mixer/Inspector, `getMaximumLength`/MIDI links, Aufräumen `Yoka-DAW-4j`, 4K-Teilbefund Bereich als Beobachtung | je eine Stelle im Plan |
| G4 | Reichweite der Nicker-Pflicht | D389 (A), von Yoka bestätigt (`14a61fd`) |

**Übernahme 18/18 und G4.** Kein erneuter PTc-Lauf. Kein `PTc:IST` vor der 5A-Abnahme (Abnahme 2026-11-11, `6c4522c`).

## Kosten

- 216 165 Token, ≈ 1,3 × 4K (168 504). Treiber: 110 Werkzeugaufrufe (4K: 50). Über dem D7-Richtwert „etwa ein Review“.

## Treffer-Bewertung (2026-11-11, 1B, D37)

**Verfahren:** frischer Opus-Subagent (`general-purpose`, Opus 5.5, nur Read/Grep/Glob), ohne PTc-Interna und ohne Erwartung. Material: Einarbeitungsliste (oben), `docs/PROCESS.md` § Treffer-Bewertung, Plan bei `fdaf43c` und bei `phase-5a`, `git log --stat fdaf43c..phase-5a`, `phase-5a:docs/phase5a_abnahme.md`; Zusatzregel wie 1B (Treffer = durch die Umsetzung sachlich bestätigt, „umgesetzt“ allein reicht nicht). Kosten des Bewerters: 143 921 Token, 11 Werkzeugaufrufe, 178 s.

### Ergebnis

| Treffer | Fehlalarm | Offen | Verpasst | Mehrwert |
|---|---|---|---|---|
| 10 (K3, K4, K5, K6, K7, K8, K9, K10, K11, K14; davon K6, K7, K10, K11 nur teilweise) | 5 (K1 HART, K2, K13, K15, K17) | 4 (K12, K16, K18, G4) | 9 (7 klar, 2 schwach erkennbar, siehe Prüfung) | 3 (K4, K5, K8) |

### Prüfung durch die Session (neben dem Urteil)

- Stichproben gegen `phase-5a:docs/PHASE_5A_PLAN.md` bestätigt: Zeile 187 (A1 widerlegt, D376 ersetzt, „PTc K1, K2 damit gegenstandslos“), 205 (Rot je Mutation (f), (g), (h), (b2)), 220 (Anweisung 1 602 von 2 000 Zeichen), 227 (`Yoka-DAW-4j` war schon weg); `phase5a_abnahme.md:57` (Server-Anweisung nie gesehen). Die Beleg-Zeile für K8 heißt im Plan „A8 bestätigt mit Patch“ (Zeile 210); das Zitat „schnitt fest 6 Zeichen ab“ steht dort nicht wörtlich, der Rot-Nachweis „ohne Fork-Patch“ schon (Zeile 215). Einstufung K8 bleibt Treffer.
- **Einverstanden** mit allen Einstufungen. Gewichtung: Beide HART-Befunde tragen nicht (K1 sachlich falsch, K3 nur Prozesshinweis). Das ist der wichtigste Befund für v1.2: PTc hat in 5A die Prämisse des Plans (Fork-Patch für Befund 2) nicht geprüft, obwohl es denselben Code las, und zwei Korrekturen darauf gebaut (Verpasst 1).
- **Verpasst:** Punkte 8 (Quellspur auf Gruppe) und 9 (Spur-Extras) nennt der Bewerter selbst nur mäßig bzw. erst nach dem Umbau erkennbar; in der Bilanz als „7 + 2 schwach“ geführt.
- **Kandidaten v1.2 (für 1B Paket 3):** (1) Prämissen-Prüfung: Bevor ein Befund auf einer Plan-Entscheidung aufbaut, deren Ursachenannahme am Code prüfen (Verpasst 1, Fehlalarm K1/K2). (2) Annahme als Fakt markiert: Begründungen, die ein ungeprüftes Fremdverhalten voraussetzen (Desktop zeigt die Anweisung), in „Ungeprüfte Annahmen“ verlangen statt sie zu optimieren (Verpasst 3, Fehlalarm K13). (3) Lösungsvorgaben nur als Richtung, nicht als Weg (K7 `hasAudio` undurchführbar). Overfitting-Prüfung in 1D.

### Urteil des Bewerters (wörtlich; Überschriften um zwei Ebenen tiefer gesetzt, sonst unverändert)

Kurzformen der Dateien: **P** = `b5a/PHASE_5A_PLAN_at_phase-5a.md`, **P0** = `b5a/PHASE_5A_PLAN_at_fdaf43c.md`, **Ab** = `b5a/phase5a_abnahme.md`. Zuordnung K12–K18 nach der Reihenfolge in P:182: K12 = Skalierungen, K13 = 2 000 Zeichen, K14 = Review Paket 4, K15 = Pre-Schalter in Mixer und Inspector, K16 = `getMaximumLength` und MIDI links, K17 = `Yoka-DAW-4j`, K18 = Bereich als Beobachtung. Die Zuordnung ist ohne die wörtliche Prüferausgabe nicht gesichert. K4 und K5 stehen in der Quelle nur gemeinsam. Sie bekommen hier eine Zeile und zählen als 2.

#### 1. Einstufung

| K | Einstufung | Beleg E | Begründung | Mehrwert |
|---|---|---|---|---|
| K1 (HART) | **Fehlalarm** | P:187 „A1 widerlegt, kein Fork-Patch (D376 ersetzt) … `createNodeForClips` liefert bei leerer Clipliste immer einen `CombiningNode` … (PTc K1, K2 damit gegenstandslos)“ | Die Annahme „kein Injektor mit Live-Eingang“ war falsch, denn der Injektor entsteht immer. Der Test blieb grün, obwohl der Platzhalter-Zweig abgeschaltet war. | nein |
| K2 | **Fehlalarm** | P:187 „PTc K1, K2 damit gegenstandslos“ | Die Graph-Regeln (`nodeID`, `ShareOutputBuffer`) betrafen einen Patch, der nicht gebaut wurde. Folgenlos. | nein |
| K3 (HART) | **Treffer** | Yoka-DAW `docs/PROCESS.md:54` „Alles andere unter `registry/*` und `src/mcp/**` bleibt Review-Pflicht“; P:222 „PASS ohne Blocker; nur Hinweise, dazu ein ‚sollte‘ … Übernommen: Tests prüfen Kern-Anker“ | Der Plan verstieß tatsächlich gegen PROCESS.md, und das erzwungene Review brachte ein übernommenes „sollte“. Die Einstufung HART ist überzogen: kein Blocker, und den eigentlichen Fehler (Desktop gibt die Anweisung nicht weiter) fand das Review nicht. | nein (Prozessregel steht in PROCESS.md, die ausführende Session hätte sie anwenden müssen; inhaltlich nur Testrobustheit) |
| K4, K5 | **Treffer** (2) | P:205 „Rot je Mutation: … Insert vor den Fader → (f); Bounce immer post → (g); `send:<n>` nach Plugin-Reihenfolge → (h)“ | Das alte Verhalten von `plugin.add`, Bounce und `send:<n>` (die Mutationen entsprechen dem Altstand) hätte die Pre-Lage zerstört bzw. Regler umgehängt. Die Tests sind rot dagegen. | ja: Die Stellen liegen in `PluginCommands`, `TrackCommands` und `ControlTargets`, also außerhalb des `set_send`-Kerns. Tests für `set_send` und Abnahme-Szenario 5 (nur Fader/Mute) hätten sie nicht berührt. Das Review sah nur den Diff, der sie ohne K4/K5 nicht enthalten hätte. |
| K6 | **Treffer** (teilweise) | P:205 „`alreadySatisfied` ohne Lage → 5 Fälle; `coalesce_key` ohne `pre_fader` → (b2) (zuerst grün …)“; P:203 „A7 bestätigt: … ohne `EngineBehaviour`-Eingriff“ | `coalesce_key`, `alreadySatisfied` und `level_db` optional waren real nötig. Der Mute-Teil war folgenlos, das Verhalten stimmte schon. | unklar: `coalesce_key` ja (nur mit Spezialtest b2 sichtbar). `level_db`-Pflicht und `alreadySatisfied` wären beim ersten Rechtsklick „Pre“ in Handprobe oder Abnahme aufgefallen. |
| K7 | **Treffer** (teilweise) | P:197 „Abweichung von D380 (2) … ‚Vor dem Start über `hasAudio`‘ ist ohne den Graphen zu bauen nicht möglich … verglichen mit `TRANS (\"Didn't find any audio to render\")` … Test-Haken `RenderService::testPlanHook`“ | Die Diagnose stimmte: die Meldung ist statisch und läuft über `TRANS`, und für Test (b) war eine Prüfstelle nötig (beides umgesetzt). Der vorgeschlagene Lösungsweg „vor dem Start über `hasAudio`“ war undurchführbar und führte zu einem Review-Blocker (P:198). | unklar (der Englisch-Vergleich hätte bei nur zwei übersetzten Schlüsseln praktisch nicht gebrochen) |
| K8 | **Treffer** | P:210 „`sanityCheckName` schnitt fest 6 Zeichen ab: ‚Spur A‘ wäre beim Laden gelöscht worden … Fork-Patch `d757601`“; P:215 „ohne Fork-Patch → ‚old project … user names‘“ | Datenverlust beim Laden, durch Rot-Nachweis bestätigt. | ja: Fork-Code liegt nicht im Diff, kein Test hätte „Spur A“ ohne den Hinweis geprüft, und die Abnahme speichert und lädt keine Nutzernamen dieser Form. |
| K9 | **Treffer** | P0:48 / P:48 „38 px **einschließlich** Marker-Zeile 14 px … nach PTc K9 korrigiert“; P:216 „Strg-Klick in der Marker-Zeile ohne Ziehen setzt die Position“; Ab:52 Loop bestanden | Der Plan-Fakt war falsch. Die Marker-Zeile liegt im Lineal, und die Zonen-Funktion mit 52 px wurde gebaut und bestanden. | nein (die Handprobe per Maus und die Bildschirmfotos in Paket 4, P:213, hätten die Kollision mit 14 von 19 px gezeigt) |
| K10 | **Treffer** (teilweise) | P:212 „Reine Funktion `mixerClick` … und Spur-Anker `trackAnchor`“; P:215 „`mixerClick` ohne Tasten → 3“; P:26 „Abweichung … das Modell bleibt im `ArrangerView`“; P:216 „Rot-Nachweis zu 4E schützt die reine Funktion, nicht die eine Zeile Verdrahtung“ | Der fehlende Spur-Anker war real (bisher nur Clip-Anker). Der Rückruf-Umbau wurde als unnötig ersetzt, und das Grundmuster (reine Funktion statt Verdrahtung) blieb an anderer Stelle bestehen. | nein (Abnahme-Szenario 4 hätte Umschalt/Strg geprüft) |
| K11 | **Treffer** (teilweise) | Ab:56 Szenario 8 „A `query.project_overview`, D Foto“; Ab:57 „Desktop-Logs zeichnen `tools/call` nicht auf (Beleg aus dem Plan nicht verfügbar)“ | Die Belegklassen der Szenarien 3 und 8 trugen. Der korrigierte Beleg für Szenario 7 (Desktop-Log mit `nicker_freq_advice`) existierte nicht. | nein |
| K12 | **Offen** | Ab:51 „Befund 3 nicht mehr reproduzierbar“; Ab:63 | Ohne reproduzierbare Ursache entstand kein Regressionstest (c). Ob die Parametrisierung etwas gefunden hätte, bleibt unentscheidbar. | unklar |
| K13 | **Fehlalarm** | P:220 „Länge 1 602 von 2 000 Zeichen“; P:31 / P:234 „D384 widerlegt (Desktop gibt die Server-Anweisung nicht weiter)“ | Die Grenze wurde nie berührt. Sie optimierte einen Kanal, der das Modell gar nicht erreicht. | nein |
| K14 | **Treffer** | P:216 „Urteil: kein Blocker. Zwei ‚sollte‘: Spur-Extras bei Clip-Klick und Fangpriorität bei kurzem Loop. Beide behoben“; P:215 „nach dem Review zusätzlich … → 1, … → 1“ | Das erzwungene Review fand zwei reale Fehler, beide mit Rot-Nachweis. | nein (die Fehler fand das Projekt-Review selbst, und Paket 4 enthielt einen Fork-Patch, war also nach D292/PROCESS ohnehin Kern) |
| K15 | **Fehlalarm** | P:204 „Rechtsklick auf den Send-Balken (Mixer und Inspector teilen `ChannelStrip`)“ | Eine Implementierung deckte beide Orte automatisch ab. Folgenlos. | nein |
| K16 | **Offen** | P:195 „rechte Kante: `getMaximumLength() − offset` … MIDI links bleibt `invalid_params` … Tests: `ClipEditTests` (rechts, links, mit Offset, Loop)“ | Umgesetzt, aber kein Beleg, dass eine Eigenrechnung oder `beyond_source` für MIDI links falsch gewesen wäre. Befund A („3.999“, Ab:52) stammt eher aus genau dieser Zeitrechnung. | unklar |
| K17 | **Fehlalarm** | P:227 „der alte Ordner `Yoka-DAW-4j` war schon weg“ | Folgenlos. | nein |
| K18 | **Offen** | Yoka-DAW `docs/PHASE_5_PLAN.md:157` „kein Fehler, nicht in 5A (PTc K18 zu 5A)“; Ab:55 „Ansage ‚Takt 1–9‘ passte nicht zum Dialog (nur Song/Loop-Bereich …)“ | Eingetragen, aber nicht bestätigt oder widerlegt. Die nächste Bereichsfrage im selben Dialog traf die Abnahme trotzdem, und K18 hatte sie nicht erfasst. | unklar |
| G4-Kandidat | **Offen** | P:36 / P:147 „Yoka 2026-11-10: A“; Ab:57 zweiter Anlauf nur Beratungsbitte („Keys wärmer“) | Die Frage war entscheidungsbedürftig, und Yoka entschied sie. Der Zahlenbefehl-Zweig wurde nie geprüft, und kein Beleg zeigt ein verhindertes Problem. | unklar |

#### 2. Verpasst

Aus Plan oder Code vor der Umsetzung erkennbar:

1. **Falsche Ursache von Befund 2 (D376), Ebene Operation / Plan gegen Ist.** P:187 „`createNodeForClips` liefert bei leerer Clipliste immer einen `CombiningNode` (`tracktion_EditNodeBuilder.cpp:909-910`) … Die Sperre `getClips().isEmpty()` in `midi.preview_note` war allein die Ursache“. Der Prüfer las dieselbe Funktion (K1 zitiert `:1630-1646`), bestätigte aber den unnötigen Fork-Patch und legte zwei Korrekturen darauf. Die Sperre stand schon in Fakt 2 (P:41, `MidiCommands.cpp:361-365`).
2. **Kein Graph-Neubau beim Umordnen, Achse Lebenszyklus.** P:202 „Tracktion baut den Graphen bei reiner Umordnung **nicht** neu (`Edit::TreeWatcher::valueTreeChildOrderChanged` leer, `tracktion_Edit.cpp:378`)“. Der Prüfer behandelte die ValueTree-Verschiebung (A6) und Undo (K6), aber nicht die Wirkung auf den laufenden Graphen. Erkennbar aus dem Tracktion-Quelltext. Gefunden erst durch Test (j).
3. **Unbelegte Kernannahme von D384, Erfüllbarkeit.** P0 / P:31 Begründung „die Anweisung ist der einzige Text, den Claude Desktop immer sieht“. Ab:57 „Server-Anweisung von yoka-mcp nie gesehen“, erster Anlauf von Szenario 7 nicht bestanden. Ob die Annahme stimmt, war aus dem Repo nicht zu klären. Dass sie als Fakt statt in „Ungeprüfte Annahmen“ stand, war aber erkennbar. Der Prüfer optimierte stattdessen deren Länge (K13).
4. **Beleg von Szenario 7 nicht verfügbar, Achse Fehlerarten / Belege.** Ab:57 „Desktop-Logs zeichnen `tools/call` nicht auf (Beleg aus dem Plan nicht verfügbar)“. Der Prüfer korrigierte genau diesen Beleg (K11), hätte ihn aber am vorhandenen Log (Pfad in Fakt 12, P:51) prüfen können.
5. **Szenario 6 im Dialog nicht ausführbar, Schnittstelle Oberfläche.** Ab:55 „Ansage ‚Takt 1–9‘ passte nicht zum Dialog (nur Song/Loop-Bereich …)“. Erkennbar aus dem Export-Dialog und der eigenen K18-Analyse desselben Dialogs.
6. **Test wird durch D383 stumm wahr, Testregel.** P:211 „`RoutingTests` prüfte ‚Track 1.wav‘ nicht vorhanden; jetzt ‚genau eine WAV‘ (sonst wäre die Prüfung stumm wahr geworden)“. D383 nannte die Folge „Stem-Dateien heißen ‚Spur n.wav‘“ selbst (P:30). Eine Suche nach `Track 1` in `tests/` hätte es gezeigt.
7. **Fehlermeldung bei 150 % abgeschnitten, Zahl ungerundet mit Punkt, Schnittstelle Oberfläche.** Ab:52 „Meldung bei 150 % abgeschnitten, Zahl ‚3.999‘ statt ‚4‘“. Erkennbar war: D378 gibt einen langen Satz für die Statuszeile bei 150 % vor, und die Beats stammen aus einer zeitbasierten Länge (`getMaximumLength`, die K16 selbst empfahl). Gerundet und mit deutschem Komma war nichts davon festgelegt.
8. **Ursache von Befund 6 (Quellspur auf Gruppe), Schnittstelle Routing / Render.** P:196 „gibt sie **auf eine Gruppe** aus … baut Tracktion sie nur über die Gruppe in den Graphen“. Mäßig erkennbar: Fakt 7 (P:46) nennt das Überspringen von „Spuren mit Ausgang auf eine Spur“, und die 4K-Abnahme nutzte den Bus „Musik“. K7 lenkte stattdessen auf den Knoten im Send-Pfad. Die Messung in A5 fing es auf.
9. **`SelectionModel::click` leert die Spur-Extras nicht, Achse Zustand.** P:216 „vorbestehend, durch den Mixer sichtbar geworden“. Erkennbar aus `Selection.h` (Fakt 6), sobald der Mixer schreibt. Gefunden durch das Review.

**Nicht vorhersehbar:**
- Befund 9: fremde DAW-Lesewerkzeuge vor dem Laden der yoka-Werkzeuge (Ab:62).
- Befund 3 bei 125/175 % nicht reproduzierbar (Ab:51).
- Computer-Use kann die Entwickler-Build nicht freigeben (P:190).
- `git archive | tar` in PowerShell 5.1 zerstört das Archiv (P:227).
- `Copy-Item` behält die Änderungszeit, MSBuild baut nicht neu (P:237).
- Start mit `--measure` ohne `--services` (Ab:49): Die Startzeile entstand erst in Paket 6 und stand nicht im Plan.

#### 3. Zählung

| Kategorie | Anzahl | Einträge |
|---|---|---|
| Treffer | 10 | K3, K4, K5, K6, K7, K8, K9, K10, K11, K14; davon K6, K7, K10, K11 nur teilweise |
| Fehlalarm | 5 | K1, K2, K13, K15, K17 |
| Offen | 4 | K12, K16, K18, G4 |
| Verpasst | 9 | Punkte 1–9 |
| Mehrwert ja | 3 | K4, K5, K8 |

#### 4. Gesamturteil

Beide HART-Befunde tragen nicht: K1 war sachlich falsch (zusammen mit K2), K3 war ein formal richtiger Prozesshinweis mit geringem Ertrag. Der echte Nutzen lag in den Querwirkungen außerhalb des Kerns: Pre-Lage bei Insert, Bounce und Controller (K4/K5) und Namensverlust beim Laden (K8). Diese drei Punkte hätten weder die Tests des Pakets noch das Review gefunden. Gravierend verpasst sind die falsche Ursache von Befund 2, obwohl der Prüfer denselben Code las, und die ungeprüfte D384-Annahme, die den einzigen nicht bestandenen ersten Abnahmeanlauf verursachte. Mehrere Befunde (K13, K15, K17) und Lösungsvorgaben (K7: `hasAudio` vor dem Start) waren folgenlos oder undurchführbar, das Signal-Rausch-Verhältnis ist also mittel.

---

## Karte und Einarbeitung (wörtlich aus Yoka-DAW `fdaf43c:docs/PHASE_5A_PLAN.md`)

### PTc:PLAN (2026-11-10, Subagent `ptc`, Opus 5.5, Effort medium)

Vorentscheidung **FAIL** wegen K1 und K3, „mit Korrekturen tragfähig"; alle Korrekturen nach Empfehlung eingearbeitet (D114):

- **K1 (HART)** Spur ohne Clip mit Live-Eingang bekäme keinen Injektor → D376 baut Platzhalter und Injektor auch mit Live-Eingang, gemeinsame Hilfsfunktion, Test und A1 erweitert.
- **K2** `nodeID` 0 des `SilentNode` (Assert) und `ShareOutputBuffer` → D376 Graph-Regeln, Fork-Test, Review-Checkliste.
- **K3 (HART)** Paket 5 ist nach PROCESS.md Review-Pflicht (`src/mcp/**`, Prompt) → D386, Paket 5.3.
- **K4, K5** Pre-Lage durch `plugin.add`, Bounce und Controller-Zählung `send:<n>` → D381, Tests (f)–(h).
- **K6** Verschmelzen über `coalesce_key`, `level_db` optional, `alreadySatisfied`, Mute über `EngineBehaviour` → D381, A7.
- **K7** „Didn't find any audio" ist statisch (`hasAudio`) und über `TRANS` → A5 neu, Erkennung über `hasAudio`, Prüfstelle für Test (b).
- **K8** `sanityCheckName` löscht „Spur A" → zweiter Fork-Patch in D383, A8 neu, Test Speichern/Laden.
- **K9** Marker-Zeile liegt im Lineal → Fakt 9 korrigiert, `rulerHeight` 52, Zonen-Funktion mit Test.
- **K10** Rot-Nachweis traf die Verdrahtung nicht → `mixerClick`, Spur-Anker, Rückruf.
- **K11** Belege der Szenarien 1, 3, 7, 8 korrigiert (`query.project_overview`, D statt A für Desktop-Logs, T für Ansicht).
- **K12–K18** Skalierungen 100–175 % im Test, Anweisung ≤ 2 000 Zeichen, Review Paket 4 fest, Pre-Schalter in Mixer und Inspector, `getMaximumLength` und MIDI links, Aufräumen `Yoka-DAW-4j`, 4K-Teilbefund Bereich als Beobachtung.
- **G4-Kandidat** Reichweite der Nicker-Pflicht → D389 nach Empfehlung A, Yoka zur Bestätigung.
