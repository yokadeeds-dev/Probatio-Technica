# Probatio Technica (PTc) – Einstieg für jede Session

Antworten auf Deutsch, knapp, Aktion zuerst. Prozess und Abnahme: `docs/PROCESS.md`.
Stand: einzige Quelle sind Statuszeile und § Fortschritt in `docs/PHASE_1_PLAN.md`.

## Was das ist

PTc ist ein nur lesendes Prüfwerkzeug (Claude-Code-Subagent) für Software-Pläne und halb umgesetzte Unterphasen: Ebenen von der Operation bis zum Prozess, Schnittstellen-Matrix, Querachsen (Threads, Lebenszyklus, Ressourcen, Fehlerarten), Plan gegen Ist, PASS/FAIL mit Korrekturliste, **kein Score**. Abgeleitet aus MiMaMa v1.1, eigenständig, **kein Mitglied der Probatio-Familie** (D1). Erster Einsatzort: Yoka-DAW (`F:\Yoka\Workspace\Yoka-DAW`).

## Dateien

| Pfad | Inhalt |
|---|---|
| `agent/ptc.md` | maßgebliche Fassung des Agenten; Anleitung und Spezifikation zugleich (D4) |
| `scripts/check.ps1` | statische Prüfung: Frontmatter, Pflichtabschnitte, Version, CHANGELOG, BOM/CRLF, Deploy-Stand |
| `scripts/deploy.ps1` | prüft und kopiert nach `~/.claude/agents/ptc.md` |
| `docs/PHASE_1_PLAN.md` | Phasenplan: Statuszeile, D-Nummern, Unterphasen, Fortschritt, Offene Punkte, Zeiten |
| `docs/PROCESS.md` | Belegklassen, Abnahme, Treffer-Bewertung, Review, Testregel, Ablauf |
| `docs/runs/` | Lauf-Protokolle: wörtliche Karte, Modell, Token, Dauer, Auswertung |
| `CHANGELOG.md` | Versionen von `agent/ptc.md` |

## Grundregeln

- `~/.claude/agents/ptc.md` nie direkt bearbeiten. Nur `agent/ptc.md` ändern → `scripts/check.ps1` → Review → `scripts/deploy.ps1` (D4, D10).
- Jede Änderung an `agent/ptc.md` oder `scripts/check.ps1` ist eine Kernänderung: Version erhöhen, CHANGELOG, Review-Subagent (D10, `docs/PROCESS.md` § Reviews).
- Skripte nur ASCII (PowerShell 5.1 liest UTF-8 ohne BOM als ANSI). Alle Dateien UTF-8 ohne BOM, LF (`.gitattributes`). Code nur per Edit-Tool.
- Das Repo liegt auf exFAT: `safe.directory` ist global gesetzt.
- Ausführung nur lokal, keine Cloud-Sessions (D11). GitHub: `yokadeeds-dev/Probatio-Technica`, privat (D5; Stand Remote: siehe Plan § Offene Punkte).
- Änderungen an Fremd-Repos (z. B. Yoka-DAW) macht nur deren Worker-Session; dieses Repo übernimmt Lauf-Protokolle und Auswertungen (D13).

## Arbeitsweise

Nach dem Arbeitskonzept der Yoka-DAW (Claude Doc „Arbeitskonzept Yoka-DAW“: https://claude.ai/artifact/4bbMRSgBoBDrmj8Hj9NBa4), hier verbindlich in Kurzform:

- Yoka führt wie ein Firmenchef: Abnahme nur am Phasenende und bei Handarbeit. Claude zieht Unterphasen ohne Einzelfreigabe durch.
- G4-Fragen entscheidet Claude nach eigener Empfehlung und trägt sie als „nach Empfehlung" mit Begründung im Plan ein; Yoka kann umentscheiden. Widerspricht eine neue Anweisung einer D-Nummer, das anzeigen statt stumm folgen.
- Detailplan einer Unterphase: eigene Session, Opus, Effort medium. Umsetzung einer Unterphase: eine Session, Sonnet, Effort medium. Auswertungen von Läufen: Opus (D12).
- Was in Plan, Entscheidungen oder Memory steht, nicht erneut fragen. Yoka nie zum Lesen, Suchen oder Kopieren auffordern.
- Jeder Unterphasen-Commit pflegt den Plan im selben Commit (Statuszeile, Fortschritt, Zeiten). Kein Arbeitsstand außerhalb des Repos.
- Arbeitsbranch je Unterphase `phase-1x-<thema>`, Commits `phase 1X: …`, nach der letzten Aufgabe Merge-Commit nach `main` und Tag `phase-1X` durch Claude.
- Token sparen: nur benötigte Abschnitte lesen; Lauf-Protokolle nur bei Bedarf.
