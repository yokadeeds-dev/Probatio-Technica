# Phase 1 „Nachweis" – Plan

**Status 2026-11-08:** 1A „Fundament" abgeschlossen (Tag `phase-1a`). 1B „Vorhersagetest 4K" wartet auf den 4K-Detailplan der Yoka-DAW (Auslöser dort eingetragen, Paket 7b). 1C kann parallel starten. Keine Aktion von Yoka nötig.

## Ziel

Belegen, dass PTc **über Tests und Review hinaus** Befunde liefert – zu vertretbaren Kosten – und das Werkzeug anhand echter Läufe auf v1.1 bringen. Phase 1 endet mit Yokas Abnahme einer Bilanz (Treffer, Fehlalarme, Verpasst, Token, Dauer) und der Entscheidung über Phase 2.

**Muss:** ein echter Vorhersagetest (1B) mit Auswertung · ein reproduzierbares Eval-Set mit Rot-Nachweis (1C) · eine Kostenbilanz (1D).
**Nicht in Phase 1:** Einsatz in einem zweiten Projekt, Eintrag in die `PROCESS.md` der Yoka-DAW, automatische Ausführung in CI.

## Unterphasen

| Unterphase | Inhalt | Auslöser / Abhängigkeit | Modell | Status |
|---|---|---|---|---|
| **1A** Fundament | Repo, maßgebliche Agent-Datei, Check und Deploy, Prozess, Plan, Lauf-Archiv 4J | – | Opus | erledigt 2026-11-08 |
| **1B** Vorhersagetest 4K | `PTc:PLAN` auf den 4K-Detailplan vor der Umsetzung; nach 4K Auswertung gegen die 4K-Erkenntnisse | 4K-Detailplan der Yoka-DAW | Lauf Opus, Protokoll Sonnet, Auswertung Opus | wartet |
| **1C** Eval-Set | eingefrorene Fixtures mit bekannten Befunden, Erwartungsdateien, Ausführungsweg, Rot-Nachweis mit verstümmelter Fassung | keine (parallel zu 1B möglich) | Detailplan Opus, Umsetzung Sonnet | offen |
| **1D** IST-Lauf und Bilanz | `PTc:IST` vor der 4K-Abnahme; Kostenbilanz; Änderungen aus 1B/1C als v1.1 mit Review | nach 1B, 1C; 4K vor Abnahme | Lauf Sonnet, Bilanz Opus | offen |
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
| D14 | Kontaminierte Fälle | Der 4J-Lauf (Grundlage von v1.0) ist Regressionsfall, kein Wirkungsnachweis. Wirkung belegen nur Vorhersagetests auf Plänen, die PTc vor der Umsetzung sieht | nach Empfehlung |

## 1A – Fundament (erledigt)

- [x] Repo `F:\Yoka\Workspace\Probatio-Technica` (exFAT → `safe.directory` global), `.gitattributes` (LF), `.gitignore`
- [x] `agent/ptc.md` v1.0.0 aus `~/.claude/agents/ptc.md` übernommen (byte-gleich, ohne BOM, LF)
- [x] `scripts/check.ps1` (Frontmatter, Pflichtabschnitte, Score-Verbot, Version, CHANGELOG, BOM/CRLF, Deploy-Stand) mit Rot-Nachweis
- [x] `scripts/deploy.ps1` (Check, Sicherung nach `.backup/`, Kopie, Hash-Vergleich)
- [x] `CLAUDE.md`, `README.md`, `CHANGELOG.md`, `docs/PROCESS.md`, dieser Plan
- [x] Lauf-Protokoll `docs/runs/2026-11-08_yoka-daw_4j_mimama-full.md` mit Auswertung
- [x] Commit, privates GitHub-Repo, Push, Tag `phase-1a`

## 1B – Vorhersagetest 4K

**Ort: Lokal** · Auslöser in der Yoka-DAW: Eintrag bei 4K in `docs/PHASE_4_PLAN.md` (Paket 7b, Beschluss Yoka 2026-11-08): nach dem 4K-Detailplan und vor Paket 1 `PTc:PLAN docs/PHASE_4K_PLAN.md`.

