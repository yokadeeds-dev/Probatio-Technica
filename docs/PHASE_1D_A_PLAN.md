# Unterphase 1D-a „v1.1 aus 1C" – Detailplan

Status: **Detailplan fertig, Umsetzung offen** (2026-11-08) · Pakete 1–6 ohne Yoka · Grundlage: [PHASE_1_PLAN.md](PHASE_1_PLAN.md) D1–D14, D25 · [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md) D15–D24 und § Erkenntnisse · [PROCESS.md](PROCESS.md) (Reviews, Testregel)

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

- [ ] Ä1–Ä7 in `agent/ptc.md` per Edit-Tool (UTF-8 ohne BOM, LF), `CHANGELOG.md`.
- [ ] `scripts/check.ps1`: zwei Einträge in `$required` (D29), ASCII.
- [ ] `powershell -File scripts\check.ps1 -SkipDeployed` → `check ok`.
- [ ] Rot-Nachweis D29: Kopie von `agent/ptc.md` im Scratchpad ohne `### 3.5 Zustandspfade` → `check.ps1 -AgentPath <kopie> -SkipDeployed` meldet `required section missing: ### 3.5 Zustandspfade`, Exit 1.
- [ ] Größe nach D34 (≤ 400 Zeilen, ≤ 23 500 Byte) festhalten.
- [ ] **Verbotsliste (D27):** Grep `Plugin|Fader|reconnect|Aufnahme|OSC|Autosave|Undo-Schritt|28 von|4I|4J|Tracktion|MIDI|Fenster|Geste` (Groß-/Kleinschreibung ignorieren) in `agent/ptc.md` → Treffer nur in § 10, § 11. Sonst umformulieren.
- [ ] Commit `phase 1D-a: Paket 1 (ptc.md v1.1.0, check.ps1)` erst **nach** Paket 2 (Review vor Commit, D10); bis dahin im Arbeitsbaum.

**Fertig, wenn:** check grün, Rot-Nachweis D29 erbracht, Verbotsliste leer außerhalb § 10/§ 11 (T).

### Paket 2: Review

**Modell: Opus 5.5, Effort medium** (Subagent, frischer Kontext, nur Read/Grep/Glob, D10)

