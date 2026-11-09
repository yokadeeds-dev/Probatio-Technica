# Phase 1 „Nachweis" – Plan

**Status 2026-11-09:** 1A „Fundament" abgeschlossen (Tag `phase-1a`, gepusht nach `yokadeeds-dev/Probatio-Technica`, privat). 1B „Vorhersagetest 4K" läuft (siehe Ende dieser Zeile). 1C „Eval-Set" abgeschlossen (Tag `phase-1c`, [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md)): Eval-Set läuft ohne Dialog; v1.0 ist auf `4j-ist` rot (MUSS J5 stabil verpasst), `4i-plan` ist Messung (1/5 MUSS, 3 Teiltreffer); Rot-Nachweis in beiden Fällen nicht erbracht (Schnitte zu schwach, Begründung dort). Änderungsvorschläge für 1D stehen im Detailplan. **1D-a** (v1.1 aus 1C, vor 1B, D25): Detailplan fertig ([PHASE_1D_A_PLAN.md](PHASE_1D_A_PLAN.md), D26–D34, Pakete 1–6, ≈ 2,5–3 h). **1D-a erledigt** (Tag `phase-1d-a`, 2026-11-08): `agent/ptc.md` **v1.1.0 deployt** (339 Zeilen, 23 044 Byte); Review-Urteile wörtlich in [PHASE_1D_A_PLAN.md](PHASE_1D_A_PLAN.md) § Fortschritt. Eval v1.1: `4j-ist` J5 in 6 von 6 gültigen Läufen getroffen (v1.0: 0 von 4), 1 Fehlalarm (J12) im ersten Lauf, darum eine Nachbesserung (Befundpflicht auf ausdrückliche Stütze), danach 2 von 2 grün; `4i-plan` 4/5 MUSS. Rot-Nachweis erbracht für `rot-ohne-3-5` und `rot-ohne-befundpflicht`, nicht für den Meta-Schnitt (A3). Wirkung auf neue Pläne offen bis 1B. **1B Paket 1 erledigt** (2026-11-09): PTc v1.1.0 lief am 2026-11-08 23:47 als `PTc:PLAN` auf den unkommittierten 4K-Detailplan (Opus, 168 504 Token, 425 s): FAIL mit 1 HART, 17 Korrekturen, alle von der 4K-Session übernommen ([Lauf-Protokoll](runs/2026-11-08_yoka-daw_4k_ptc-plan.md)). **Nächstes:** 1B Paket 2 (Treffer-Bewertung, Opus), sobald die 4K-Umsetzung vor der Abnahme steht. Keine Aktion von Yoka nötig.

## Ziel

Belegen, dass PTc **über Tests und Review hinaus** Befunde liefert – zu vertretbaren Kosten – und das Werkzeug anhand echter Läufe auf v1.1 bringen. Phase 1 endet mit Yokas Abnahme einer Bilanz (Treffer, Fehlalarme, Verpasst, Token, Dauer) und der Entscheidung über Phase 2.

**Muss:** ein echter Vorhersagetest (1B) mit Auswertung · ein reproduzierbares Eval-Set mit Rot-Nachweis (1C) · eine Kostenbilanz (1D).
**Nicht in Phase 1:** Einsatz in einem zweiten Projekt, Eintrag in die `PROCESS.md` der Yoka-DAW, automatische Ausführung in CI.

## Unterphasen

| Unterphase | Inhalt | Auslöser / Abhängigkeit | Modell | Status |
|---|---|---|---|---|
| **1A** Fundament | Repo, maßgebliche Agent-Datei, Check und Deploy, Prozess, Plan, Lauf-Archiv 4J | – | Opus | erledigt 2026-11-08 |
| **1B** Vorhersagetest 4K | `PTc:PLAN` auf den 4K-Detailplan vor der Umsetzung; nach 4K Auswertung gegen die 4K-Erkenntnisse | 4K-Detailplan der Yoka-DAW | Lauf Opus, Protokoll Sonnet, Auswertung Opus | wartet |
| **1C** Eval-Set | eingefrorene Fixtures mit bekannten Befunden, Erwartungsdateien, Ausführungsweg, Rot-Nachweis mit verstümmelter Fassung | keine (parallel zu 1B möglich) | Detailplan Opus, Umsetzung Sonnet | erledigt 2026-11-08 (Tag `phase-1c`, [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md)); Ergebnis rot auf 4J, Rot-Nachweis offen für 1D |
| **1D-a** v1.1 aus 1C | Änderungen aus den 1C-Erkenntnissen in `agent/ptc.md` (v1.1), stärkere Rot-Schnitte, Review, Eval-Volllauf, Deploy; **vor** 1B (D25) | nach 1C | Detailplan Opus, Umsetzung Sonnet | erledigt 2026-11-08 (Tag `phase-1d-a`, [PHASE_1D_A_PLAN.md](PHASE_1D_A_PLAN.md)); v1.1.0 deployt |
| **1D** IST-Lauf und Bilanz | `PTc:IST` vor der 4K-Abnahme; Kostenbilanz; Änderungen aus 1B als v1.2 mit Review | nach 1B, 1D-a; 4K vor Abnahme | Lauf Sonnet, Bilanz Opus | offen |
| **Abnahme Phase 1** | Bilanz an Yoka, Entscheidung Phase 2 | nach 1D | – | offen |

