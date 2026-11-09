# Prozess und Abnahme

Abgeleitet aus `Yoka-DAW/docs/PROCESS.md` und dem Arbeitskonzept, angepasst auf ein Prüfwerkzeug, das aus Text besteht.

## Belegklassen

| Klasse | Quelle | Gewicht |
|---|---|---|
| **L** | Lauf-Protokoll in `docs/runs/` (wörtliche Karte, Werkzeug-Version, Modell, Token, Dauer, Datum) | Primärnachweis für die Wirkung eines Laufs |
| **E** | Erkenntnisse, Commits oder Reviews des geprüften Projekts, die einen PTc-Befund bestätigen oder widerlegen | Nachweis für Treffer und Fehlalarm |
| **T** | Ausgabe von `scripts/check.ps1` oder eines Eval-Laufs | Nachweis für Form und Regression |
| **Y** | Yokas Meldung im Chat | nur Kontext, kein Prüfnachweis |

## Abnahmeregeln

1. Eine Abnahme braucht mindestens einen Beleg der Klasse **L**, **E** oder **T**.
2. **Y** trägt eine Abnahme nie allein.
3. Jede Abnahme-Zeile nennt Quelle und Datum.
4. „Fertig" heißt: Der Nachweis liegt vor, nicht nur eine plausible Beschreibung.

## Treffer-Bewertung (Vorhersagetests)

Nach der Umsetzung des geprüften Plans wird jeder PTc-Befund eingestuft:

| Einstufung | Bedeutung | Beleg |
|---|---|---|
| **Treffer** | Befund trat ein oder wurde wegen PTc vorher korrigiert | E |
| **Fehlalarm** | Befund erwies sich als falsch oder folgenlos | E |
| **Offen** | nicht entscheidbar | – |
| **Verpasst** | Problem aus den Erkenntnissen, das auf einer PTc-Ebene oder -Achse lag, aber nicht gemeldet wurde | E |

Je Lauf werden festgehalten: Treffer, Fehlalarme, Verpasst, Token, Dauer. **Mehrwert** = Treffer, die weder Tests noch Review des Projekts gefunden haben bzw. gefunden hätten. Der Mehrwert über drei Unterphasen entscheidet über das Abschaltkriterium (D8).

## Reviews

- **Kernänderung** = jede Änderung an `agent/ptc.md` (Inhalt oder Frontmatter) und an `scripts/check.ps1`.
- Kernänderungen prüft ein unabhängiger Review-Subagent (Opus, frischer Kontext, nur Read/Grep/Glob). Er erhält Aufgabe, vollständigen `git diff HEAD` (vorher `git add -N .`), die betroffenen D-Nummern und das Lauf-Protokoll, das die Änderung begründet. Er erhält **nicht** die Begründungen des Implementierers.
- Prüfpunkte: Widerspruch zu D-Nummern · verlorene oder abgeschwächte Regel · Mehrdeutigkeit, die zwei Läufe verschieden ausführen würden · neue Kostenwirkung (mehr Lesen, mehr Ausgabe) · Overfitting auf einen einzelnen Lauf · Konsistenz Frontmatter, Version, CHANGELOG.
- Ergebnis „kein Blocker" oder Blocker mit Stelle und Begründung, **wörtlich** in § Fortschritt des Plans. Einen Blocker hebt nur ein zweiter Review-Durchgang auf.
- Doku, Plan und Lauf-Protokolle: kein Review.

## Testregel

- `scripts/check.ps1` muss grün sein vor jedem Commit, der `agent/` oder `scripts/` ändert.
- Eine Schutzprüfung in `check.ps1` gilt erst, wenn sie gegen eine absichtlich kaputte Datei einmal rot war (`-AgentPath` auf eine Kopie).
- Ein Eval-Fall (ab 1C) gilt erst als valide, wenn eine absichtlich verstümmelte PTc-Fassung (ohne den Abschnitt, der den Befund tragen soll) ihn verfehlt – Rot-Nachweis wie in der Yoka-DAW.
- Fälle, aus denen PTc abgeleitet wurde (4J), sind **Regressionsfälle**, kein Wirkungsnachweis (D14).

## Ablauf und Freigaben

- **Folgeaufgaben:** Ist eine Aufgabe fertig (check grün, Review ohne Blocker, gepusht), arbeitet Claude die nächste Aufgabe der Unterphase in derselben Session ab. Anhalten nur für Yoka oder bei echtem Blocker. Der Detailplan bleibt eine eigene Session.
- **Zeiten:** Beim Start einer Umsetzungs-Session eine grobe Schätzung bis zum ersten Eingriff Yokas. Start- und Endzeit je Paket **mit Uhrzeit** in die Tabelle „Zeiten" des Plans.
- **G4-Fragen:** nach Empfehlung, als „nach Empfehlung" mit Begründung im Plan.
- **Merge und Tag:** nach der letzten Aufgabe einer Unterphase durch Claude.
- **Läufe in Fremd-Projekten:** Das jeweilige Projekt stößt PTc-Läufe in seinem Plan an. Dieses Repo übernimmt Protokoll und Auswertung in `docs/runs/`. Änderungen am Fremd-Repo macht nur dessen Worker-Session; Befunde gehen als Nachricht oder über dessen Plan (D13).
- **Selbsttest (D36):** Jeder Detailplan dieses Repos bekommt nach dem Schreiben und vor dem Commit ein `PTc:PLAN` mit der deployten Version (Opus, Effort medium). Befunde nach Empfehlung einarbeiten, Karte wörtlich in die Erkenntnisse, Protokoll in `docs/runs/`, nach der Umsetzung Treffer-Bewertung wie bei Fremd-Projekten.
- **Yoka:** nur für Abnahmen am Phasenende und echte Strategie-Pivots.
