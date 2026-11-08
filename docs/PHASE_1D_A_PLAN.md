# Unterphase 1D-a „v1.1 aus 1C" – Detailplan

Status: **erledigt, v1.1.0 deployt** (2026-11-08 19:36); Merge nach `main`, Tag `phase-1d-a` · Pakete 1–6 ohne Yoka · Grundlage: [PHASE_1_PLAN.md](PHASE_1_PLAN.md) D1–D14, D25 · [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md) D15–D24 und § Erkenntnisse · [PROCESS.md](PROCESS.md) (Reviews, Testregel)

> **Für die ausführende Session:** **Eine** Session (Sonnet 5.5, Effort medium, D12) setzt 1D-a von Paket 1 bis zum Merge um, ohne Rückfrage zwischen den Paketen. Review (Paket 2) und Bewertungen (Paket 4–5) laufen als **Opus-Subagenten** mit frischem Kontext (D10, D12, D20). Alles lokal (D11), Branch `phase-1d-a-v11` (existiert, enthält diesen Plan), Commits `phase 1D-a: …`, Plan im selben Commit pflegen (diese Datei **und** `PHASE_1_PLAN.md`: Statuszeile, Fortschritt, Zeiten). Das Yoka-DAW-Repo wird **nicht** gelesen (Fixtures genügen; D13, D24). **Nicht ändern:** `evals/cases/*/expected.md` und `evals/GRADER.md` (Commit `fd2b581`, D18), `evals/fixtures/**`, bestehende Dateien in `evals/results/`.

**Ziel:** `agent/ptc.md` von v1.0.0 auf **v1.1.0** heben, mit allgemeinen Regeln aus den 1C-Erkenntnissen (J5 stabil verpasst, 4I-Befunde nur als offene Fragen, `reconnect` × Aufnahme verpasst), einem Rot-Nachweis, der diesmal etwas verfehlen kann, Review, Eval-Volllauf und Deploy – damit 1B v1.1 auf dem unkontaminierten 4K-Plan misst (D25).

**Fertig, wenn:** (1) `agent/ptc.md` v1.1.0 mit CHANGELOG, `check.ps1` grün, Review „kein Blocker" wörtlich unter Fortschritt (T); (2) Volllauf v1.1 bewertet, **keine Regression** gegen v1.0 (D31) (T); (3) Rot-Nachweis je Variante erbracht oder sein Fehlen begründet (T); (4) Messwerte und Erkenntnisse eingetragen; (5) `scripts/deploy.ps1` ok, Merge nach `main`, Tag `phase-1d-a`, Push.

## Entscheidungen 1D-a (D26–D34, von Claude nach Empfehlung)

