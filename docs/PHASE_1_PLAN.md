# Phase 1 „Nachweis" – Plan

**Status 2026-11-11:** 1A „Fundament" abgeschlossen (Tag `phase-1a`, gepusht nach `yokadeeds-dev/Probatio-Technica`, privat). 1B „Vorhersagetest 4K": Lauf erledigt, Protokoll erledigt, Auswertung nach 4K (siehe Ende dieser Zeile). D35 (Querschnitt-IST je Phase) eingetragen. 1C „Eval-Set" abgeschlossen (Tag `phase-1c`, [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md)): Eval-Set läuft ohne Dialog; v1.0 ist auf `4j-ist` rot (MUSS J5 stabil verpasst), `4i-plan` ist Messung (1/5 MUSS, 3 Teiltreffer); Rot-Nachweis in beiden Fällen nicht erbracht (Schnitte zu schwach, Begründung dort). Änderungsvorschläge für 1D stehen im Detailplan. **1D-a** (v1.1 aus 1C, vor 1B, D25): Detailplan fertig ([PHASE_1D_A_PLAN.md](PHASE_1D_A_PLAN.md), D26–D34, Pakete 1–6, ≈ 2,5–3 h). **1D-a erledigt** (Tag `phase-1d-a`, 2026-11-08): `agent/ptc.md` **v1.1.0 deployt** (339 Zeilen, 23 044 Byte); Review-Urteile wörtlich in [PHASE_1D_A_PLAN.md](PHASE_1D_A_PLAN.md) § Fortschritt. Eval v1.1: `4j-ist` J5 in 6 von 6 gültigen Läufen getroffen (v1.0: 0 von 4), 1 Fehlalarm (J12) im ersten Lauf, darum eine Nachbesserung (Befundpflicht auf ausdrückliche Stütze), danach 2 von 2 grün; `4i-plan` 4/5 MUSS. Rot-Nachweis erbracht für `rot-ohne-3-5` und `rot-ohne-befundpflicht`, nicht für den Meta-Schnitt (A3). Wirkung auf neue Pläne offen bis 1B. **1B Paket 1 erledigt** (2026-11-09): PTc v1.1.0 lief am 2026-11-08 23:47 als `PTc:PLAN` auf den unkommittierten 4K-Detailplan (Opus, 168 504 Token, 425 s): FAIL mit 1 HART, 17 Korrekturen, alle von der 4K-Session übernommen ([Lauf-Protokoll](runs/2026-11-08_yoka-daw_4k_ptc-plan.md)). **1B Nachholen (2026-11-11, Yoka „Ja, starten“):** Läufe 5A und 5B protokolliert ([5A](runs/2026-11-10_yoka-daw_5a_ptc-plan.md): FAIL 2 HART, 18 K, 216 165 Token; [5B](runs/2026-11-11_yoka-daw_5b_ptc-plan.md): FAIL 2 HART, 10 K, 163 689 Token). Plan umgebaut (D37–D39): 1B = drei Vorhersagefälle 4K/5A/5B, endet mit der 5B-Bewertung; 1D-IST vor der 5B-Abnahme; IST vor der 4K-Abnahme und Querschnitt-IST Phase 4 verpasst (Befund, nicht nachgeholt). Treffer-Bewertung 4K: 11 Treffer, 1 Fehlalarm, 5 Offen, 10 Verpasst, Mehrwert 3; 5A: 10 Treffer, 5 Fehlalarme (beide HART trugen nicht), 4 Offen, 9 Verpasst, Mehrwert 3. D8 nach zwei von drei Fällen: Mehrwert vorhanden, aber Verpasst ≈ Treffer. Auslöser `scripts/pending.ps1` (D39) mit Rot-Nachweis; meldet heute 5B ohne geplanten `PTc:IST` (DAW-Seite). **Nächstes:** 5B-Bewertung nach Tag `phase-5b`; `PTc:IST` vor der 5B-Abnahme braucht einen DAW-Schritt (Offene Punkte); 1B Paket 3 (v1.2-Liste). 1B bleibt offen, kein Merge. Keine Aktion von Yoka nötig.

## Ziel

Belegen, dass PTc **über Tests und Review hinaus** Befunde liefert – zu vertretbaren Kosten – und das Werkzeug anhand echter Läufe auf v1.1 bringen. Phase 1 endet mit Yokas Abnahme einer Bilanz (Treffer, Fehlalarme, Verpasst, Token, Dauer) und der Entscheidung über Phase 2.