- [ ] **Paket 1 (nach dem Lauf, Sonnet):** Karte und Kennzahlen (Modell, Token, Dauer) aus den 4K-Erkenntnissen übernehmen → `docs/runs/<Datum>_yoka-daw_4k_ptc-plan.md`. Festhalten, welche Befunde die DAW-Session in den Plan übernommen hat.
- [ ] **Paket 2 (nach der 4K-Umsetzung, vor der 4K-Abnahme, Opus):** Treffer-Bewertung nach `docs/PROCESS.md`: je Befund Treffer / Fehlalarm / Offen, dazu Verpasst (Probleme aus den 4K-Erkenntnissen und Reviews auf PTc-Ebenen/-Achsen). Mehrwert gegenüber Tests und Review ausweisen.
- [ ] **Paket 3:** Änderungsvorschläge für v1.1 sammeln (nur Liste, Umsetzung in 1D).

**Fertig, wenn:** Lauf-Protokoll und Auswertung mit Belegen L und E liegen vor.

## 1C – Eval-Set

**Ort: Lokal** · Detailplan als eigene Session (Opus), dann Umsetzung (Sonnet).

- [ ] **Annahme A1 prüfen:** Lässt sich PTc ohne Dialog ausführen (z. B. `claude -p` mit Agent-Auswahl)? Wenn nein: Eval-Läufe als Subagent aus einer Session, Ablauf dokumentiert.
- [ ] **Fixtures:** eingefrorene Kopien in `evals/fixtures/` (nur Dokumente, kein Code): (a) `PHASE_4J_PLAN.md` Stand Paket 6 plus die nötigen Ausschnitte aus `PROCESS.md`/`PHASE_4_PLAN.md` – **Regressionsfall** (D14); (b) mindestens ein abgeschlossener Unterphasen-Plan der Yoka-DAW, dessen Probleme erst in der Umsetzung sichtbar wurden – Kandidaten im Detailplan auswählen.
- [ ] **Erwartungen:** je Fixture `expected.md` mit den Befunden, die PTc finden muss (mit Stelle), und Befunden, die es **nicht** melden darf.
- [ ] **Rot-Nachweis:** verstümmelte Fassung (z. B. ohne § 3.4 Plan-gegen-Ist, ohne § 2.3 Ressourcen) verfehlt die zugehörigen Erwartungen.
- [ ] **Kosten:** Token und Dauer je Eval-Lauf; Eval-Set so klein halten, dass ein Volllauf ≤ 2 Läufe ≈ 250 000 Token kostet.

**Fertig, wenn:** PTc v1.0 erfüllt die Erwartungen des Regressionsfalls, der Rot-Nachweis ist dokumentiert, Kosten je Lauf stehen im Plan.

## 1D – IST-Lauf und Bilanz

- [ ] `PTc:IST` auf den 4K-Plan vor der 4K-Abnahme (Sonnet), Protokoll und Treffer-Bewertung wie 1B.
- [ ] v1.1: Änderungen aus 1B/1C in `agent/ptc.md`, Version und CHANGELOG, Review-Subagent (Urteil wörtlich hier), `check.ps1`, Eval-Set grün, Deploy.
- [ ] Bilanz Phase 1: Tabelle je Lauf (Treffer, Fehlalarme, Verpasst, Mehrwert, Token, Dauer) und Empfehlung für Phase 2.

**Fertig, wenn:** Bilanz mit Belegen L/E/T liegt vor, v1.1 deployt.

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

## Offene Punkte

- **1B hängt an der Yoka-DAW:** Der 4K-Auftrag steht erst nach Paket 7b in deren `PHASE_4_PLAN.md`. Prüfen vor 1B: Eintrag vorhanden.
- **E-Beleg nachtragen:** Ergebnis von Yoka-DAW-Paket 7b (Blocker behoben, zweites Review) in das 4J-Lauf-Protokoll übernehmen.
- **Annahme A1** (Ausführung ohne Dialog) ungeprüft → 1C.
- **Arbeitskonzept-Doc** nennt PTc noch nicht (§ Werkzeuge) → nach 1B.
- **Yoka-DAW `PROCESS.md`:** PTc-Eintrag erst in Phase 2 (Steuerdatei, Yokas Ja).

## Zeiten

| Unterphase / Paket | Inhalt | Schätzung | Start | Ende | Ist | Quelle |
|---|---|---|---|---|---|---|
| 1A | Fundament | 0,5–1 h | 2026-11-08 ≈ 11:45 (erste Messung 11:48 nach Repo-Anlage) | 2026-11-08 11:54 | ≈ 0,15 h Wanduhr (Inhalte aus der laufenden Session übernommen) | Session |
| 1B Paket 1 | Protokoll 4K | 0,25 h | | | | |
| 1B Paket 2 | Auswertung 4K | 0,5–1 h | | | | |
| 1C | Eval-Set | 2–3 h | | | | |
| 1D | IST-Lauf, v1.1, Bilanz | 1,5–2 h | | | | |