| # | Thema | Entscheidung | Begründung |
|---|---|---|---|
| D26 | Umfang v1.1 | Genau die Änderungen **Ä1–Ä7** (§ „Änderungen an `agent/ptc.md`"). Version **1.1.0** (Minor: neue Regeln, keine entfernt). Keine weiteren Umbauten | 1C nennt drei konkrete Lücken (J5, „Frage statt Befund" bei I1–I3, I4) und eine Bestätigung (§ 7). Kleiner Umfang hält Review und Overfitting-Prüfung beherrschbar |
| D27 | Overfitting-Schutz | (a) Neue Regeln sind **allgemein** formuliert (Zustand, Pfad, Grenze, Betriebszustand), ohne Begriffe der Ableitungsfälle. (b) **Verbotsliste** (Paket 1, Schritt 6) gilt für alles außer § 10, § 11 und `CHANGELOG.md`. (c) Review-Prüfpunkt „Overfitting" ausdrücklich mit der Verbotsliste. (d) Ein besseres Ergebnis auf `4j-ist`/`4i-plan` gilt **nicht** als Wirkungsnachweis (D14); die Wirkung misst erst 1B auf 4K (D25). (e) `expected.md` und `GRADER.md` bleiben unverändert | 4J ist Ableitungsfall von v1.0, 4I jetzt Ableitungsfall von v1.1. Regeln, die Stichworte der Fälle enthalten, würden das Eval-Set „bestehen", ohne auf 4K zu wirken |
| D28 | D6 bleibt bei vier Pflichtfragen | „Summe unter gleichzeitiger Last / Wartezeit" wird Teil von Pflichtfrage 4 (Konkurrenz), **keine** fünfte Frage | D6 legt „vier Pflichtfragen (Budget, Messbeleg, Wachstum, Konkurrenz)" fest. Die Lücke aus I1 ist inhaltlich eine Konkurrenz-Frage; so entsteht kein Widerspruch zu D6 |
| D29 | `check.ps1` | Pflichtabschnitte `### 3.5 Zustandspfade` und `### 3.6 Erfüllbarkeit` in `$required` aufnehmen. Kernänderung (D10), gemeinsamer Review mit `agent/ptc.md`; Rot-Nachweis gegen eine Kopie ohne § 3.5 | Schützt die neuen Regeln gegen stilles Verschwinden in v1.2. Testregel: Schutzprüfung gilt erst nach einem roten Lauf |
| D30 | `evals/run.ps1` | Ergebnisname und Kopfzeile nehmen die Version aus `## Version X.Y.Z` der Agent-Datei (`v1.1`), auch bei Rot-Varianten (`rot-…_v1.1`). Existiert die Zieldatei schon, **Abbruch** (außer mit `-Tag`). Keine Kernänderung (PROCESS.md § Reviews), aber Rot-Nachweis des Abbruchs | Heute steht `'v1.0'` fest in `run.ps1:132` und `:195`; ein Lauf am selben Datum würde `2026-11-08_4j-ist_v1.0.*` überschreiben |
| D31 | Schwelle für Deploy | Deploy, wenn **keine Regression** gegen v1.0: `4j-ist` trifft J1–J4, J6; `4i-plan` trifft I5; in beiden **0 NICHT verletzt, 0 Fehlalarme**. Verbesserungsziele (J5 Treffer, I1–I4 Treffer statt Teiltreffer/Verpasst) sind Messung, **keine** Bedingung. Bei Regression **eine** Nachbesserungsrunde (Änderung, zweiter Review, Lauf des betroffenen Falls); bleibt sie, v1.0 bleibt deployt und 1D-a endet mit begründetem „nicht deployt" | 1B braucht eine deployte Fassung; eine Fassung, die Bekanntes verliert oder Fehlalarme bringt, darf nicht vor 1B. Die Verbesserung ist auf Ableitungsfällen ohnehin kein Nachweis (D27 d) |
| D32 | Rot-Nachweis | Drei Varianten aus v1.1 (Tabelle „Rot-Nachweis-Design"). Die Bindung „Erwartung ↔ genau ein geschnittener Abschnitt" steht in **neuen** Dateien `evals/cases/<fall>/rot-bindung.md`, **vor** dem ersten v1.1-Lauf in einem eigenen Commit. `expected.md` bleibt unverändert. Rot gilt je Variante, wenn **mindestens eine** gebundene Erwartung, die der v1.1-Positivlauf getroffen hat, verfehlt wird (Teiltreffer zählt als verfehlt) | 1C: Schnitte trafen Erwartungen, die an mehreren Abschnitten hängen. Neue Abschnitte (§ 3.5, Befundpflicht) sind die **einzige** Quelle ihrer Befunde, wie die vier v1.0-Läufe ohne J5 zeigen; der Meta-Schnitt nimmt alle Wege weg, über die v1.0 J3/J4 ohne § 3.4 fand |
| D33 | Läufe und Modelle | Positiv: `4j-ist` Sonnet **zweimal** (Lauf + Wiederholung, Stabilität von J5), `4i-plan` Opus einmal. Rot: Modell wie Positivlauf (D19). Effort medium. Varianten, deren gebundene Erwartungen im Positivlauf nicht getroffen wurden, laufen **nicht** (nichts zu verfehlen) – Fehlen begründen | J5 war in vier Läufen stabil verpasst; ein einzelner Treffer könnte Zufall sein. Opus-Läufe kosten ≈ 1,24 USD, darum 4I nur einmal |
| D34 | Kosten | Volllauf (die zwei Positivläufe, ohne Wiederholung) bleibt ≤ **250 000 Token ohne Cache-Read** (D23). `agent/ptc.md` wächst höchstens um **+25 %** (≤ 400 Zeilen, ≤ 23 500 Byte; v1.0: 319 Zeilen, 18 815 Byte). Budgetgrenze je Lauf wie 1C (`-MaxBudgetUsd` 2 Sonnet, 3 Opus). Summe 1D-a Läufe ≤ 8 USD | Mehr Prompt heißt mehr Grundlast je Turn; D7 verlangt vertretbare Kosten. Schätzung unter „Kostenbudget" |

## Geprüfte Fakten (2026-11-08)

1. **v1.0-Stand:** `agent/ptc.md` 319 Zeilen, 18 815 Byte; Abschnitte § 0, § 0.5, § 1–11, QUICK START. Version an drei Stellen: Frontmatter `description` („v1.0"), Z. 8 `## Version 1.0.0`, QUICK START Z. 307 und Fußzeile Z. 319. `check.ps1` vergleicht `description` vX.Y mit `## Version` und verlangt `## X.Y.Z` in `CHANGELOG.md`.
2. **Verbotsliste-Basis:** Grep `Plugin|Fader|reconnect|Aufnahme|OSC|Autosave|Undo-Schritt|28 von|4I|4J|Tracktion|MIDI|Fenster` in v1.0 → nur Z. 293 (§ 11, „PHASE_4J_PLAN.md"). Die Liste ist also heute außerhalb § 11 leer und taugt als Prüfung.
3. **`check.ps1`:** Parameter `-AgentPath`, `-SkipDeployed`; `$required` ab Z. 35 (13 Einträge, u. a. `### 2.3 Ressourcen`, `### 3.4 Plan-gegen-Ist`). Vor dem Deploy schlägt die Deploy-Prüfung fehl, darum bis Paket 6 `-SkipDeployed`.
4. **`run.ps1`:** `'v1.0'` fest in Z. 132 (Dateiname) und Z. 195 (Kopf); Rot-Varianten tragen keine Version im Namen. Schnittarten `section|` (bis zur nächsten `#`- oder `---`-Zeile), `block|` (bis Leerzeile), `line|`; Abbruch, wenn ein Anfang fehlt.
5. **J5 (`4j-ist`):** in allen vier v1.0-Läufen verpasst. Die Stelle steht im Fixture als **Erkenntnis** mit Verweis auf eine Entscheidung („Änderungen am Bus vorbei (Plugin-Fenster) lösen kein Autosave aus (entspricht D313)", `PHASE_4J_PLAN.md:290`) gegen das Ziel „Kein Datenverlust" (Z. 7), ohne offenen Punkt. v1.0 hat keine Regel, die (a) Nebenpfade eines Zustands aufzählt und (b) eine „gewollte" Lücke gegen ein Muss-Ziel zum Befund macht.
6. **4I (`4i-plan`, Opus):** I1, I2 standen als Querachsen-Zeile bzw. Operator, I3 als offene Frage O2 („Werden acht überlappende Fahrten unter **einer** gemeinsamen Geste … zu 8 Undo-Schritten … oder zu einem?"), obwohl Plan-Fakt und Plan-Akzeptanz beide gelesen waren (V gegen V, § 0.5 Regel 6). Die Korrekturliste bestätigte sogar „acht Fader ergeben 8". I4: kein Wort zu Neu-Öffnen gegen einen laufenden Zustand außer dem getesteten. 0 Fehlalarme, 0 NICHT verletzt.
7. **NICHT-Erwartungen nahe an den neuen Regeln:** `4j-ist` J9 (Vorschau ohne Meter, Erkenntnis Z. 307), J10 (wirkungsloser Undo-Schritt, Z. 282), J11 (Cache-Aufräumer gegen Freeze-Dateien), J12 (Neulesen 2-mal je Sekunde, Z. 300), J13 (zwei Instanzen auf `versions.json`); `4i-plan` I15 (Hotplug allgemein; HART nur für den Zustand aus I4), I16/I17 (im Plan behandelte Undo-Risiken). Ä1–Ä5 sind so abgegrenzt, dass sie diese nicht zu HART/LECK machen (siehe Risiko je Änderung).
8. **Kosten 1C:** Sonnet-Lauf ≈ 0,55–0,58 USD, ≈ 100 000 Token ohne Cache-Read; Opus-Lauf `4i-plan` 1,24 USD, 108 593; Volllauf 212 559 / 1,82 USD; Grader-Subagent je ≈ 25 000–50 000 Token.

## Ungeprüfte Annahmen (im genannten Paket zuerst prüfen)

| # | Annahme | Paket | Rückfall |
|---|---|---|---|
| A1 | Die allgemeine Zustandspfad-Regel (Ä1) bringt Sonnet dazu, J5 als LECK zu melden | 4 | trifft v1.1 J5 nicht: **keine** fall-spezifische Nachschärfung (D27); Erkenntnis „Regel greift auf 4J nicht", Variante `rot-ohne-3-5` entfällt (D33), 1B misst weiter |
| A2 | Befundpflicht (Ä3) und „offene Frage nur bei fehlender Quelle" (Ä4) erzeugen keine Fehlalarme gegen NICHT (J9–J13, I13–I17) | 4 | Fehlalarm = Regression (D31) → Nachbesserung: Befundpflicht auf Grenzen beschränken, auf die sich ein **Muss-Kriterium oder ein Akzeptanztest** stützt (ist schon so formuliert; dann Wortlaut schärfen), zweiter Review |
| A3 | Der Meta-Schnitt (`rot-ohne-plan-ist-meta`) nimmt v1.1 alle Wege zu J3/J4; Konsistenz § 4 allein trägt sie nicht | 5 | trifft die Variante J3 und J4 trotzdem: Erkenntnis „Plan-gegen-Ist ist emergent aus Quellen-Bindung/Konsistenz"; kein weiterer Schnitt in 1D-a, Fall `4j-ist` bleibt für J3/J4 ohne Rot-Nachweis (begründet) |
| A4 | v1.1 bleibt im Kostenrahmen D34 (mehr Regeln → mehr Matrixzeilen und Korrekturen) | 4 | Volllauf > 250 000 ohne Cache-Read: Ausgabe-Regel „nur Treffer berichten" (§ 2) für § 3.5 wörtlich wiederholen; > 300 000 gilt als Regression (D31) |
| A5 | `run.ps1` erzeugt die neuen Varianten aus v1.1 korrekt (Schnitte finden ihre Anfänge, `line|| **Meta** |` mit führendem `|` funktioniert, weil `Split('|', 2)` nur am ersten `|` trennt) | 3 (`-DryRun`) | Präfix ohne führendes `|` geht nicht (Zeile beginnt mit `|`); dann `run.ps1` um Schnittart `match|` (Zeile enthält) erweitern, Rot-Nachweis wie Paket 1 von 1C |

## Änderungen an `agent/ptc.md` (Ä1–Ä7)

Der **Wortlaut** ist Vorgabe; sprachlich glätten ist erlaubt, Substanz und Grenzen nicht. Beispiele in Klammern bleiben allgemein (D27). Platzierung genau wie angegeben, damit die Rot-Schnitte (Paket 3) greifen.

**Ä1 – neuer Abschnitt § 3.5 (nach § 3.4, vor `---` und § 4):**

```
### 3.5 Zustandspfade (Meso)
Für jeden **dauerhaften Zustand**, den der Plan einführt oder berührt (Projekt- oder Dokumentzustand, Datei, Register, Einstellung):
1. **Alle Änderungspfade aufzählen:** den Hauptpfad (z. B. Befehls-Bus, Service-Schicht) **und** die Nebenpfade (eigene Bedienoberflächen eingebetteter Fremdkomponenten, direkte API- oder Dateizugriffe, Import, Wiederherstellung, Hintergrundjobs).
2. **Je Pfad prüfen:** Erreicht er den **Persistenzauslöser** (Speichern, Geändert-Markierung, Revision oder Benachrichtigung) und, wo der Plan es verlangt, Undo?
3. **Pfad ohne Weg zum Persistenzauslöser = LECK** (Datenverlust-Pfad), mit Eintrag in der Korrekturliste – **auch wenn der Plan die Lücke als bekannt, gewollt oder durch eine Entscheidung gedeckt beschreibt**, solange sie nicht als offener Punkt oder als Aufgabe mit Haken verankert ist. Widerspricht die Lücke einem Muss-Ziel des Plans (z. B. „kein Datenverlust"), Reichweite mindestens QUERSCHNITTLICH.
Die Pfade erscheinen als Zeilen der Schnittstellen-Matrix (§ 3.1), keine eigene Tabelle. Nur Pfade mit Befund berichten.
```

Risiko J9–J13: Die Regel gilt nur für Änderungspfade **eines dauerhaften Zustands zum Persistenzauslöser**; Meter, Undo-Qualität, Aufräumer und gleichzeitige Schreiber sind andere Substanz.

**Ä2 – § 2.2 Lebenszyklus, Satz anhängen:**

```
**Zustandskreuz:** Für jede Operation, die eine Ressource freigibt, neu öffnet oder ersetzt (Gerät, Datei, Verbindung, Prozess), gegen **jeden laufenden Betriebszustand** prüfen, nicht nur gegen den, den der Plan testet (z. B. Leerlauf, Verarbeitung/Wiedergabe, Schreiben/Aufzeichnen, Speichern, Hintergrundjob). Verwirft die Operation in einem ungeprüften Zustand Daten oder bricht sie ihn ab → LECK mit Testaufgabe für diesen Zustand.
```

Risiko I15: allgemeines Ab-/Anstecken bleibt erlaubt; Befund nur für den Zustand, in dem Daten verloren gehen.

**Ä3 – § 2.3 Ressourcen:** (a) Pflichtfrage 4 ersetzen durch

```
4. **Konkurrenz?** Teilen sich mehrere Teile dieselbe Ressource (gleiche Platte, gleicher Thread, gleiches Kontingent)? Gilt eine Grenze nur **je Aufruf, je Element oder je Quelle**: Ist auch die **Summe** bei gleichzeitiger Nutzung und die **Wartezeit** begrenzt? Ist ein Kontingent nach dem Plan voll oder ohne Reserve für angekündigte Folgearbeit?
```

(b) nach dem Satz „Fehlt eine Messung, schlage …" als eigener Absatz:

```
**Befundpflicht:** Jede Pflichtfrage endet als „erfüllt" oder als **Befund** – nie als bloße Notiz in der Querachsen-Zeile. Fehlt bei einer Grenze, auf die sich ein Muss-Kriterium, ein Akzeptanztest oder eine Folgephase stützt, das Budget, die Summe unter gleichzeitiger Last oder die Reserve, ist das mindestens **LECK** mit Korrekturliste-Eintrag (Stelle, Budget oder Messaufgabe festlegen). **HART**, wenn eine im Plan gesetzte harte Grenze schon überschritten oder rechnerisch nicht einhaltbar ist.
```

Bleibt bei vier Pflichtfragen (D28). Risiko J12: Neulesen-Last ohne Muss-Kriterium → keine Befundpflicht.

**Ä4 – Frage oder Befund:** (a) § 0.5 Regel 6 ergänzen um „… voll belastbar (V gegen V), auch ohne Code-Prüfung. **Ein solcher Widerspruch ist ein Befund (HART/LECK/SYNC) mit Korrektur, nie eine offene Frage.**" (b) Neue Verhaltensregel **14** (in § 9 anhängen, Nummern 1–13 bleiben):

```
14. **Offene Frage nur bei fehlender Quelle.** Eine offene Frage nennt, welche Quelle fehlt. Liegt die Substanz in gelesenen Stellen vor (V oder S), wird sie Befund mit Korrektur, nicht Frage.
```

(c) Ausgabe § 8: nach dem Block `KONSISTENZ` die Zeile `OFFENE FRAGEN: [je Frage: welche Quelle fehlt]` einfügen.

**Ä5 – neuer Abschnitt § 3.6 (nach § 3.5):**

```
### 3.6 Erfüllbarkeit (nur PTc:PLAN)
Für jedes Akzeptanzkriterium und jede Muss-Zeile mit Zahl, Zählung oder Grenze („genau N …", „≤ X ms", „kein …"): Folgt es aus den **Mechanismen und Fakten, die der Plan selbst nennt**? Liefert der beschriebene Mechanismus etwas anderes (eine statt N Einheiten, Grenze je Aufruf statt Summe, ein Zustand, den der Mechanismus nicht kennt), ist das **HART** (Plan gegen Plan, V gegen V) mit Korrektur am Kriterium oder am Mechanismus.
```

Risiko I16/I17: Risiken, die der Plan selbst nennt und behandelt, sind kein Widerspruch (§ 4 bleibt maßgeblich).

**Ä6 – § 7 und § 10:** § 7 Tabelle unverändert (IST bleibt Sonnet). § 10 Zeile „Modellwahl je Modus" Spalte Wert: „PLAN Opus, IST Sonnet (IST auf Sonnet bestätigt im Eval-Set 1C: alle MUSS bis auf eine inhaltliche Lücke, 0 Fehlalarme)". § 10 neue Zeilen: „Zustandspfade (§ 3.5) | Pflicht für dauerhafte Zustände | erzeugen sie überwiegend Leerlauf-Zeilen → auf Zustände mit Muss-Ziel beschränken" und „Befundpflicht (§ 2.3), Frage nur bei fehlender Quelle (§ 9.14) | Pflicht | erzeugen sie Fehlalarme gegen behandelte Risiken → Schwelle auf Muss-Kriterien schärfen".

**Ä7 – Version und Herkunft:** `description` „v1.0" → „v1.1" (sonst unverändert) · Z. 8 `## Version 1.1.0 | 2026-11-08` · QUICK START „v1.0" → „v1.1" · Fußzeile `v1.1.0` · § 11 neuer Absatz „**v1.1 (2026-11-08):** aus dem Eval-Set 1C (`4j-ist` Regression, `4i-plan` Vorhersage): Zustandspfade, Zustandskreuz, Summe unter Last und Befundpflicht, Frage nur bei fehlender Quelle, Erfüllbarkeit. Wirkung auf neue Pläne offen bis 1B." · `CHANGELOG.md` Eintrag `## 1.1.0 — 2026-11-08` mit Ä1–Ä6 je eine Zeile und Hinweis D27.

**Geprüft und verworfen bzw. übernommen (Hypothesen aus 1C § Erkenntnisse „Planung"):**

| Hypothese 1C | Entscheidung | Begründung |
|---|---|---|
| (1) § 2.3 „Warteschlange/Durchsatz unter gleichzeitiger Last" | **übernommen** als Ä3 (a), in Pflichtfrage 4 (D28) | I1 nur Teiltreffer: Grenze „je Aufruf" erkannt, Summe nicht |
| (2) § 2.4 Groß-/Kleinschreibung unter Windows, Port-Teilung | **verworfen** | I8, I9 sind KANN und wurden von der Umsetzung selbst gefunden (kein Mehrwert, PROCESS.md); plattform-spezifische Stichworte widersprechen D27 |
| (3) § 7 „IST auf Sonnet" bestätigen | **übernommen** als Ä6 (nur Beleg in § 10, keine Modelländerung) | `4j-ist` Sonnet 5/6 MUSS in zwei Läufen, Verpasstes inhaltlich, 0 Fehlalarme |
| (4) Prompt-Vorlage in den QUICK START | **verworfen** | A8 grün: keine Rückfragen mit der Vorlage in `evals/cases/*/prompt.txt`; Aufrufer in Fremd-Projekten nennen Objekt/Stand selbst (§ 0) |
| (5) Lese-Regeln schärfen | **verworfen** | alle Positivläufe 98 000–109 000 ohne Cache-Read (< 150 000) |
| (6) § 3.4 kürzen | **verworfen** | eine Messung reicht nicht für das Streichen einer Regel (Review-Prüfpunkt „verlorene Regel"); das Problem war der Schnitt, nicht der Abschnitt → neuer Meta-Schnitt (D32) |
| 1C Paket 4–5: Matrix-Regel Persistenzauslöser (J5) | **übernommen** als Ä1 | J5 viermal verpasst, Ursache: keine Regel für Nebenpfade und „gewollte" Lücken |
| 1C Paket 4–5: Querachsen ohne Budget → Befund | **übernommen** als Ä3 (b), Ä4 | I1–I3 nur Teiltreffer |
| 1C Paket 4–5: Vorhersage-Probe „Folge des Mechanismus" | **übernommen** als Ä5 | I3: Mechanismus (eine Geste) widerspricht Akzeptanz (N Schritte) |
| I4 verpasst (`reconnect` × Aufnahme) | **übernommen** als Ä2 | kein v1.0-Abschnitt kreuzt Lebenszyklus-Operationen mit Betriebszuständen |

## Dateistruktur

| Pfad | Art | Inhalt |
|---|---|---|
| `agent/ptc.md` | Kern | Ä1–Ä7 |
| `CHANGELOG.md` | Pflege | Eintrag 1.1.0 |
| `scripts/check.ps1` | Kern | `$required` + `### 3.5 Zustandspfade`, `### 3.6 Erfüllbarkeit` (D29), sonst unverändert, ASCII |
| `evals/run.ps1` | Werkzeug | Version aus Agent-Datei, Abbruch bei vorhandener Zieldatei (D30), ASCII |
| `evals/variants/rot-ohne-3-5.txt` | neu | Schnitt Ä1 |
| `evals/variants/rot-ohne-befundpflicht.txt` | neu | Schnitt Ä3 (b), Ä4, Ä5 |
| `evals/variants/rot-ohne-plan-ist-meta.txt` | neu | starker Meta-Schnitt |
| `evals/cases/4j-ist/rot-bindung.md`, `evals/cases/4i-plan/rot-bindung.md` | neu | Bindung Erwartung ↔ Variante (D32) |
| `evals/README.md` | Pflege | neue Varianten, Versionsname, `rot-bindung.md` |
| `evals/results/2026-11-08_*_v1.1*` | neu | Ergebnisse (Datum = Lauftag) |
| `docs/PHASE_1D_A_PLAN.md`, `docs/PHASE_1_PLAN.md` | Pflege | Status, Fortschritt, Zeiten, Messwerte, Erkenntnisse |

Nicht geändert: `evals/cases/*/expected.md`, `evals/cases/*/prompt.txt`, `evals/GRADER.md`, `evals/fixtures/**`, `evals/variants/rot-ohne-2-3.txt`, `rot-ohne-3-4.txt`, `rot-test-fehlt.txt`, `scripts/deploy.ps1`.

## Aufgaben

### Paket 1: v1.1 schreiben

**Modell: Sonnet 5.5, Effort medium**

- [x] Ä1–Ä7 in `agent/ptc.md` per Edit-Tool (UTF-8 ohne BOM, LF), `CHANGELOG.md`.
- [x] `scripts/check.ps1`: zwei Einträge in `$required` (D29), ASCII (`Erfüllbarkeit` als `'### 3.6 Erf' + [char]0xFC + 'llbarkeit'`, weil nur ASCII erlaubt).
- [x] `powershell -File scripts\check.ps1 -SkipDeployed` → `check ok` (T, 17:36).
- [x] Rot-Nachweis D29: Kopie ohne `### 3.5 Zustandspfade` → `FAIL: required section missing: ### 3.5 Zustandspfade`, Exit 1 (T).
- [x] Größe nach D34: **339 Zeilen, 22 613 Byte** (Grenze 400 / 23 500; v1.0: 319 / 18 815, +20 % Byte).
- [x] **Verbotsliste (D27):** Grep (ignore case) → Treffer nur Z. 311 („4J" in § 11, v1.0-Text) und Z. 320 (v1.1-Absatz § 11). Außerhalb leer.
- [ ] Commit `phase 1D-a: Paket 1 (ptc.md v1.1.0, check.ps1)` erst **nach** Paket 2 (Review vor Commit, D10); bis dahin im Arbeitsbaum.

**Fertig, wenn:** check grün, Rot-Nachweis D29 erbracht, Verbotsliste leer außerhalb § 10/§ 11 (T).

### Paket 2: Review

**Modell: Opus 5.5, Effort medium** (Subagent, frischer Kontext, nur Read/Grep/Glob, D10)

- [x] (Durchgang 1, Opus-Subagent, Urteil siehe § Fortschritt) `git add -N .`, dann vollständiger `git diff HEAD` (enthält `agent/ptc.md`, `CHANGELOG.md`, `scripts/check.ps1`).
- [ ] Subagent erhält: Aufgabe („Kernänderung PTc v1.0.0 → v1.1.0 prüfen"), den Diff, D1–D14, D25 aus `PHASE_1_PLAN.md`, D26–D29 aus diesem Plan, `docs/PROCESS.md` § Reviews, die 1C-Ergebnisse `evals/results/2026-11-08_4j-ist_v1.0.md` und `…_4i-plan_v1.0.md` (Begründung der Änderung). **Nicht** § „Änderungen an `agent/ptc.md`" und die Risiko-Zeilen dieses Plans (Begründungen des Implementierers, PROCESS.md).
- [ ] Prüfpunkte laut PROCESS.md plus ausdrücklich: Overfitting mit Verbotsliste (D27), Widerspruch zu D6 (vier Pflichtfragen), Fehlalarm-Gefahr der Befundpflicht, Kostenwirkung (D34).
- [ ] Urteil **wörtlich** unter Fortschritt (diese Datei und `PHASE_1_PLAN.md`). Blocker → beheben, zweiter Durchgang mit neuem Diff; erst „kein Blocker" erlaubt den Commit.
- [x] Commit Paket 1+2.

**Fertig, wenn:** „kein Blocker" wörtlich eingetragen, Commit (T).

### Paket 3: Eval-Werkzeug und Rot-Bindung

**Modell: Sonnet 5.5, Effort medium**

- [x] `evals/run.ps1` nach D30: Version per Regex aus `$AgentPath`; Namensbildung und Abbruch-Prüfung vor den DryRun-Ausstieg gezogen.
- [x] Rot-Nachweis D30 (T): `-DryRun` meldet `Ergebnisname: 2026-11-08_4j-ist_v1.1`; mit Dummy `2026-11-08_4j-ist_v1.1.json` → `Ergebnis existiert schon (kein Ueberschreiben ohne -Tag)`, Exit 1; Dummy gelöscht.
- [x] Varianten (A5 grün): `-DryRun` je Variante findet alle Schnitte (`rot-ohne-3-5`: Z. 150-156; `rot-ohne-befundpflicht`: 115, 289, 256, 156-158; `rot-ohne-plan-ist-meta`: 141-149, 242-244, 86, 87, 267), `line|| **Meta** |` mit führendem `|` funktioniert; Ergebnisname `<datum>_<fall>_<variante>_v1.1`.
- [x] `evals/cases/4j-ist/rot-bindung.md` und `evals/cases/4i-plan/rot-bindung.md`; `evals/README.md` ergänzt.
- [x] Commit `phase 1D-a: Paket 3 (run.ps1, Varianten, Rot-Bindung)` **vor** dem ersten v1.1-Lauf (D32); Hash unter Fortschritt.

**Fertig, wenn:** beide Rot-Nachweise (Abbruch, Schnitte) erbracht, Bindung committet (T).

**Format `rot-bindung.md`:**

```
# Rot-Bindung <fall> (v1.1, PHASE_1D_A_PLAN.md D32)
| Variante | geschnitten | gebundene Erwartungen (expected.md fd2b581) | Rot, wenn | Kontrolle (soll weiter treffen) |
```

### Paket 4: Positivläufe v1.1

**Modell: Sonnet 5.5, Effort medium** (Läufe nach D33, Bewertung Opus-Subagent nach `GRADER.md`)

- [x] `run.ps1 -Case 4j-ist -Variant v -Model sonnet -MaxBudgetUsd 2`, danach `-Tag wdh` (Wiederholung), und `run.ps1 -Case 4i-plan -Variant v -Model opus -MaxBudgetUsd 3`; im Hintergrund, parallel möglich.
- [x] Gültigkeit (D24); je Lauf ein frischer Opus-Grader (nur `expected.md` + `.karte.md`, Auftrag `GRADER.md`), Ergebnis wörtlich in die Ergebnisdatei.
- [x] D31 prüfen (Regression). Bei Regression: Nachbesserungsrunde (Ä-Wortlaut schärfen, nie fall-spezifisch), Paket 2 erneut, nur den betroffenen Fall erneut (`-Tag nb`).
- [x] A1, A2, A4 auswerten; Messwerte-Tabelle.

**Fertig, wenn:** drei gültige, bewertete Läufe, D31 entschieden, Messwerte eingetragen (T).

### Paket 5: Rot-Nachweis

**Modell: Sonnet 5.5, Effort medium**

- [x] Je Variante nach „Rot-Nachweis-Design", **nur** wenn mindestens eine gebundene Erwartung im Positivlauf (Lauf **oder** Wiederholung bei `4j-ist`) Treffer war (D33); sonst Fehlen begründen.
- [x] Bewertung je Lauf durch frischen Opus-Grader; Rot-Entscheidung nach `rot-bindung.md`; A3 auswerten.

**Fertig, wenn:** je Variante Rot erbracht oder Fehlen begründet (T).

### Paket 6: Deploy und Abschluss

**Modell: Sonnet 5.5, Effort medium**

- [x] Nur bei D31 erfüllt: `powershell -File scripts\deploy.ps1` → Hash gleich; danach `scripts\check.ps1` **ohne** `-SkipDeployed` grün.
- [x] Erkenntnisse (Vorschläge für 1B/1D nur als Liste), Messwerte, Zeiten; `PHASE_1_PLAN.md`: Statuszeile (1D-a erledigt, nächstes 1B wartet auf 4K), Unterphasen-Tabelle, Fortschritt, Zeiten.
- [x] Merge-Commit nach `main` (`phase 1D-a: Merge v1.1`), Tag `phase-1d-a`, Push `main` und Tag (privat, D5).

**Fertig, wenn:** Deploy ok (oder begründet nicht), Merge und Tag gepusht, Plan aktuell.

## Rot-Nachweis-Design

| Variante | Schnitt (`evals/variants/<name>.txt`) | Fall | Modell | gebunden, muss verfehlen | Kontrolle, darf weiter treffen |
|---|---|---|---|---|---|
| `rot-ohne-3-5` | `section|### 3.5 Zustandspfade` | `4j-ist` | Sonnet | **J5** (nur, wenn der Positivlauf J5 trifft) | J1–J4, J6 |
| `rot-ohne-befundpflicht` | `block|**Befundpflicht:**` · `line|14. **Offene Frage nur bei fehlender Quelle.**` · `line|OFFENE FRAGEN:` · `section|### 3.6 Erfüllbarkeit` | `4i-plan` | Opus | **I1, I2, I3** (die, die der Positivlauf als Treffer hat; v1.0 hatte sie nur als Teiltreffer) | I5, I6, I7 |
| `rot-ohne-plan-ist-meta` | `section|### 3.4 Plan-gegen-Ist` · `block|PLAN-GEGEN-IST (nur IST/VERIFY)` · `line|| **Meta** |` · `line|> **Meso und Meta immer prüfen.**` · `line|5. **Meso und Meta immer.**` | `4j-ist` | Sonnet | **J3, J4** (`expected.md`: „hängen ganz an § 3.4"; v1.0 fand sie ohne § 3.4 über Meta) | J5 (falls getroffen), J6 |

- Ä4 (a) (Zusatz in § 0.5 Regel 6) bleibt in `rot-ohne-befundpflicht` stehen, weil er ein Satz innerhalb einer Regel ist; der Schnitt nimmt die eigenständigen Teile. Verfehlt die Variante trotzdem nichts, ist das eine Erkenntnis (Satz in Regel 6 trägt allein), kein Fehler des Falls.
- `line|`-Präfixe beginnen genau mit dem Zeilenanfang in v1.1; bei Abweichung nach Ä-Glättung Präfix anpassen, **nicht** den Agent-Text (A5).
- Sparsam: je Variante genau ein Lauf; Rot-Läufe erneut nur, wenn eine Nachbesserung den geschnittenen Abschnitt ändert (D23).
- Die 1C-Varianten (`rot-ohne-3-4`, `rot-ohne-2-3`) laufen nicht erneut; ihre Ergebnisse gelten als 1C-Befund.

## Kostenbudget

| Posten | Läufe | Token ohne Cache-Read (Schätzung) | USD (Schätzung) |
|---|---|---|---|
| Positiv `4j-ist` Sonnet + Wiederholung | 2 | ≈ 2 × 110 000 | ≈ 1,2 |
| Positiv `4i-plan` Opus | 1 | ≈ 120 000 | ≈ 1,4 |
| **Volllauf** (`4j-ist` + `4i-plan`) | 2 | **≤ 250 000** (D34) | ≈ 2,0 |
| Rot `rot-ohne-3-5`, `rot-ohne-plan-ist-meta` (Sonnet) | 0–2 | ≈ 2 × 105 000 | ≈ 1,1 |
| Rot `rot-ohne-befundpflicht` (Opus) | 0–1 | ≈ 115 000 | ≈ 1,3 |
| Nachbesserung (nur bei Regression) | 0–1 | ≈ 120 000 | ≤ 1,4 |
| Review-Subagent Opus (1–2 Durchgänge) | 1–2 | ≈ 60 000 je Durchgang | Session |
| Grader-Subagenten Opus | 3–7 | ≈ 7 × 40 000 | Session |
| **Summe 1D-a** | | **≈ 1,1–1,4 Mio.** | **≈ 5–6,5 USD Läufe (Grenze 8, D34)** |

## Fortschritt

### Paket 1+2 (2026-11-08 17:41)

Review-Urteil Opus-Subagent (frischer Kontext, Durchgang 1, vollständiger Diff), **wörtlich**:

> Urteil: kein Blocker
>
> **Blocker:** keine.
>
> **Hinweise (nicht blockierend), je Prüfpunkt:**
>
> - **Widerspruch zu D-Nummern:** keiner gefunden. D3 hält: kein Score. Die Zahlen in § 10 („0 Fehlalarme“) sind Eval-Metadaten, keine Ausgabe der Karte. Die Score-Regex in `check.ps1` bleibt. D6 hält: weiter vier Pflichtfragen, die Summe ist in Frage 4 eingebaut (wie D28 verlangt). D7 hält: Einsatzpunkte und Modell-Zeilen bleiben unverändert, kein `model:` im Frontmatter. D1 hält: `tools` unverändert. Kleinere Unschärfe: D26 nennt Ä1–Ä7, das CHANGELOG nur Ä1–Ä6 plus eine `check.ps1`-Zeile. Prüfen, ob Ä7 vollständig abgedeckt ist (den Abschnitt „Änderungen“ habe ich bewusst nicht gelesen).
> - **Verlorene oder abgeschwächte v1.0-Regel:** keine. Alle Änderungen ergänzen nur (§ 0.5 Regel 6, Pflichtfrage 4, § 2.2, § 2.3, neu § 3.5, § 3.6, § 9 Regel 14, § 10, § 11). Nichts ist gestrichen.
> - **Mehrdeutigkeit:** (a) § 2.2 Zustandskreuz: Ausgelöst wird nur, wenn die Operation Daten „verwirft … oder bricht sie ab“. Steht im Plan nicht, was im ungeprüften Zustand passiert, kann ein Lauf das als LECK (Zustand ungeprüft, fehlender Test) werten, ein anderer als offene Frage (§ 0.5 Regel 4, Quelle fehlt). Vorschlag: „Behandelt der Plan den Zustand nicht (weder Verhalten noch Test) → LECK mit Testaufgabe.“ (b) § 2.3 Befundpflicht: Der erste Satz macht jede nicht erfüllte Pflichtfrage zum Befund. Eine Stufe nennt die Regel aber nur für Grenzen, auf die sich ein Muss-Kriterium stützt. Für die übrigen Grenzen bleibt die Stufe offen (LECK, SYNC oder doch nur Notiz?). (c) Bei der Belegklasse von Ressourcen-Aussagen im Plan widersprechen sich zwei Regeln. § 0.5 Regel 3 sagt „[UNVERIFIZIERT] … (dann: S, mit Hinweis)“. Regel 14 in § 9 macht S zum Befund, Regel 4 in § 0.5 macht [UNVERIFIZIERT] zur Frage. Das war in v1.0 harmlos, entscheidet jetzt aber zwischen Befund und Frage. (d) § 7: Ob PTc:LITE § 3.5 und § 3.6 anwendet, ist nicht gesagt.
> - **Kostenwirkung:** Größe: 339 Zeilen (≤ 400). Die Bytezahl schätze ich auf etwa 22,7–23,0 k, knapp unter 23 500. Ich konnte sie nicht messen, `check.ps1` prüft die Größe nicht. Vor dem Deploy messen. Mehrarbeit pro Lauf: § 3.5 verlangt für jeden „berührten“ dauerhaften Zustand alle Änderungspfade, das Zustandskreuz prüft „jeden laufenden Betriebszustand“. Das ist kombinatorisch und kostet mehr Lesen und Denken pro Lauf. Die Matrix-Grenze von etwa 12 Zeilen (§ 3.1) konkurriert jetzt mit den Pfad-Zeilen aus § 3.5. Echte Schnittstellen könnten verdrängt werden.
> - **Overfitting:** Keiner der 14 Begriffe der Verbotsliste steht außerhalb von § 10 und § 11 (Grep geprüft; „Undo“ und „Undo/Revision“ standen schon in v1.0). Sinngemäß bilden mehrere Formulierungen aber die Ableitungsfälle fast 1:1 nach: „eigene Bedienoberflächen eingebetteter Fremdkomponenten“ (§ 3.5, J5 Plugin-Fenster); „Geändert-Markierung“ (§ 3.5, Autosave); „Gerät … neu öffnet“ + „Schreiben/Aufzeichnen“ (§ 2.2, I4); „eine statt N Einheiten“ (§ 3.6, I3); „Grenze je Aufruf statt Summe“ (§ 3.6, Pflichtfrage 4, I1); „Kontingent … ohne Reserve für angekündigte Folgearbeit“ (Pflichtfrage 4, I2). Die Kategorien sind allgemein brauchbar, darum kein Blocker. Die Beispiele sollten aber neutraler gewählt oder gestrichen werden. Nach D27 d zählt ein Treffer auf 4J/4I ohnehin nicht als Wirkungsnachweis.
> - **Fehlalarm-Gefahr:** (a) § 3.6 setzt HART, also FAIL, schon dann, wenn der Mechanismus „etwas anderes liefert“. Ist der Mechanismus selbst mehrdeutig, wird aus einer Auslegung ein FAIL, denn Regel 14 in § 9 verbietet die Frage, sobald die Quelle gelesen ist. Vorschlag: HART nur bei eindeutigem Widerspruch, sonst LECK. (b) § 3.5 Satz 3 macht eine Lücke zum LECK, auch wenn eine Entscheidung sie bewusst deckt. Das reibt sich mit IDENTITÄT „Bei Konflikt gilt die Projektregel“. Gemildert wird das, weil LECK kein FAIL ist und ein offener Punkt die Lücke schließt. (c) Die Befundpflicht kann Aufblähung durch Leerlauf-Befunde bringen. § 10 nennt das als Anpassungsbedingung, das Gate dafür ist D31 (0 Fehlalarme).
> - **Konsistenz von Frontmatter, Version, CHANGELOG und `check.ps1`:** in Ordnung. Die Version ist überall 1.1: description „v1.1“, Zeile 8 „1.1.0“, Quick Start, Fußzeile, § 11 und CHANGELOG „## 1.1.0“. `check.ps1` ist ASCII. `[char]0xFC` matcht das „ü“ korrekt, weil die Datei als UTF-8 dekodiert wird. Die neuen `$required`-Einträge entsprechen D29. Die Größengrenze aus D34 ist in `check.ps1` nicht abgesichert. D29 verlangt das nicht. Kleinigkeit: § 10 sagt „IST auf Sonnet bestätigt“, obwohl `4j-ist` v1.0 als Fall rot war (J5 verpasst). „bestätigt (mit einer inhaltlichen Lücke)“ wäre genauer, der Rest der Zeile sagt das schon halb.
> - **Interner Widerspruch zwischen den neuen Regeln:** § 0.5 Regel 6, § 9 Regel 14 und § 3.6 passen zusammen (§ 3.6 ist der Spezialfall HART). Spannung 1: Die Befundpflicht in § 2.3 sagt „nie als bloße Notiz in der Querachsen-Zeile“. Die Ausgabe-Vorlage in § 8 behält aber „Ressourcen : [je Komponente: Budget? · Messbeleg? · …]“. Die Vorlage sollte auf Befund-Verweise umgestellt werden. Spannung 2: Mehrere Regeln setzen LECK für Lücken, die keine Umgehung sind: fehlendes Budget (§ 2.3), ungeprüfter Betriebszustand (§ 2.2), fehlender Weg zum Persistenzauslöser (§ 3.5). Die LECK-Definition in § 4 lautet aber „ein Teilpfad umgeht den Vertrag, der Hauptpfad trägt“. Für das fehlende Budget und den ungeprüften Zustand passt sie nicht. § 4 erweitern oder dort ein Beispiel ergänzen. Die neue Zeile „OFFENE FRAGEN“ in § 8 und „Degradiert“ unter HERKUNFT widersprechen sich nicht.

**Umgang mit den Hinweisen (Claude, nach Empfehlung):** Kein Blocker, darum **keine** Änderung an `agent/ptc.md` in 1D-a-Paket 1 (jede Änderung bräuchte einen zweiten Durchgang und verschöbe die Rot-Bindung; der Wortlaut ist Vorgabe des Detailplans). Ä7 ist vollständig (Version an 5 Stellen, § 11, CHANGELOG) – der Reviewer kannte den Abschnitt nicht. Die Hinweise sind **Kandidaten für die Nachbesserungsrunde (D31)** und für v1.2: Mehrdeutigkeit (a)–(d), HART nur bei eindeutigem Widerspruch in § 3.6, § 4 LECK-Definition erweitern, Beispiele neutraler (Overfitting), § 8-Ressourcenzeile auf Befund-Verweise. Byte-Größe gemessen: 22 613 (< 23 500).

### Paket 4: Positivläufe, D31, Nachbesserung (2026-11-08 17:44–19:25)

- **Erster Versuch 17:44** scheiterte an `You've hit your session limit · resets 7pm` (0 Token, keine Karte, ungültig nach D24). Ergebnisdateien nicht ins Repo übernommen; Neustart 19:03 nach Reset.
- **Bewertung** (frische Opus-Grader, wörtlich in den Ergebnisdateien `evals/results/2026-11-08_*_v1.1*.md`): `4j-ist` Lauf 1: MUSS 6/6, **J12 NICHT verletzt** (LECK-4 „Last von `daw://library` … hat kein Budget“) → Urteil rot. Wiederholung: grün. `4i-plan`: Messung, MUSS 4/5.
- **D31: Regression** (1 Fehlalarm in Lauf 1) → **eine Nachbesserungsrunde.** Ursache: Befundpflicht (Ä3 b) greift auch ohne Muss-Kriterium (Risiko A2 eingetreten). Änderung (allgemein, D27): § 2.3 Befundpflicht nur bei ausdrücklicher Stütze (Muss-Kriterium, Akzeptanztest, Folgephase; Stelle nennt Grenze oder Ressource), sonst höchstens Notiz; § 6 (3) „ausdrücklich“; § 10 Wert angepasst. Ein anfangs zusätzlich geschärfter § 3.6 wurde auf Blocker des zweiten Reviews zurückgesetzt.
- **Review Durchgang 2** (Opus, nur ersten Satz wörtlich): „Urteil: Blocker“ – § 3.6 (HART nur bei eindeutigem Widerspruch) „hat keinen Anlass und wird nicht getestet. Das verstößt gegen D26 und D31“ (§ 3.6 gilt nur PTc:PLAN, J12 war IST; `4i-plan` 0 Fehlalarme). Lösung (a): § 3.6 zurücksetzen – umgesetzt.
- **Review Durchgang 3** (Opus, wörtlich): „Urteil: kein Blocker“ – „Blocker: keine. Die Nachbesserung widerspricht keiner D-Nummer (D6: vier Pflichtfragen bleiben; D26/D31: Nachbesserungsrunde ist durch D31 gedeckt, Version 1.1.0 bleibt, weil sie noch nicht deployt ist; D3, D14, D27 eingehalten). Die Verbotsliste ist in § 2.3 und § 6 nicht berührt … Größe passt (339 Zeilen, 23 044 Byte …). § 3.6 ist gegenüber HEAD unverändert.“ Nicht blockierende Hinweise (nicht umgesetzt, Kandidaten v1.2): J12 mit dem Wortlaut „oder die belastete Ressource“ wahrscheinlich nicht sicher behoben; § 9.14 ausdrücklich „(Ausnahme: Notiz nach § 2.3)“; „zitiert beide Stellen“ präzisieren; „keine offene Frage“ → „nicht als offene Frage geführt“; § 10 Anpassungsbedingung neu fassen; „harte Grenze gilt als Stütze“.
- **Nachläufe** `4j-ist` `nb` und `nb2` (v1.1 mit Nachbesserung, 23 044 Byte): beide **grün, MUSS 6/6 inkl. J5, 0 NICHT verletzt, 0 Fehlalarme.** `4i-plan` wurde **nicht** erneut gelaufen (Budget D34, Summe ≤ 8 USD; D31 verlangt nur den betroffenen Fall).
- **D31 entschieden: erfüllt** (Regression behoben; J1–J4, J6 und I5 getroffen, 0 NICHT, 0 Fehlalarme in den Nachläufen bzw. `4i-plan`). Deploy zulässig.
- **A1 (Zustandspfad-Regel bringt J5):** grün, **J5 in 4 von 4 v1.1-Läufen getroffen** (v1.0: 0 von 4). Nach D27 d nur Hinweis, kein Wirkungsnachweis. **A2 (Fehlalarme):** in 1 von 4 `4j-ist`-Läufen eingetreten (J12), nach Nachbesserung 0 von 2; Reststreuung bleibt (Review-Hinweis). **A4 (Kosten):** grün, Volllauf 209 551 ohne Cache-Read, Datei +20 % Byte.
- **Streuung:** `4j-ist` v1.1 trifft J4 mit 6, 7, 8, 9 oder 10 von 14 Drifts – die Treffer-Zählung ist stabil, die Zahl der weiteren Befunde nicht.

### Paket 5: Rot-Nachweis (2026-11-08 19:25–19:29)

Läufe auf der Fassung nach Nachbesserung (Datei = Deploy-Stand); Bindung aus `rot-bindung.md` (Commit `2a256f3`, vor dem ersten v1.1-Lauf). Bewertung durch frische Opus-Grader, wörtlich in den Ergebnisdateien.

| Variante | Fall / Modell | gebunden | Positivlauf getroffen? | Ergebnis | Rot? |
|---|---|---|---|---|---|
| `rot-ohne-3-5` | `4j-ist` Sonnet | J5 | ja (4 von 4) | J5 nur **Teiltreffer** (Matrix-Zelle „Plugin-Fenster am Bus vorbei (bewusst)“, kein LECK, keine Korrektur); Kontrolle J1–J4, J6 Treffer, 0 NICHT, 0 Fehlalarme | **rot erbracht** |
| `rot-ohne-befundpflicht` | `4i-plan` Opus | I1, I2, I3 | I2, I3 ja (I1 nur Teiltreffer, nicht gebunden-getroffen) | I2 und I3 nur **Teiltreffer** (Ressourcen-Notiz bzw. offene Frage F2); I1 weiter Teiltreffer; Kontrolle I4, I5 Treffer, I6 Teiltreffer (im Positivlauf Treffer), I7 verpasst (wie Positivlauf) | **rot erbracht** |
| `rot-ohne-plan-ist-meta` | `4j-ist` Sonnet | J3, J4 | ja | J3 (SYNC-4) und J4 (SYNC-2, Muster ≥ 3 der 6 D-Nummern) **weiter Treffer**; J5 in dieser Variante (§ 3.5 vorhanden) sogar Treffer | **nicht rot** |

- **A3 eingetreten:** Der Meta-Schnitt nimmt J3/J4 nicht weg. Erkenntnis: Plan-gegen-Ist ist **emergent** aus Quellen-Bindung, Konsistenz (§ 4) und Prozessregeln (§ 9.8), nicht an § 3.4 gebunden. Kein weiterer Schnitt in 1D-a; `4j-ist` bleibt für J3/J4 ohne Rot-Nachweis (begründet, Rückfall A3). Die 1C-Befunde (`rot-ohne-3-4`, `rot-ohne-2-3`) stützen das.
- **Einschränkung `rot-ohne-befundpflicht`:** Positivlauf auf der Fassung **vor** der Nachbesserung, Rot-Lauf **danach**. Die Nachbesserung verengt die Befundpflicht (macht I2/I3 eher schwächer, nicht stärker); der Rot-Befund (Teiltreffer statt Treffer) ist daher nur eingeschränkt auf das Fehlen des Abschnitts zurückzuführen. Ein neuer Positivlauf `4i-plan` wurde aus Budgetgründen (D34) nicht gemacht. Rot ist erbracht, aber mit diesem Vorbehalt.
- Die Teilschnitte der Variante: der Satz in § 0.5 Regel 6 blieb stehen; trotzdem verfehlte die Variante I2/I3 → der Satz allein trägt sie nicht.

### Paket 6: Deploy und Abschluss (2026-11-08 19:30–19:36)

- `scripts/deploy.ps1` → `check ok`, `deployed: …\.claude\agents\ptc.md`; danach `scripts/check.ps1` ohne `-SkipDeployed` → `check ok` (Hash gleich, T). Dateigröße: 339 Zeilen, 23 044 Byte (D34: ≤ 400 / ≤ 23 500).
- Kosten 1D-a Läufe: 0,61 + 0,64 + 1,15 + 0,60 + 0,59 + 0,55 + 0,59 + 1,08 = **≈ 5,8 USD** (Grenze 8, D34); davon ungültige Läufe wegen Sitzungslimit 0.

## Erkenntnisse (Umsetzung)

- **Wirkung nur auf Ableitungsfällen (D27 d):** J5 in 6 von 6 gültigen v1.1-Läufen getroffen (v1.0: 0 von 4), I2–I4 in `4i-plan` getroffen (I1 weiter Teiltreffer). Das zeigt, dass die Regeln greifen; ob sie auf neuen Plänen wirken, misst erst 1B auf 4K.
- **Rot-Nachweis:** Neue Abschnitte (§ 3.5, Befundpflicht) sind per Konstruktion die einzige Quelle ihrer Treffer → Rot ist erreichbar; Schnitte bekannter Abschnitte (§ 3.4 samt Meta) sind es nicht (A3).
- **Fehlalarm-Gefahr der Befundpflicht (A2):** trat in 1 von 4 `4j-ist`-Läufen auf (J12). Die Nachbesserung („ausdrückliche Stütze“) hielt in 2 von 2 Nachläufen; Reststreuung bleibt, weil der Wortlaut „oder die belastete Ressource“ weit ist (Review-Hinweis).
- **Zählstreuung:** Die Zahl der „weiteren Befunde“ und der gezählten Drifts schwankt je Lauf (J4: 6–11 von 14) bei stabilen MUSS-Treffern.
- **Review-Ablauf:** Eine Zusatzänderung ohne Anlass (§ 3.6) wurde vom Review als Blocker erkannt und zurückgesetzt; der Prozess „Nachbesserung = zweiter Review + betroffener Fall“ hat gewirkt.
- **Vorschläge (nur Liste) für 1B/1D (v1.2):**
  1. Befundpflicht-Wortlaut: „oder die belastete Ressource“ → „Stelle nennt die Last bzw. Komponente oder ihre Grenze“; „Befund zitiert die stützende Stelle und die Stelle der Komponente“.
  2. § 9.14: „(Ausnahme: Notiz nach § 2.3)“; § 10 Anpassungsbedingung neu fassen (z. B. „nur Muss-Kriterien mit Zahl oder Grenze“); „eine im Plan gesetzte harte Grenze gilt als Stütze“.
  3. Review-Hinweise aus Durchgang 1: § 2.2 Zustandskreuz-Auslöser („Plan behandelt den Zustand nicht → LECK mit Testaufgabe“), § 4 LECK-Definition erweitern (fehlendes Budget/ungeprüfter Zustand sind keine „Umgehung“), § 8 Ressourcenzeile auf Befund-Verweise, PTc:LITE und § 3.5/§ 3.6, Matrix-Grenze ≈ 12 Zeilen vs. Pfad-Zeilen aus § 3.5.
  4. Kandidat „Frist verfehlt“ (Yoka, siehe `PHASE_1_PLAN.md` § Offene Punkte).
  5. `4i-plan` mit v1.1-Endfassung einmal neu laufen lassen (Positivreferenz für die Rot-Variante), sobald Budget da ist.
  6. I1 (Summe unter Last / Wartezeit) bleibt Teiltreffer: Pflichtfrage 4 reicht nicht; prüfen, ob die Ressourcen-Tabelle „Last nur über Regler“ als gedeckt wertet.

## Messwerte

| Lauf | Modell | Token Summe | ohne Cache-Read | USD | Dauer | Turns | gültig | MUSS | KANN | NICHT verletzt | Fehlalarme |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Referenz `4j-ist` v1.0 | Sonnet | 372 740 | 103 966 | 0,58 | 188,5 s | 10 | ja | 5/6 (J5 verpasst) | 1/2 | 0 | 0 |
| Referenz `4i-plan` v1.0 | Opus | 289 063 | 108 593 | 1,24 | 276,8 s | 9 | ja | 1/5 (I1–I3 Teiltreffer, I4 verpasst) | 2/7 | 0 | 0 |
| `4j-ist` v1.1 (vor Nachbesserung) | Sonnet | 404 719 | 112 773 | 0,61 | 157,6 s | 10 | ja | 6/6 (**J5 getroffen**) | 1/2 | **1 (J12)** | **1 (J12)** |
| `4j-ist` v1.1 Wiederholung (`wdh`, vor Nachbesserung) | Sonnet | 499 846 | 115 994 | 0,64 | 179,6 s | 11 | ja | 6/6 (J5 getroffen) | 1/2 | 0 | 0 |
| `4i-plan` v1.1 (vor Nachbesserung) | Opus | 242 651 | 96 778 | 1,15 | 281,7 s | 7 | ja | 4/5 (I2, I3, I4, I5 Treffer; I1 Teiltreffer) | 1/7 | 0 | 0 |
| `4j-ist` v1.1 nach Nachbesserung (`nb`) | Sonnet | 234 153 | 106 920 | 0,60 | 185 s | 8 | ja | 6/6 (J5 getroffen) | 1/2 | 0 | 0 |
| `4j-ist` v1.1 nach Nachbesserung (`nb2`) | Sonnet | 400 716 | 110 209 | 0,59 | 152,9 s | 10 | ja | 6/6 (J5 getroffen) | 1/2 | 0 | 0 |
| `4j-ist` rot-ohne-3-5 | Sonnet | 305 657 | 104 636 | 0,55 | 135,4 s | 10 | ja | 5/6 (**J5 Teiltreffer = verfehlt**, J1–J4, J6 Treffer) | 1/2 | 0 | 0 |
| `4j-ist` rot-ohne-plan-ist-meta | Sonnet | 382 191 | 104 313 | 0,59 | 178,9 s | 9 | ja | 5/6 (J3, J4 **weiter Treffer**; J5 Teiltreffer) | 1/2 | 0 | 0 |
| `4i-plan` rot-ohne-befundpflicht | Opus | 240 384 | 90 420 | 1,08 | 264,8 s | 6 | ja | 2/5 (**I2, I3, I1 Teiltreffer**; I4, I5 Treffer) | 0/8 | 0 | 0 |
| **Volllauf v1.1** (`4j-ist` Lauf 1 + `4i-plan`, vor Nachbesserung) | | 647 370 | **209 551** (Ziel ≤ 250 000, D34 erfüllt) | 1,76 | | | | | | | |

## Erkenntnisse

### Planung (2026-11-08)

- **Ursache J5 ist strukturell, nicht Zufall:** Die Lücke steht im Fixture als akzeptierte Erkenntnis mit D-Verweis; v1.0 hat keine Regel, die eine „gewollte" Lücke gegen ein Muss-Ziel zum Befund macht, und die Matrix fragt nur „Weg am Vertrag vorbei?", ohne die Nebenpfade aufzählen zu lassen. Ä1 adressiert beides allgemein.
- **4I-Muster „richtig erkannt, falsch eingestuft":** Drei von vier verfehlten MUSS standen als Notiz oder Frage in der Karte. Die günstigste Änderung ist keine neue Achse, sondern eine Einstufungsregel (Ä3 b, Ä4); die einzige neue Prüfung ist Ä5 (Erfüllbarkeit) und Ä2 (Zustandskreuz).
- **Rot-Nachweis neu gedacht:** Schnitte bekannter Abschnitte scheitern, wenn Befunde redundant getragen werden. Neue Abschnitte sind per Konstruktion die einzige Quelle ihrer neuen Treffer; die vier v1.0-Läufe ohne J5 sind dafür schon ein Vorbefund. Für die alten Plan-gegen-Ist-Erwartungen nimmt der Meta-Schnitt beide bekannten Wege.
- **Grenze der Aussage:** Ein v1.1-Treffer auf J5 oder I1–I4 zeigt nur, dass die Regel greift, nicht dass sie auf neuen Plänen wirkt (D14, D27). Dafür ist 1B da.
- **Nicht in 1D-a:** die 18 „weiteren Befunde" aus `4i-plan` v1.0 und die 10 aus `4j-ist` v1.0 (Einstufung „Offen") werden nicht bewertet; Bewertung erst, wenn ein E-Beleg vorliegt (PROCESS.md).

## Zeiten

| Paket | Inhalt | Schätzung | Start | Ende | Ist | Quelle |
|---|---|---|---|---|---|---|
| Detailplan | dieser Plan | 0,5 h | 2026-11-08 ≈ 15:20 (erste Messung 15:31 bei Branch-Anlage) | 2026-11-08 15:35 | ≈ 0,25 h | Session |
| 1 | v1.1 schreiben, check, Rot D29, Verbotsliste | 0,5 h | 2026-11-08 17:34 | 2026-11-08 17:37 | ≈ 0,1 h | `date` |
| 2 | Review (Opus-Subagent), ggf. zweiter Durchgang | 0,25–0,5 h | 2026-11-08 17:37 | 2026-11-08 17:41 | ≈ 0,1 h (Subagent 128 s, 119 395 Token) | `date`, Subagent-Meldung |
| 3 | `run.ps1`, Varianten, Rot-Bindung | 0,5 h | 2026-11-08 17:41 | 2026-11-08 17:47 | ≈ 0,1 h | `date` |
| 4 | Positivläufe (3, Hintergrund), Bewertung, Nachbesserung (2 Reviews, 2 Nachläufe) | 0,5 h (+0,75 h) | 2026-11-08 17:44 | 2026-11-08 19:25 | ≈ 1,7 h brutto, davon ≈ 1,1 h Wartezeit auf Sitzungslimit | `date` |
| 5 | Rot-Läufe (3), Bewertung | 0,5 h | 2026-11-08 19:25 | 2026-11-08 19:29 | ≈ 0,1 h (3 Läufe parallel, mit Paket-4-Dokumentation überlappt) | `date` |
| 6 | Deploy, Plan, Merge, Tag | 0,25 h | 2026-11-08 19:30 | 2026-11-08 19:36 | ≈ 0,1 h | `date` |
| **Summe Umsetzung** | Paket 1–6 | **≈ 2,5–3 h** (Nachbesserung + 0,75 h) | | | | |