**Muss:** ein echter Vorhersagetest (1B) mit Auswertung · ein reproduzierbares Eval-Set mit Rot-Nachweis (1C) · eine Kostenbilanz (1D).
**Nicht in Phase 1:** Einsatz in einem zweiten Projekt, Eintrag in die `PROCESS.md` der Yoka-DAW, automatische Ausführung in CI.

## Unterphasen

| Unterphase | Inhalt | Auslöser / Abhängigkeit | Modell | Status |
|---|---|---|---|---|
| **1A** Fundament | Repo, maßgebliche Agent-Datei, Check und Deploy, Prozess, Plan, Lauf-Archiv 4J | – | Opus | erledigt 2026-11-08 |
| **1B** Vorhersagetests 4K, 5A, 5B (D37) | `PTc:PLAN` auf die Detailpläne 4K, 5A, 5B vor der Umsetzung; je Unterphase nach ihrem Tag Treffer-Bewertung gegen Erkenntnisse, Reviews und Abnahme; Grundlage für D8 | Detailpläne der Yoka-DAW; endet mit der Bewertung 5B | Lauf Opus, Protokoll Sonnet, Auswertung Opus (frischer Subagent) | läuft: 4K, 5A bewertet (Mehrwert je 3); 5B wartet auf Tag `phase-5b` |
| **1C** Eval-Set | eingefrorene Fixtures mit bekannten Befunden, Erwartungsdateien, Ausführungsweg, Rot-Nachweis mit verstümmelter Fassung | keine (parallel zu 1B möglich) | Detailplan Opus, Umsetzung Sonnet | erledigt 2026-11-08 (Tag `phase-1c`, [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md)); Ergebnis rot auf 4J, Rot-Nachweis offen für 1D |
| **1D-a** v1.1 aus 1C | Änderungen aus den 1C-Erkenntnissen in `agent/ptc.md` (v1.1), stärkere Rot-Schnitte, Review, Eval-Volllauf, Deploy; **vor** 1B (D25) | nach 1C | Detailplan Opus, Umsetzung Sonnet | erledigt 2026-11-08 (Tag `phase-1d-a`, [PHASE_1D_A_PLAN.md](PHASE_1D_A_PLAN.md)); v1.1.0 deployt |
| **1D** IST-Lauf und Bilanz | `PTc:IST` vor der **5B-Abnahme** (D38); Kostenbilanz; Änderungen aus 1B als v1.2 mit Review | nach 1D-a; 5B vor Abnahme; Bilanz nach 1B | Lauf Sonnet, Bilanz Opus | offen; IST vor der 4K-Abnahme und Querschnitt-IST Phase 4 verpasst (Befund, D38) |
| **Abnahme Phase 1** | Bilanz an Yoka, Entscheidung Phase 2 | nach 1D | – | offen |