## Entscheidungen (D1–D14)

| # | Thema | Entscheidung | Quelle / Begründung |
|---|---|---|---|
| D1 | Rolle | Eigenständiges Werkzeug, **kein** Mitglied der Probatio-Familie; Gems, Kanon und ESG-Einreichung bleiben unberührt. Nur lesend (`tools: Read, Grep, Glob`) | Yoka 2026-11-08 („nach Empfehlung"); Modul-Liste der Gems ist fest eingetragen |
| D2 | Name | „Probatio Technica", Handle **PTc** | Yoka 2026-11-08; PT = Probatio Temporalis |
| D3 | Ausgabe | PASS/FAIL plus Korrekturliste, **kein Score**, keine Durchschnitte | Yoka 2026-11-08; bei Software entscheiden Tests und Belege |
| D4 | Maßgebliche Fassung | `agent/ptc.md` im Repo ist maßgeblich; `~/.claude/agents/ptc.md` ist eine Kopie, die nur `scripts/deploy.ps1` schreibt. `scripts/check.ps1` meldet Abweichungen. Die Agent-Datei ist Anleitung und Spec zugleich | Yoka 2026-11-08 („eigenes Repo"); eine Quelle statt zwei, `agents/` lädt jede `.md` als Agent |
| D5 | Repo | `F:\Yoka\Workspace\Probatio-Technica`, GitHub `yokadeeds-dev/Probatio-Technica` **privat** | nach Empfehlung: Ort neben Yoka-DAW, privat wie Yoka-DAW |
| D6 | Ressourcen-Achse | Querachse über alle Ebenen: CPU, RAM, Platte (Platz und I/O), Thread-Zeit, Latenz, Kontingente; vier Pflichtfragen (Budget, Messbeleg, Wachstum/„wer räumt auf", Konkurrenz). PTc misst nicht selbst | Yoka 2026-11-08; 4J hatte keine einzige RAM- oder Plattengrenze |
| D7 | Kostenregeln | höchstens zwei Einsatzpunkte je Unterphase: `PTc:PLAN` nach dem Detailplan (Opus), `PTc:IST` vor der Abnahme (Sonnet); kein festes Modell im Frontmatter; gezielt lesen; Token und Dauer je Lauf in den Plan des geprüften Projekts | Yoka 2026-11-08; 4J-Lauf ≈ 122 000 Token, 4,3 min ≈ ein Review-Subagent |
| D8 | Abschaltkriterium | findet PTc über **drei Unterphasen** keinen Mehrwert gegenüber Tests und Review → auf einen Einsatzpunkt reduzieren oder abschalten | Yoka 2026-11-08 |
| D9 | Belege und Testregel | Belegklassen L/E/T/Y; Eval-Fälle gelten erst mit Rot-Nachweis gegen eine verstümmelte Fassung; Schutzprüfungen in `check.ps1` erst nach einem roten Lauf gegen eine kaputte Datei | nach Empfehlung, Muster Yoka-DAW `PROCESS.md` |
| D10 | Versionierung und Review | SemVer im Kopf der Agent-Datei und in `CHANGELOG.md` (von `check.ps1` geprüft). Jede Änderung an `agent/ptc.md` oder `scripts/check.ps1` ist eine Kernänderung: Review-Subagent (Opus, frischer Kontext, vollständiger Diff), dann Deploy | nach Empfehlung, Muster D292 der Yoka-DAW |
| D11 | Ausführungsort | nur lokal, keine Cloud-Sessions | wie Yoka-DAW D112 |
| D12 | Modelle | Detailpläne und Auswertungen Opus 5.5 / medium; Protokolle, Pflege, Eval-Umsetzung Sonnet 5.5 / medium; Läufe nach D7 | wie Yoka-DAW D161 |
| D13 | Fremd-Projekte | Läufe stößt das geprüfte Projekt in seinem eigenen Plan an; dieses Repo übernimmt Protokoll und Auswertung in `docs/runs/<Datum>_<projekt>_<objekt>_<modus>.md`. Änderungen am Fremd-Repo macht nur dessen Worker-Session | nach Empfehlung; Rollen-Trennung Worker/Auditor |
| D25 | v1.1 vor 1B | Die Änderungen aus 1C werden als Unterphase **1D-a** vor 1B umgesetzt; 1B prüft dann v1.1 auf 4K. 1D behält IST-Lauf, Bilanz und die Änderungen aus 1B (v1.2). Die Vorhersagekraft von v1.0 allein wird nicht gemessen | Yoka 2026-11-08 („A", nach Empfehlung): 4K ist unkontaminiert und misst die Verbesserung auf einem neuen Plan statt nur auf 4J/4I, aus denen sie abgeleitet ist |
| D14 | Kontaminierte Fälle | Der 4J-Lauf (Grundlage von v1.0) ist Regressionsfall, kein Wirkungsnachweis. Wirkung belegen nur Vorhersagetests auf Plänen, die PTc vor der Umsetzung sieht | nach Empfehlung |

## 1A – Fundament (erledigt)

- [x] Repo `F:\Yoka\Workspace\Probatio-Technica` (exFAT → `safe.directory` global), `.gitattributes` (LF), `.gitignore`
- [x] `agent/ptc.md` v1.0.0 aus `~/.claude/agents/ptc.md` übernommen (byte-gleich, ohne BOM, LF)
- [x] `scripts/check.ps1` (Frontmatter, Pflichtabschnitte, Score-Verbot, Version, CHANGELOG, BOM/CRLF, Deploy-Stand) mit Rot-Nachweis
- [x] `scripts/deploy.ps1` (Check, Sicherung nach `.backup/`, Kopie, Hash-Vergleich)
- [x] `CLAUDE.md`, `README.md`, `CHANGELOG.md`, `docs/PROCESS.md`, dieser Plan
- [x] Lauf-Protokoll `docs/runs/2026-11-08_yoka-daw_4j_mimama-full.md` mit Auswertung
- [x] Commit `b278a9d`, Tag `phase-1a` (lokal)
- [x] Privates GitHub-Repo `yokadeeds-dev/Probatio-Technica` angelegt, `main` und Tag `phase-1a` gepusht (2026-11-08, nach Yokas Freigabe „Ja, anlegen"; der erste Versuch war von der automatischen Freigabe gesperrt)

## 1B – Vorhersagetest 4K

**Ort: Lokal** · Auslöser in der Yoka-DAW: Eintrag bei 4K in `docs/PHASE_4_PLAN.md` (Paket 7b, Beschluss Yoka 2026-11-08): nach dem 4K-Detailplan und vor Paket 1 `PTc:PLAN docs/PHASE_4K_PLAN.md`.

- [x] **Paket 1 (nach dem Lauf, Sonnet):** Karte und Kennzahlen (Modell, Token, Dauer) aus den 4K-Erkenntnissen übernehmen → `docs/runs/<Datum>_yoka-daw_4k_ptc-plan.md`. Festhalten, welche Befunde die DAW-Session in den Plan übernommen hat. → erledigt 2026-11-09: [`docs/runs/2026-11-08_yoka-daw_4k_ptc-plan.md`](runs/2026-11-08_yoka-daw_4k_ptc-plan.md); PTc v1.1.0, FAIL (1 HART), 17 Korrekturen, alle übernommen; 168 504 Token, 425 s.
- [ ] **Paket 2 (nach der 4K-Umsetzung, vor der 4K-Abnahme, Opus):** Treffer-Bewertung nach `docs/PROCESS.md`: je Befund Treffer / Fehlalarm / Offen, dazu Verpasst (Probleme aus den 4K-Erkenntnissen und Reviews auf PTc-Ebenen/-Achsen). Mehrwert gegenüber Tests und Review ausweisen.
- [ ] **Paket 3:** Änderungsvorschläge für v1.2 sammeln (nur Liste, Umsetzung in 1D; v1.1 kam aus 1C, D25).

**Fertig, wenn:** Lauf-Protokoll und Auswertung mit Belegen L und E liegen vor.

## 1C – Eval-Set

**Ort: Lokal** · Detailplan als eigene Session (Opus), dann Umsetzung (Sonnet). Detailplan: [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md) (D15–D24, Pakete 1–6, ≈ 3,5 h).

- [x] **Annahme A1 prüfen:** grün 2026-11-08 – `claude -p --agents <json> --agent <name>` läuft ohne Dialog (PHASE_1C_PLAN.md Fakt 1–3, D15).
- [x] **Fixtures:** `evals/fixtures/4j-ist` (Regression, `981425c`) und `4i-plan` (Vorhersage, `589c2f3`), Manifeste mit SHA-256.
- [x] **Erwartungen:** `evals/cases/<fall>/expected.md`, blind von einem Opus-Subagenten, Commit `fd2b581` vor dem ersten Lauf.
- [x] **Rot-Nachweis:** durchgeführt, **nicht erbracht**: `rot-ohne-3-4` und `rot-ohne-2-3` (Rückfall A7 auf `4j-ist`) verfehlen keine der zugehörigen Erwartungen. Fehlen begründet in PHASE_1C_PLAN.md § Erkenntnisse Paket 4–5; Vorschläge für 1D dort.
- [x] **Kosten:** Volllauf 212 559 Token ohne Cache-Read (Ziel ≤ 250 000), 1,82 USD, ≈ 7,8 min.

**Fertig, wenn:** PTc v1.0 erfüllt die Erwartungen des Regressionsfalls, der Rot-Nachweis ist dokumentiert, Kosten je Lauf stehen im Plan. **Stand:** Regressionsfall rot mit benannter Ursache für 1D (J5), Rot-Nachweis nicht erbracht und begründet, Kosten erfüllt.

## 1D – IST-Lauf und Bilanz

- [ ] `PTc:IST` auf den 4K-Plan vor der 4K-Abnahme (Sonnet), Protokoll und Treffer-Bewertung wie 1B.
- [ ] v1.2: Änderungen aus 1B in `agent/ptc.md` (die aus 1C kommen in 1D-a als v1.1, D25), Version und CHANGELOG, Review-Subagent (Urteil wörtlich hier), `check.ps1`, Eval-Set grün, Deploy.
- [ ] Bilanz Phase 1: Tabelle je Lauf (Treffer, Fehlalarme, Verpasst, Mehrwert, Token, Dauer) und Empfehlung für Phase 2.

**Fertig, wenn:** Bilanz mit Belegen L/E/T liegt vor, v1.2 deployt (v1.1 deployt 1D-a).

## Abnahme Phase 1 (Yoka)

Ein kurzer Block: Claude legt die Bilanz vor (eine Tabelle, eine Empfehlung). Yoka entscheidet nur: Phase 2 wie empfohlen / reduziert / Stopp. Belege nach `docs/PROCESS.md` (Y nie allein).

## Phase 2 (Skizze, nicht freigegeben)

Betrieb über weitere Unterphasen der Yoka-DAW bis zum Abschaltkriterium (D8: drei Unterphasen) · Eintrag in die `PROCESS.md` der Yoka-DAW (Steuerdatei, Yokas Ja) · zweites Projekt (Kandidat EVL) · ggf. Projekt-Adapter für fremde Belegklassen · Erwähnung im Arbeitskonzept-Doc.

## Fortschritt

| Datum | Unterphase | Schritt | Ergebnis | Beleg |
|---|---|---|---|---|
| 2026-11-08 | Vorlauf | MiMaMa:FULL auf Yoka-DAW 4J | 6 Treffer verifiziert, 0 Fehlalarme; Folge: Review-Blocker Paket 5 | L, E: `docs/runs/2026-11-08_yoka-daw_4j_mimama-full.md` |
| 2026-11-08 | Vorlauf | PTc v1.0 geschrieben (`~/.claude/agents/ptc.md`) | Entscheidungen D1–D8 nach Empfehlung | Y (Kontext), Agent-Datei |
| 2026-11-08 | 1A | Repo, Check, Deploy, Prozess, Plan, Lauf-Archiv | siehe Zeilen unten | T |
| 2026-11-08 | 1A | `check.ps1` erster Lauf rot auf der korrekten Datei: `String.StartsWith([char]0xFEFF)` ist in .NET Framework kulturabhängig und immer wahr → erstes Zeichen abgeschnitten. Behoben mit Zeichenvergleich | `check ok` | T |
| 2026-11-08 | 1A | Rot-Nachweis `check.ps1` (Kopie im Scratchpad, `-AgentPath`): BOM, CRLF, `model:` im Frontmatter, ohne § 2.3, `Score: 7`, Version 2.0.0 ohne CHANGELOG → 7 FAIL, Exit 1. Abweichende Deploy-Kopie → FAIL, Exit 1. `deploy.ps1` → „already current" | alle Schutzprüfungen einmal rot | T |
| 2026-11-08 | 1D-a | Detailplan `docs/PHASE_1D_A_PLAN.md`: D26–D34 nach Empfehlung, Ä1–Ä7 mit Wortlaut (Zustandspfade, Zustandskreuz, Summe unter Last + Befundpflicht, Frage nur bei fehlender Quelle, Erfüllbarkeit), Overfitting-Verbotsliste, Rot-Nachweis neu (drei Varianten, `rot-bindung.md` vorab), Deploy-Schwelle „keine Regression" (D31) | Detailplan fertig, Umsetzung offen | T (Fakten 1–8 im Detailplan) |
| 2026-11-08 | 1D-a | Umsetzung Pakete 1–6: v1.1.0 (Ä1–Ä7), Review 3 Durchgänge (kein Blocker / Blocker § 3.6 / kein Blocker), Positiv- und Nachläufe, Rot-Nachweis 2 von 3 Varianten, Deploy, Merge, Tag `phase-1d-a` | v1.1.0 deployt; J5 stabil getroffen; Meta-Schnitt nicht rot (A3) | T, L: `evals/results/2026-11-08_*_v1.1*.md`, PHASE_1D_A_PLAN.md |
| 2026-11-08 | 1D-a | Entscheidung D25: v1.1 aus 1C vor 1B als Unterphase 1D-a; Detailplan als eigene Session (Opus) | Reihenfolge geändert | Y |
| 2026-11-08 | 1C | Pakete 4–5: Positivläufe v1.0 (`4j-ist` + Wiederholung, `4i-plan`), Rot-Läufe `rot-ohne-3-4` und `rot-ohne-2-3`, Bewertung durch Opus-Grader | `4j-ist` rot (J5 stabil verpasst), `4i-plan` Messung 1/5 MUSS, Rot-Nachweis nicht erbracht | T: `evals/results/2026-11-08_*.md` |
| 2026-11-08 | 1C | Paket 6: Erkenntnisse für 1D, Plan, Merge, Tag `phase-1c` | 1C abgeschlossen | T |
| 2026-11-08 | 1C | Paket 3: Erwartungen blind (Opus-Subagent), Commit `fd2b581` vor dem ersten Eval-Lauf | T |
| 2026-11-08 | 1C | Pakete 1–2: `evals/run.ps1`, Varianten, README, Fixtures `4j-ist`/`4i-plan`, Prompts; Rot-Nachweis Schnitt und D24, Trockenlauf Haiku gültig | T: `evals/results/2026-11-08_4i-plan_v1.0_trocken-*.md` |
| 2026-11-08 | 1C | Detailplan `docs/PHASE_1C_PLAN.md`: D15–D24, Fälle `4j-ist` (Regression) und `4i-plan` (Vorhersage, Detailplan-Commit `589c2f3`), A1 grün (`claude -p --agent`, `--agents <json>` für Rot-Varianten) | Detailplan fertig, Umsetzung offen | T (A1-Läufe, Fakt 1–2 im Detailplan) |
| 2026-11-09 | 1B | Paket 1: Lauf-Protokoll `PTc:PLAN` auf Yoka-DAW 4K (v1.1.0, Opus, 2026-11-08 23:47–23:54) übernommen, Karte wörtlich aus `58f8edd`; vorläufige E-Belege aus 4K-Paket 1 (K7, K8, K13, K15 umgesetzt) | FAIL, 1 HART, 17 Korrekturen, 17/17 übernommen; 168 504 Token (Selbstschätzung 95–110 k zu niedrig) | L, E: `docs/runs/2026-11-08_yoka-daw_4k_ptc-plan.md` |

## Offene Punkte

- **1B Paket 2 hängt an der Yoka-DAW:** Treffer-Bewertung erst, wenn die 4K-Umsetzung vor der Abnahme steht (Stand 2026-11-09 06:45: 4K-Pakete 1–3 committet, PR `yokadeeds-dev/Yoka-DAW#32`). Kosten-Hinweis für 1D: Token nur aus der Agent-Abrechnung, nicht aus der Selbstschätzung.
- **E-Beleg nachtragen:** Ergebnis von Yoka-DAW-Paket 7b (Blocker behoben, zweites Review) in das 4J-Lauf-Protokoll übernehmen.
- **Arbeitskonzept-Doc** nennt PTc noch nicht (§ Werkzeuge) → nach 1B.
- **Yoka-DAW `PROCESS.md`:** PTc-Eintrag erst in Phase 2 (Steuerdatei, Yokas Ja).
- **Kandidat v1.2 (1D), Fehlerart „Frist verfehlt" (Yoka 2026-11-08, nicht in v1.1):** Eine asynchrone Vorbereitung läuft gegen einen festen Zeitpunkt (Beat, Puffer, Frame, Timeout, Termin). Prüffragen: Was passiert, wenn die Vorbereitung die Frist reißt? Ist der ungünstigste Fall (kalter Cache, Auslöser kurz vor der Frist) behandelt? Gibt es einen Test, der die Frist künstlich reißt? Auslöser war ein Review-Blocker aus der Yoka-DAW: Der Graph-Aufbau dauert länger als die Zeit bis zum nächsten Beat, dadurch startet der Transport mitten im Clip, es gibt einen Sprung und Priming im Audio-Thread. Lösung dort: Clip mit einem Beat Vorlauf, Transport um ganze Beats zurück, Test-Haken lässt während `start()` Audiozeit vergehen. v1.0 deckt das nur über die Stichworte „Wettlauf" (§ 2.4) und „blockierendes I/O auf zeitkritischen Threads" (§ 2.1) ab, voraussichtlich nur als offene Frage. Die Regel domänenneutral formulieren, Echtzeit-Audio als eines von mehreren Beispielen (keine DAW-Sonderfassung). Eval-Fall nur, wenn der Plan-Stand von vor dem Review-Befund noch existiert.

## Zeiten

| Unterphase / Paket | Inhalt | Schätzung | Start | Ende | Ist | Quelle |
|---|---|---|---|---|---|---|
| 1A | Fundament | 0,5–1 h | 2026-11-08 ≈ 11:45 (erste Messung 11:48 nach Repo-Anlage) | 2026-11-08 11:54 | ≈ 0,15 h Wanduhr (Inhalte aus der laufenden Session übernommen) | Session |
| 1B Paket 1 | Protokoll 4K | 0,25 h | 2026-11-09 06:42 (erste Messung) | 2026-11-09 06:43 (letzte Messung vor Commit) | < 0,25 h (Shell-Uhr ungenau, Schritte dazwischen ohne Messung) | Session |
| 1B Paket 2 | Auswertung 4K | 0,5–1 h | | | | |
| 1C Detailplan | PHASE_1C_PLAN.md, A1 geprüft | 0,5–0,75 h | 2026-11-08 ≈ 13:55 | 2026-11-08 14:20 | ≈ 0,4 h | Session |
| 1C Umsetzung | Pakete 1–6 laut PHASE_1C_PLAN.md | ≈ 3,5 h | 2026-11-08 14:42 | 2026-11-08 15:35 | ≈ 0,9 h Wanduhr (Pakete 4 und 5 überlappten) | Session |
| 1D-a Detailplan | PHASE_1D_A_PLAN.md | 0,5 h | 2026-11-08 ≈ 15:20 (erste Messung 15:31) | 2026-11-08 15:35 | ≈ 0,25 h | Session |
| 1D-a Umsetzung | Pakete 1–6 laut PHASE_1D_A_PLAN.md | ≈ 2,5–3 h | 2026-11-08 17:34 | 2026-11-08 19:36 | ≈ 2,0 h Wanduhr inkl. ≈ 1,1 h Wartezeit auf das Sitzungslimit (netto ≈ 1 h; Nachbesserung + 2 Review-Durchgänge) | `date`, Session |
| 1D | IST-Lauf, v1.2, Bilanz | 1,5–2 h | | | | |