- [ ] `git add -N .`, dann vollständiger `git diff HEAD` (enthält `agent/ptc.md`, `CHANGELOG.md`, `scripts/check.ps1`).
- [ ] Subagent erhält: Aufgabe („Kernänderung PTc v1.0.0 → v1.1.0 prüfen"), den Diff, D1–D14, D25 aus `PHASE_1_PLAN.md`, D26–D29 aus diesem Plan, `docs/PROCESS.md` § Reviews, die 1C-Ergebnisse `evals/results/2026-11-08_4j-ist_v1.0.md` und `…_4i-plan_v1.0.md` (Begründung der Änderung). **Nicht** § „Änderungen an `agent/ptc.md`" und die Risiko-Zeilen dieses Plans (Begründungen des Implementierers, PROCESS.md).
- [ ] Prüfpunkte laut PROCESS.md plus ausdrücklich: Overfitting mit Verbotsliste (D27), Widerspruch zu D6 (vier Pflichtfragen), Fehlalarm-Gefahr der Befundpflicht, Kostenwirkung (D34).
- [ ] Urteil **wörtlich** unter Fortschritt (diese Datei und `PHASE_1_PLAN.md`). Blocker → beheben, zweiter Durchgang mit neuem Diff; erst „kein Blocker" erlaubt den Commit.
- [ ] Commit Paket 1+2.

**Fertig, wenn:** „kein Blocker" wörtlich eingetragen, Commit (T).

### Paket 3: Eval-Werkzeug und Rot-Bindung

**Modell: Sonnet 5.5, Effort medium**

- [ ] `evals/run.ps1` nach D30: Version per Regex `## Version (\d+)\.(\d+)\.\d+` aus `$AgentPath` (Name `v<major>.<minor>`); Name `<datum>_<fall>_v1.1` bzw. `<datum>_<fall>_<variante>_v1.1`; vorhandene `.md`/`.json`/`.karte.md` → `throw` (außer `-Tag`).
- [ ] Rot-Nachweis D30: `run.ps1 -Case 4j-ist -Variant v -DryRun` meldet den neuen Namen; ein absichtlich vorhandener Dummy `evals/results/<datum>_4j-ist_v1.1.json` (danach löschen) → Abbruch. Falls `-DryRun` den Namen nicht erreicht: Namensbildung vor den DryRun-Ausstieg ziehen.
- [ ] Varianten nach „Rot-Nachweis-Design"; `-DryRun` je Variante: Schnitte gefunden, Überschriften fehlen im Ergebnis, § 3.4 bzw. § 3.5 der jeweils anderen Varianten noch vorhanden (A5).
- [ ] `evals/cases/4j-ist/rot-bindung.md` und `evals/cases/4i-plan/rot-bindung.md` (Format unten); `evals/README.md` ergänzen.
- [ ] Commit `phase 1D-a: Paket 3 (run.ps1, Varianten, Rot-Bindung)` **vor** dem ersten v1.1-Lauf (D32); Hash unter Fortschritt.

**Fertig, wenn:** beide Rot-Nachweise (Abbruch, Schnitte) erbracht, Bindung committet (T).

**Format `rot-bindung.md`:**

```
# Rot-Bindung <fall> (v1.1, PHASE_1D_A_PLAN.md D32)
| Variante | geschnitten | gebundene Erwartungen (expected.md fd2b581) | Rot, wenn | Kontrolle (soll weiter treffen) |
```

### Paket 4: Positivläufe v1.1

**Modell: Sonnet 5.5, Effort medium** (Läufe nach D33, Bewertung Opus-Subagent nach `GRADER.md`)

- [ ] `run.ps1 -Case 4j-ist -Variant v -Model sonnet -MaxBudgetUsd 2`, danach `-Tag wdh` (Wiederholung), und `run.ps1 -Case 4i-plan -Variant v -Model opus -MaxBudgetUsd 3`; im Hintergrund, parallel möglich.
- [ ] Gültigkeit (D24); je Lauf ein frischer Opus-Grader (nur `expected.md` + `.karte.md`, Auftrag `GRADER.md`), Ergebnis wörtlich in die Ergebnisdatei.
- [ ] D31 prüfen (Regression). Bei Regression: Nachbesserungsrunde (Ä-Wortlaut schärfen, nie fall-spezifisch), Paket 2 erneut, nur den betroffenen Fall erneut (`-Tag nb`).
- [ ] A1, A2, A4 auswerten; Messwerte-Tabelle.

**Fertig, wenn:** drei gültige, bewertete Läufe, D31 entschieden, Messwerte eingetragen (T).

### Paket 5: Rot-Nachweis

**Modell: Sonnet 5.5, Effort medium**

- [ ] Je Variante nach „Rot-Nachweis-Design", **nur** wenn mindestens eine gebundene Erwartung im Positivlauf (Lauf **oder** Wiederholung bei `4j-ist`) Treffer war (D33); sonst Fehlen begründen.
- [ ] Bewertung je Lauf durch frischen Opus-Grader; Rot-Entscheidung nach `rot-bindung.md`; A3 auswerten.

**Fertig, wenn:** je Variante Rot erbracht oder Fehlen begründet (T).

### Paket 6: Deploy und Abschluss

**Modell: Sonnet 5.5, Effort medium**

- [ ] Nur bei D31 erfüllt: `powershell -File scripts\deploy.ps1` → Hash gleich; danach `scripts\check.ps1` **ohne** `-SkipDeployed` grün.
- [ ] Erkenntnisse (Vorschläge für 1B/1D nur als Liste), Messwerte, Zeiten; `PHASE_1_PLAN.md`: Statuszeile (1D-a erledigt, nächstes 1B wartet auf 4K), Unterphasen-Tabelle, Fortschritt, Zeiten.
- [ ] Merge-Commit nach `main` (`phase 1D-a: Merge v1.1`), Tag `phase-1d-a`, Push `main` und Tag (privat, D5).

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

## Messwerte

| Lauf | Modell | Token Summe | ohne Cache-Read | USD | Dauer | Turns | gültig | MUSS | KANN | NICHT verletzt | Fehlalarme |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Referenz `4j-ist` v1.0 | Sonnet | 372 740 | 103 966 | 0,58 | 188,5 s | 10 | ja | 5/6 (J5 verpasst) | 1/2 | 0 | 0 |
| Referenz `4i-plan` v1.0 | Opus | 289 063 | 108 593 | 1,24 | 276,8 s | 9 | ja | 1/5 (I1–I3 Teiltreffer, I4 verpasst) | 2/7 | 0 | 0 |
| `4j-ist` v1.1 | Sonnet | | | | | | | | | | |
| `4j-ist` v1.1 Wiederholung | Sonnet | | | | | | | | | | |
| `4i-plan` v1.1 | Opus | | | | | | | | | | |
| `4j-ist` rot-ohne-3-5 | Sonnet | | | | | | | | | | |
| `4j-ist` rot-ohne-plan-ist-meta | Sonnet | | | | | | | | | | |
| `4i-plan` rot-ohne-befundpflicht | Opus | | | | | | | | | | |
| **Volllauf v1.1** | | | | | | | | | | | |

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
| 1 | v1.1 schreiben, check, Rot D29, Verbotsliste | 0,5 h | | | | |
| 2 | Review (Opus-Subagent), ggf. zweiter Durchgang | 0,25–0,5 h | | | | |
| 3 | `run.ps1`, Varianten, Rot-Bindung | 0,5 h | | | | |
| 4 | Positivläufe (3, Hintergrund), Bewertung | 0,5 h | | | | |
| 5 | Rot-Läufe (bis 3), Bewertung | 0,5 h | | | | |
| 6 | Deploy, Plan, Merge, Tag | 0,25 h | | | | |
| **Summe Umsetzung** | Paket 1–6 | **≈ 2,5–3 h** (Nachbesserung + 0,75 h) | | | | |