## Entscheidungen (D1–D14, D25–D40)

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
| D35 | Querschnitt-IST auf abgeschlossene Unterphasen | Je Phase ein `PTc:IST` auf den Phasenplan (Yoka-DAW: `docs/PHASE_4_PLAN.md`), nach dem letzten Messpaket und vor dem Doku-Paket; zusätzlich zu D7. Zählt nach D14 nicht als Wirkungsnachweis (Plan ist beim Lauf schon umgesetzt) und nicht für D8; eigene Bilanzzeile in 1D. Modell Sonnet. Andere Projekte erst in Phase 2 | nach Empfehlung (Cloud-Session 2026-11-09): Querschnitt über viele Unterphasen |
| D36 | Selbsttest | Ab 1D bekommt **jeder PTc-Detailplan** vor der Umsetzung ein `PTc:PLAN` mit der jeweils deployten Version (Opus, Effort medium), aufgerufen von der Detailplan-Session nach dem Plan und vor dem Commit; Befunde nach Empfehlung einarbeiten, Karte wörtlich in die Erkenntnisse des Detailplans, Protokoll `docs/runs/<Datum>_ptc_<unterphase>_ptc-plan.md`, Token aus der Agent-Abrechnung. Zählt als **Vorhersagefall außerhalb der DAW-Domäne** (Treffer-Bewertung nach der Umsetzung, eigene Bilanzzeile) und für D8. Rückblickende Läufe auf ältere PTc-Pläne nicht: v1.1 ist aus 1C/1D-a abgeleitet (D14) | Yoka 2026-11-09 („A: Regel ab 1D"); PTc-Repo ist der einzige Kandidat mit Plan vor der Umsetzung und dokumentierten Problemen danach (EVL: keine Vorab-Pläne; ki-studio-mackie: Phase 2) |
| D37 | 1B mit drei Vorhersagefällen | 1B umfasst die `PTc:PLAN`-Läufe auf die Yoka-DAW-Detailpläne **4K, 5A und 5B**; das sind zugleich die drei Unterphasen für D8. Je Fall Protokoll in `docs/runs/`, nach dem Tag der Unterphase Treffer-Bewertung durch einen **frischen Opus-Subagenten** (nur Read/Grep/Glob, ohne PTc-Interna und ohne Erwartung), sein Urteil wörtlich ins Protokoll, die eigene Prüfung daneben. 1B endet mit der Bewertung von 5B. Liegt nur die Einarbeitungsliste der DAW vor (5A, 5B), gilt sie als Karte | nach Empfehlung (Session 2026-11-11, Auftrag Yoka „Ja, starten“): Die DAW lief ohne PTc-Begleitung weiter und hat PTc:PLAN auf 5A und 5B selbst angestoßen; drei unkontaminierte Fälle liegen vor, ein vierter wäre erst nach 5C möglich |
| D38 | IST-Lauf vor der 5B-Abnahme, verpasste Läufe | 1D-Lauf `PTc:IST` vor der **5B-Abnahme** (Sonnet) statt vor der 4K-Abnahme. Verpasst und als Befund geführt: `PTc:IST` vor der 4K-Abnahme (Abnahme 2026-11-10) und Querschnitt-IST Phase 4 (D35). Der Querschnitt-IST wird **nicht nachgeholt** (Token sparen); D35 gilt ab dem Ende von Phase 5 (`PTc:IST docs/PHASE_5_PLAN.md`) | nach Empfehlung: Ursache war der tote Lernkreis (nichts löste die Läufe aus, D39); ein IST auf einen schon abgenommenen Stand hätte keinen Vorhersagewert (D14) |
| D39 | Auslöser `scripts/pending.ps1` | Nur lesendes Skript listet offene PTc-Arbeit: (a) DAW-Pläne mit „### PTc:PLAN/IST“ ohne Protokoll, (b) Protokolle `*_ptc-plan.md`/`*_ptc-ist.md` mit Tag der Unterphase, aber ohne Abschnitt `## Treffer-Bewertung`, (c) laufende Unterphasen (Branch `phase-<n><x>-*` ohne Tag), deren Plan kein `PTc:IST` nennt. **Jede PTc-Session führt es zu Beginn aus** (`CLAUDE.md`). Exit 1 bei offenen Punkten. Rot-Nachweis gegen einen gekürzten `docs/runs`-Stand. Die DAW-Seite braucht eigene Auslöser (Offene Punkte) | nach Empfehlung: Der Lernkreis war tot, weil keine Session die PTc-Aufgaben sah; ein Skript statt Disziplin, wie die Hook-Empfehlung der Anti-Drift-Regel |
| D40 | Ausnahme zweites Projekt: home-inventar | Einmaliger Vergleichslauf `PTc:IST` (Sonnet) gegen ein Code-/Security-Review (Sonnet, gleiches Material) auf die offenen PRs #2 und #1 von `yokadeeds-dev/home-inventar`, im Klon im Scratchpad. Weicht ab von „Nicht in Phase 1: Einsatz in einem zweiten Projekt“. Zählt nicht für D8 und ist kein Vorhersagetest (D14); eigene Bilanzzeile. Befunde gehen nur an die Inventar-Session (D13) | Yoka 2026-11-11 („A und B, dann vergleichen“) |

## 1A – Fundament (erledigt)

- [x] Repo `F:\Yoka\Workspace\Probatio-Technica` (exFAT → `safe.directory` global), `.gitattributes` (LF), `.gitignore`
- [x] `agent/ptc.md` v1.0.0 aus `~/.claude/agents/ptc.md` übernommen (byte-gleich, ohne BOM, LF)
- [x] `scripts/check.ps1` (Frontmatter, Pflichtabschnitte, Score-Verbot, Version, CHANGELOG, BOM/CRLF, Deploy-Stand) mit Rot-Nachweis
- [x] `scripts/deploy.ps1` (Check, Sicherung nach `.backup/`, Kopie, Hash-Vergleich)
- [x] `CLAUDE.md`, `README.md`, `CHANGELOG.md`, `docs/PROCESS.md`, dieser Plan
- [x] Lauf-Protokoll `docs/runs/2026-11-08_yoka-daw_4j_mimama-full.md` mit Auswertung
- [x] Commit `b278a9d`, Tag `phase-1a` (lokal)
- [x] Privates GitHub-Repo `yokadeeds-dev/Probatio-Technica` angelegt, `main` und Tag `phase-1a` gepusht (2026-11-08, nach Yokas Freigabe „Ja, anlegen"; der erste Versuch war von der automatischen Freigabe gesperrt)

## 1B – Vorhersagetests 4K, 5A, 5B (D37)

**Ort: Lokal** · Auslöser in der Yoka-DAW: Eintrag bei 4K in `docs/PHASE_4_PLAN.md` (Paket 7b, Beschluss Yoka 2026-11-08): nach dem 4K-Detailplan und vor Paket 1 `PTc:PLAN docs/PHASE_4K_PLAN.md`. 5A und 5B: von den DAW-Plan-Sessions selbst angestoßen (D114 der DAW), hier erst am 2026-11-11 nachgetragen. Auslöser hier: `scripts/pending.ps1` (D39).

- [x] **Paket 1 (nach dem Lauf, Sonnet):** Karte und Kennzahlen (Modell, Token, Dauer) aus den 4K-Erkenntnissen übernehmen → `docs/runs/<Datum>_yoka-daw_4k_ptc-plan.md`. Festhalten, welche Befunde die DAW-Session in den Plan übernommen hat. → erledigt 2026-11-09: [`docs/runs/2026-11-08_yoka-daw_4k_ptc-plan.md`](runs/2026-11-08_yoka-daw_4k_ptc-plan.md); PTc v1.1.0, FAIL (1 HART), 17 Korrekturen, alle übernommen; 168 504 Token, 425 s.
- [x] **Paket 2 (nach der 4K-Umsetzung, Opus):** → erledigt 2026-11-11 nach dem Tag `phase-4k` (Opus-Subagent, D37): 11 Treffer, 1 Fehlalarm, 5 Offen, 10 Verpasst (3 schwach), Mehrwert 3 (K1, K2, K4). Ursprünglich: Treffer-Bewertung nach `docs/PROCESS.md`: je Befund Treffer / Fehlalarm / Offen, dazu Verpasst (Probleme aus den 4K-Erkenntnissen und Reviews auf PTc-Ebenen/-Achsen). Mehrwert gegenüber Tests und Review ausweisen.
- **Bewertungsregel 1B:** K1–K17 wurden vor der Umsetzung eingearbeitet. Ein Befund gilt daher als **Treffer**, wenn die 4K-Umsetzung ihn bestätigt (E-Beleg aus den Paket-Erkenntnissen der 4K, z. B. Paket 1 für K7, Paket 2 für K1–K4), nicht erst durch Eintreten des Fehlers.
- [x] **5A, 5B Protokoll** (2026-11-11): [`2026-11-10_yoka-daw_5a_ptc-plan.md`](runs/2026-11-10_yoka-daw_5a_ptc-plan.md), [`2026-11-11_yoka-daw_5b_ptc-plan.md`](runs/2026-11-11_yoka-daw_5b_ptc-plan.md).
- [x] **5A Treffer-Bewertung** (nach Tag `phase-5a`, Opus-Subagent, D37) → erledigt 2026-11-11: 10 Treffer (4 teilweise), 5 Fehlalarme (K1 HART, K2, K13, K15, K17), 4 Offen, 9 Verpasst, Mehrwert 3 (K4, K5, K8). Kandidaten v1.2 im Protokoll.
- [ ] **5B Treffer-Bewertung** nach Tag `phase-5b` (Opus-Subagent, D37); danach 1B fertig.
- [ ] **Paket 3:** Änderungsvorschläge für v1.2 sammeln (nur Liste, Umsetzung in 1D; v1.1 kam aus 1C, D25).

**Fertig, wenn:** Lauf-Protokolle und Auswertungen 4K, 5A, 5B mit Belegen L und E liegen vor.

## 1C – Eval-Set

**Ort: Lokal** · Detailplan als eigene Session (Opus), dann Umsetzung (Sonnet). Detailplan: [PHASE_1C_PLAN.md](PHASE_1C_PLAN.md) (D15–D24, Pakete 1–6, ≈ 3,5 h).

- [x] **Annahme A1 prüfen:** grün 2026-11-08 – `claude -p --agents <json> --agent <name>` läuft ohne Dialog (PHASE_1C_PLAN.md Fakt 1–3, D15).
- [x] **Fixtures:** `evals/fixtures/4j-ist` (Regression, `981425c`) und `4i-plan` (Vorhersage, `589c2f3`), Manifeste mit SHA-256.
- [x] **Erwartungen:** `evals/cases/<fall>/expected.md`, blind von einem Opus-Subagenten, Commit `fd2b581` vor dem ersten Lauf.
- [x] **Rot-Nachweis:** durchgeführt, **nicht erbracht**: `rot-ohne-3-4` und `rot-ohne-2-3` (Rückfall A7 auf `4j-ist`) verfehlen keine der zugehörigen Erwartungen. Fehlen begründet in PHASE_1C_PLAN.md § Erkenntnisse Paket 4–5; Vorschläge für 1D dort.
- [x] **Kosten:** Volllauf 212 559 Token ohne Cache-Read (Ziel ≤ 250 000), 1,82 USD, ≈ 7,8 min.

**Fertig, wenn:** PTc v1.0 erfüllt die Erwartungen des Regressionsfalls, der Rot-Nachweis ist dokumentiert, Kosten je Lauf stehen im Plan. **Stand:** Regressionsfall rot mit benannter Ursache für 1D (J5), Rot-Nachweis nicht erbracht und begründet, Kosten erfüllt.

## 1D – IST-Lauf und Bilanz

- [ ] Selbsttest (D36): Detailplan 1D (falls einer geschrieben wird) bzw. der Plan für v1.2 vor der Umsetzung mit `PTc:PLAN` prüfen; nach der Umsetzung Treffer-Bewertung, eigene Bilanzzeile.
- [ ] `PTc:IST` auf den 5B-Plan vor der 5B-Abnahme (Sonnet, D38), Protokoll und Treffer-Bewertung wie 1B. Setzt einen festen Schritt im 5B-Plan der DAW voraus (Offene Punkte).
- [x] ~~`PTc:IST` auf den 4K-Plan vor der 4K-Abnahme~~ → **verpasst** (4K abgenommen 2026-11-10, `222f58d`, ohne IST-Lauf); Befund, nicht nachgeholt (D38).
- [x] ~~Querschnitt-IST Phase 4 (D35)~~ → **verpasst** (Phase 4 abgeschlossen, Tag `phase-4`); nicht nachgeholt, D35 gilt ab dem Ende von Phase 5 (D38).
- [ ] v1.2: Änderungen aus 1B in `agent/ptc.md` (die aus 1C kommen in 1D-a als v1.1, D25), Version und CHANGELOG, Review-Subagent (Urteil wörtlich hier), `check.ps1`, Eval-Set grün, Deploy.
- [ ] Bilanz Phase 1: Tabelle je Lauf (unten) und Empfehlung für Phase 2.

**Bilanz (Stand 2026-11-11):**

| Lauf | Art | D8 | Treffer | Fehlalarm | Offen | Verpasst | Mehrwert | Token | Dauer | Beleg |
|---|---|---|---|---|---|---|---|---|---|---|
| 4J MiMaMa:FULL | Regression (D14) | nein | 6 | 0 | – | – | – | ≈ 122 000 | 4,3 min | L `runs/2026-11-08_yoka-daw_4j_mimama-full.md` |
| 4K PTc:PLAN v1.1 | Vorhersage | ja | 11 | 1 | 5 | 10 (3 schwach) | 3 (K1, K2, K4) | 168 504 | 7,1 min | L `runs/2026-11-08_yoka-daw_4k_ptc-plan.md` |
| 5A PTc:PLAN v1.1 | Vorhersage | ja | 10 (4 teilweise) | 5 (darunter K1 HART) | 4 | 9 (2 schwach) | 3 (K4, K5, K8) | 216 165 | 10,4 min | L `runs/2026-11-10_yoka-daw_5a_ptc-plan.md` |
| 5B PTc:PLAN v1.1 | Vorhersage | ja | nach Tag `phase-5b` | | | | | 163 689 | 6,2 min | L `runs/2026-11-11_yoka-daw_5b_ptc-plan.md` |
| 4K PTc:IST | IST vor Abnahme | – | **verpasst** (D38) | | | | | – | – | – |
| Phase 4 Querschnitt-IST (D35) | Querschnitt | nein | **verpasst**, nicht nachgeholt (D38) | | | | | – | – | – |
| 5B PTc:IST | IST vor Abnahme (D38) | – | offen | | | | | | | |
| Selbsttest 1D (D36) | Vorhersage außerhalb DAW | ja | offen | | | | | | | |
| home-inventar PR #2/#1 PTc:IST (D40) | Vergleich mit Review, kein Vorhersagetest | nein | 11 Themen wie das Review, 3 nur PTc (Backup/Migrationsprobe, Doku-Drift, Messaufgaben), Review 4 nur Review | – | – | – | – | 143 133 (Review 146 424) | 3,6 min (Review 2,9 min) | L `runs/2026-11-11_home-inventar_pr2_ptc-ist.md` |

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
| 2026-11-09 | Phase 1 | Entscheidung D36 Selbsttest: jeder PTc-Detailplan ab 1D vor der Umsetzung mit `PTc:PLAN`; Repo-Prüfung (GitHub-API) ergab PTc-Repo als einzigen Kandidaten mit Plan vor der Umsetzung und dokumentierten Problemen danach | Regel in `PROCESS.md` § Ablauf | Y (Entscheidung), T (API-Abfrage in der Session) |
| 2026-11-09 | 1B | D35 eingetragen (Querschnitt-IST je Phase, zählt nicht für D8); Bewertungsregel 1B (Treffer = durch 4K-Umsetzung bestätigt); 1D-Zeile Querschnitt-IST Phase 4; Status „Lauf erledigt, Protokoll erledigt, Auswertung nach 4K" | Plan nachgeführt | Y (Auftrag) |
| 2026-11-11 | 1B | Läufe `PTc:PLAN` auf Yoka-DAW 5A (`fdaf43c`) und 5B (`a66a1b3`) nachträglich protokolliert; Karten maschinell und wörtlich (Block bis zur nächsten Überschrift), Token aus der Agent-Abrechnung (§ Zeiten der DAW-Pläne). Beide Karten sind Einarbeitungslisten der DAW-Session, nicht die wörtliche Agent-Ausgabe | 5A: FAIL, 2 HART, 18 K + G4, 18/18 übernommen, 216 165 Token, 621 s, 110 Aufrufe · 5B: FAIL, 2 HART, 10 K, 10/10, 163 689 Token, 370 s, 67 Aufrufe | L: `docs/runs/2026-11-10_yoka-daw_5a_ptc-plan.md`, `docs/runs/2026-11-11_yoka-daw_5b_ptc-plan.md` |
| 2026-11-11 | 1B, 1D | D37 (1B mit 4K, 5A, 5B; Bewertung durch frischen Opus-Subagenten), D38 (IST vor der 5B-Abnahme; verpasste Läufe als Befund, Querschnitt-IST Phase 4 nicht nachgeholt), D39 (Auslöser `pending.ps1`) nach Empfehlung; Bilanz-Tabelle in 1D; Offener Punkt „Toter Lernkreis“ mit den nötigen DAW-Schritten | Plan nachgeführt | Y (Auftrag „Ja, starten“), E: Tags `phase-4k`, `phase-4`, `phase-5a` der Yoka-DAW |
| 2026-11-11 | 1B | `scripts/pending.ps1` (D39, nur lesend, ASCII), `CLAUDE.md`: Aufruf zu Beginn jeder Session. Lauf auf den echten Stand (vor den Bewertungen): (b) 4K und 5A ohne Treffer-Bewertung, (c) 5B ohne geplanten `PTc:IST`, Exit 1, 2,9 s. **Rot-Nachweis:** Kopie von `docs/runs` ohne die Protokolle 5A und 5B (`-RunsPath`) → zusätzlich (a) `5a_ptc-plan` und `5b_ptc-plan` gemeldet, Exit 1 | Lücke wird gemeldet; (c) bleibt bis zum DAW-Schritt rot | T (Ausgabe in der Session) |
| 2026-11-11 | 1B | Paket 2: Treffer-Bewertung 4K durch frischen Opus-Subagenten (195 854 Token, 319 s), Urteil wörtlich im Protokoll, Prüfung der Session daneben (Stichproben bestätigt, einverstanden); ersetzt „Vorläufige Belege“. Teuerster Verpasst: 64 statt 256 Samples seit 4B (Plan gegen Ist einer Messvoraussetzung) | 11 Treffer, 1 Fehlalarm, 5 Offen, 10 Verpasst (3 schwach), Mehrwert 3 (K1, K2, K4) | L, E: `docs/runs/2026-11-08_yoka-daw_4k_ptc-plan.md` § Treffer-Bewertung |
| 2026-11-11 | 1B | Treffer-Bewertung 5A durch frischen Opus-Subagenten (143 921 Token, 178 s), Urteil wörtlich im Protokoll, Prüfung der Session daneben (Stichproben bestätigt, ein Zitat zu K8 nicht wörtlich, Einstufung bleibt). Beide HART-Befunde trugen nicht (K1 sachlich falsch: Prämisse D376 nicht am Code geprüft) | 10 Treffer (4 teilweise), 5 Fehlalarme, 4 Offen, 9 Verpasst (2 schwach), Mehrwert 3 (K4, K5, K8) | L, E: `docs/runs/2026-11-10_yoka-daw_5a_ptc-plan.md` § Treffer-Bewertung |
| 2026-11-11 | Phase 1 | D40: `PTc:IST` (Sonnet) und Code-/Security-Review (Sonnet) parallel auf home-inventar PR #2/#1, Vergleich. PTc: beide PRs gemeinsam FAIL (2 HART aus dem Zusammenspiel), PR #2 allein PASS nach K2–K4; Review: PR #2 mergen nach Korrekturen, PR #1 nicht mergen | 11 gemeinsame Themen, 3 nur PTc, 4 nur Review; Kosten gleich (143 133 / 146 424 Token) | L: `docs/runs/2026-11-11_home-inventar_pr2_ptc-ist.md` |

## Offene Punkte

- **Toter Lernkreis (Befund 2026-11-11):** Zwischen 2026-11-09 und 2026-11-11 lief die DAW ohne PTc-Begleitung weiter (4K-Abnahme, 5A komplett, 5B begonnen); IST vor der 4K-Abnahme und Querschnitt-IST Phase 4 verpasst, 5A/5B-Läufe hier nicht protokolliert. Abhilfe hier: `scripts/pending.ps1` (D39). **Auf der DAW-Seite nötig (nur deren Worker-Session, D13):** (1) fester Schritt `PTc:IST docs/PHASE_5B_PLAN.md` (Sonnet) im 5B-Plan vor Paket 6 (Abnahme), Karte wörtlich in die Erkenntnisse; (2) in den Detailplan-Vorlagen bzw. `PROCESS.md` der DAW: je Unterphase `PTc:PLAN` nach dem Detailplan **und** `PTc:IST` vor der Abnahme als Schritte mit Haken, die Karte des Agenten **wörtlich** (nicht nur Einarbeitungsliste) sowie Uhrzeit, Token und Dauer; (3) Querschnitt-IST nach D35 als Schritt im Phase-5-Plan vor dem Doku-Paket. (2) berührt die Steuerdatei der DAW: **Yokas Ja liegt vor** (2026-11-11, „Ja, mit aufnehmen“), damit aus Phase 2 vorgezogen. Auftrag (1)–(3) plus „Karte wörtlich“ am 2026-11-11 als Clipboard-Block an Yoka übergeben, weil die DAW-Sessions auf dem zweiten Konto laufen und von hier nicht erreichbar sind; erledigt, sobald `pending.ps1` (c) für 5B nicht mehr meldet und die DAW-`PROCESS.md` den PTc-Punkt enthält.
- Kosten-Hinweis für 1D: Token nur aus der Agent-Abrechnung, nicht aus der Selbstschätzung.
- **Später (Yoka 2026-11-11 „Später, bitte merken“): Korrekturliste home-inventar übergeben.** Die vereinte Liste aus PTc:IST und Review (Protokoll `runs/2026-11-11_home-inventar_pr2_ptc-ist.md` § „Für die Inventar-Session“) an eine Session im Inventar-Repo geben, vor dem Merge von PR #2. Vorher prüfen, ob PR #1/#2 inzwischen gemergt oder geändert sind (`gh pr view`).
- **Kandidat Phase 2 / v1.2: PTc und Review kombinieren (Frage Yoka 2026-11-11).** Empfehlung: **nicht** in einen Prompt verschmelzen, sondern ein Modus, der beide Linsen parallel startet und die Listen zusammenführt (Union, Dubletten markiert, je Befund Herkunft). Begründung: Der Vergleich D40 zeigte 11 gemeinsame Themen, 3 nur PTc, 4 nur Review; ein gemeinsamer Prompt verdünnt beide Linsen und kostet ähnlich viel wie zwei Läufe; „einer findet alles“ widerlegen schon die Verpasst-Listen 4K (10) und 5A (9), die keine der Linsen fand. Kosten ≈ 2 × 145 000 Token, daher nur für PRs/Unterphasen mit Rollout- oder Sicherheitsanteil. Vor einer Entscheidung: home-inventar als Eval-Fall einfrieren (Erwartung = Union der 18 Themen) und einen zweiten Fall suchen (Overfitting-Regel 1D-a).
- **E-Beleg nachtragen:** Ergebnis von Yoka-DAW-Paket 7b (Blocker behoben, zweites Review) in das 4J-Lauf-Protokoll übernehmen.
- **Arbeitskonzept-Doc** nennt PTc noch nicht (§ Werkzeuge) → nach 1B.
- **Yoka-DAW `PROCESS.md`:** PTc-Eintrag erst in Phase 2 (Steuerdatei, Yokas Ja).
- **Kandidat v1.2 (1D), Fehlerart „Frist verfehlt" (Yoka 2026-11-08, nicht in v1.1):** Eine asynchrone Vorbereitung läuft gegen einen festen Zeitpunkt (Beat, Puffer, Frame, Timeout, Termin). Prüffragen: Was passiert, wenn die Vorbereitung die Frist reißt? Ist der ungünstigste Fall (kalter Cache, Auslöser kurz vor der Frist) behandelt? Gibt es einen Test, der die Frist künstlich reißt? Auslöser war ein Review-Blocker aus der Yoka-DAW: Der Graph-Aufbau dauert länger als die Zeit bis zum nächsten Beat, dadurch startet der Transport mitten im Clip, es gibt einen Sprung und Priming im Audio-Thread. Lösung dort: Clip mit einem Beat Vorlauf, Transport um ganze Beats zurück, Test-Haken lässt während `start()` Audiozeit vergehen. v1.0 deckt das nur über die Stichworte „Wettlauf" (§ 2.4) und „blockierendes I/O auf zeitkritischen Threads" (§ 2.1) ab, voraussichtlich nur als offene Frage. Die Regel domänenneutral formulieren, Echtzeit-Audio als eines von mehreren Beispielen (keine DAW-Sonderfassung). Eval-Fall nur, wenn der Plan-Stand von vor dem Review-Befund noch existiert.

## Zeiten

| Unterphase / Paket | Inhalt | Schätzung | Start | Ende | Ist | Quelle |
|---|---|---|---|---|---|---|
| 1A | Fundament | 0,5–1 h | 2026-11-08 ≈ 11:45 (erste Messung 11:48 nach Repo-Anlage) | 2026-11-08 11:54 | ≈ 0,15 h Wanduhr (Inhalte aus der laufenden Session übernommen) | Session |
| 1B Paket 1 | Protokoll 4K | 0,25 h | 2026-11-09 06:42 (erste Messung) | 2026-11-09 06:43 (letzte Messung vor Commit) | < 0,25 h (Shell-Uhr ungenau, Schritte dazwischen ohne Messung) | Session |
| 1B Paket 2 | Auswertung 4K | 0,5–1 h | 2026-11-11 19:17 | 2026-11-11 19:26 | ≈ 0,15 h Wanduhr (Subagent 319 s parallel) | `date`, Agent |
| 1B Protokolle 5A, 5B | Lauf-Protokolle nachgetragen | 0,25 h | 2026-11-11 19:17 | 2026-11-11 19:20 | ≈ 0,05 h (parallel zu den Bewertungs-Subagenten; Ende im Commit `67a1925` falsch mit 19:40 angegeben) | `date`, Session |
| 1C Detailplan | PHASE_1C_PLAN.md, A1 geprüft | 0,5–0,75 h | 2026-11-08 ≈ 13:55 | 2026-11-08 14:20 | ≈ 0,4 h | Session |
| 1C Umsetzung | Pakete 1–6 laut PHASE_1C_PLAN.md | ≈ 3,5 h | 2026-11-08 14:42 | 2026-11-08 15:35 | ≈ 0,9 h Wanduhr (Pakete 4 und 5 überlappten) | Session |
| 1D-a Detailplan | PHASE_1D_A_PLAN.md | 0,5 h | 2026-11-08 ≈ 15:20 (erste Messung 15:31) | 2026-11-08 15:35 | ≈ 0,25 h | Session |
| 1D-a Umsetzung | Pakete 1–6 laut PHASE_1D_A_PLAN.md | ≈ 2,5–3 h | 2026-11-08 17:34 | 2026-11-08 19:36 | ≈ 2,0 h Wanduhr inkl. ≈ 1,1 h Wartezeit auf das Sitzungslimit (netto ≈ 1 h; Nachbesserung + 2 Review-Durchgänge) | `date`, Session |
| 1B Plan | D37–D39, 1B/1D, Bilanz | 0,25 h | 2026-11-11 19:20 | 2026-11-11 19:23 | ≈ 0,05 h | `date`, Session |
| 1B Auslöser | `pending.ps1`, Rot-Nachweis, `CLAUDE.md` | 0,25 h | 2026-11-11 19:21 | 2026-11-11 19:25 | ≈ 0,07 h | `date`, Session |
| 1B Bewertung 5A | Auswertung 5A | 0,5 h | 2026-11-11 19:19 | 2026-11-11 19:26 | ≈ 0,15 h Wanduhr (Subagent 178 s parallel) | `date`, Agent |
| Vergleich home-inventar (D40) | PTc:IST und Review parallel, Protokoll | 0,5 h | 2026-11-11 19:30 | 2026-11-11 19:36 | ≈ 0,2 h Wanduhr | `date`, Agent |
| 1D | IST-Lauf, v1.2, Bilanz | 1,5–2 h | | | | |
