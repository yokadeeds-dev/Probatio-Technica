# PTc-Karte · 2026-11-08 · Phase 4I „Controller und OSC“

**Ergebnis: FAIL.** Es gibt drei HART-Befunde, und Bedingung (4) ist nicht erfüllt: Zwei neue dauerhafte Dateien haben keine Aufräum-Regel.

| | |
|---|---|
| **Objekt** | `docs/PHASE_4I_PLAN.md` (Unterphase 4I, D293–D308) |
| **Modus** | PLAN |
| **Stand** | nicht umgesetzt (Status „Detailplan fertig“, Plan Z.3) |
| **Prämisse** | geklärt; Ziel laut Plan Z.7 |

## Herkunft

- **Gelesen:** `PHASE_4I_PLAN.md` vollständig, `PROCESS.md` vollständig, `PHASE_4_PLAN.md`. Letzteres liegt nur als Ausschnitt vor (Originalzeilen 1–10, 49, 52, 80, 84, 101, 104–105, 240).
- **Nicht gelesen:** jeder Quellcode, der Tracktion-Fork, JUCE, `registry/*`, PHASE_4G/4H/3, Feature-Matrix, UPSTREAM.md, SKILL.md, D6/D24/D53/D58/D155/D256/D277/D289. Diese Dateien liegen im Prüfverzeichnis nicht vor.
- **V (verankert):** Zitate unten mit `Datei:Zeile`.
- **S (Selbstauskunft):** „Geprüfte Fakten“ 1–10 (Plan Z.44–53). Sie wurden laut Plan auf Pin `c6eb111` gelesen, ich konnte sie nicht nachprüfen.
- **T (Beleg):** keiner (nichts umgesetzt, Messwerte-Tabelle Z.226–230 leer, das ist erwartet).
- **Projektklassen:** A und T entsprechen PTc-T, Y entspricht S. Das ist mit PROCESS.md Z.14–15 vereinbar.
- **[UNVERIFIZIERT]:**
  - Ist `juce::AbstractFifo` nur für einen Schreiber und einen Leser gebaut?
  - Was bewirkt `UndoTransactionInhibitor` genau?
  - Wie stellt `git diff` Submodule dar?
  - Sind `track_id` projektübergreifend eindeutig?
  - Schreibt `UsageLog` je Ausführung eine Zeile?
- **Degradiert zu offenen Fragen:** F1–F5 (siehe unten).

## Ebenen

| Ebene | Befund |
|---|---|
| **Nano** | FIFO-Eintrag fest 16 Byte, „keine Allokation“ (Z.25). Laut Z.142 schreibt aber auch OSC in **dieselbe** FIFO, inklusive `/yoka/command` mit zwei Strings (`s` Befehls-ID, `s` JSON, Z.34) und frei lernbaren Adressen. Das ist ein Widerspruch, siehe **H2**. Wie die alte Bit-Tabelle nach dem atomaren Austausch freigegeben wird (Z.26), ist offen. |
| **Mikro** | Die Aufgaben haben klare Tests, Rot-Nachweise und Rückfälle (Annahmen 2 und 4). Es fehlen Tests für: Beenden der App mit laufendem Eingang, belegten OSC-Port, Ablauf der Geste bei Projektwechsel oder Undo (**L4**). |
| **Meso** | Schwerster Befund: Die Belegung liegt global je Gerät, enthält aber projektgebundene Ziele (**H1**). Dazu kommen Lecks am OSC-Tastenpfad, beim Rollenwechsel und beim Plugin-eigenen Lernen. |
| **Makro** | Die Grenzen in D307 sind benannt, und es gibt Messaufgaben dafür. Ungeklärt ist, ob „genau 8 Undo-Schritte“ mit der gemeinsamen Zähler-Geste zusammenpasst (F2). |
| **Meta** | Die Review-Ausnahme in Paket 4 widerspricht PROCESS.md (**H3**). Der Abgleich nach D293 weicht von PROCESS.md ab, D295 weicht von D141 ab (S1, S2). Der Fork-Patch wird vor dem Review gepusht (L5). |

## Schnittstellen-Matrix

| A | B | Vertrag benannt? | Test über die Grenze? | Weg am Vertrag vorbei? | Befund |
|---|---|---|---|---|---|
| MIDI-Treiber-Thread | ControllerHub (FIFO) | ja, D295 (Z.25) | FIFO-Überlauf (Z.116) | – | F1: mehrere Schreiber |
| OSC-Empfangsthread | Hub („dieselbe FIFO“, Z.142) | widersprüchlich: 16 Byte gegen Strings | nein | – | **H2** |
| Tracktion `PhysicalMidiInputDevice` | Yoka-Listener (Fork-Patch) | ja, `consumesMessage` (Z.26) | Annahme 2 (Z.58) | Der Patch überspringt nur `sendMessageToInstances`; `externalController` und `controllerParser` liegen laut Fakt 2 (Z.45) im selben Ablauf | F3 |
| Hub | CommandBus (Geste, Quelle) | ja, D299 (Z.29) | Annahme 4 (Z.60) | – | L4, F2 |
| Hub, Quelle `osc` | Zonenprüfung | „OSC nur grün und gelb“ (Z.25, Z.34) | nur für `/yoka/command` (Z.144) | Tasten-Aktion `record` (Z.27) über `/yoka/transport/record` oder eine gelernte OSC-Adresse | **L1** |
| `ControllerMap` (global je Gerät) | Projekt (`track_id`, `plugin_id`) | ja, D297 | nein | – | **H1** |
| `ControllerMap` | Datenordner | ja: atomar, `.invalid` (Z.27) | kaputte Datei (Z.116) | – | Aufräumen fehlt (L6) |
| `controller.set_device {role}` | Spur-Eingang | `track.set_input` lehnt `control` ab (Z.33) | nein | Rollenwechsel bei einem Gerät, das schon Spur-Eingang ist | **L2** |
| Unbelegter CC eines `keys`-Geräts | Plugin-eigenes MIDI-Lernen | „ohne Undo und Event, wie D53“ (Z.26) | nein | Zustandsänderung am Bus vorbei, ohne Geändert-Markierung | **L3** |
| Fork-Repo `yoka/main` | Review (D292) | „vollständige Ausgabe von `git diff HEAD`“ (PROCESS.md:52) | – | Patch-Inhalt liegt im Fork, nicht im Haupt-Diff | L5, F4 |
| MCP-Katalog | Review | PROCESS.md:42 (Katalog ist Kernpfad) | `test_catalog` (Z.156) | Paket 4: „Review nur bei Zonenänderung“ | **H3** |

## Querachsen

**Nebenläufigkeit**
- In die FIFO schreiben mindestens zwei Threads (MIDI-Thread oder MIDI-Threads je Gerät, dazu der OSC-Thread; Z.25, Z.142), gelesen wird auf dem Message-Thread. Ob `AbstractFifo` mehrere Schreiber verträgt, ist ungeklärt (F1).
- Ungeklärt ist auch, wer die alte Bit-Tabelle nach dem Austausch freigibt.

**Lebenszyklus**
- Zustandskreuz: `controller.set_device {reconnect, role}`, die Neuerkennung bei Geräteänderung (Z.115) und `osc.set_config` sind nur gegen „Wiedergabe“ geprüft (Szenario 6, Z.208). Ungeprüft sind die Zustände **Aufnahme mit dem Xboard49 als Eingang**, Speichern und Export (L2).
- Wie eine offene Geste (1 s Nachlauf) mit Projektwechsel, Strg+Z, Speichern und Beenden zusammenspielt, steht nicht im Plan (L4). Szenario 2 drückt Strg+Z direkt nach einer Fahrt (Z.204).
- Beim Beenden fehlt die Reihenfolge: Listener entfernen, Timer stoppen, Socket schließen (L4).

**Ressourcen**

| Komponente | Budget? | Messbeleg? | Wachstum / Aufräumen? | Konkurrenz? |
|---|---|---|---|---|
| FIFO | 1024 × 16 Byte (Z.25) | Messaufgabe vorhanden (OSC 2000/s, Z.183) | fest | MIDI und OSC teilen sie. Gemessen wird nur `dropped`, nicht ob MIDI-Tasten unter OSC-Last verloren gehen. |
| Message-Thread | ≤ 50 ms Block (Z.37) | Messaufgabe vorhanden | – | `/yoka/command`-Flut ist **nicht** gemessen. Jeder Befehl wird ausgeführt, die Regel „neuester Wert“ gilt nur für Bedienteile. |
| `controller/<Gerät>.json` | keine | – | `unresolved`-Einträge bleiben stehen (Z.27), `.invalid`-Dateien sammeln sich. **Wer räumt auf? Nicht geregelt.** | – |
| `controller_raw.jsonl` | keine | – | „nur während der Prüfung“ (Z.57), ohne Aus- oder Löschregel und ohne Aufgabe | – |
| `usage.jsonl` und Events bei 8 Fadern × 60 Hz bzw. OSC 2000/s | keine | keine | Plattenplatz und I/O auf dem Message-Thread ungeklärt (F5) | – |
| MCP-Katalog | 28 (D142, PHASE_4_PLAN.md:24) | – | **28 von 28, keine Reserve** (Z.35). Für 4J und 4K ist das geregelt, für Phase 5/6 nicht. | – |

**Fehlerarten**

| Fehlerart | Stand im Plan |
|---|---|
| OSC-Port belegt | Feld `osc.error` vorhanden (Z.33), kein Test |
| sehr großes JSON in `/yoka/command` | keine Größengrenze |
| Gerätename als Dateiname | Sonderzeichen und zwei gleiche Geräte nicht geregelt |
| `track_id` in einem anderen Projekt | **H1**; ob die Kennung woanders wiederverwendet wird, ist F-offen |
| kaputte Datei, Lern-Timeout, FIFO-Überlauf | behandelt und getestet |

## Konsistenz

### HART

**H1 · Globale Belegung mit projektgebundenen Zielen.**
- D297 legt die Belegung „global je Gerät … nicht im Projekt“ ab, mit der Begründung „Belegung gehört zum Gerät, nicht zum Song“ (Z.27).
- Dieselbe Datei nimmt aber Ziele `{track_id …, plugin:<plugin_id>…}` auf (Z.27).
- Rechtsklick-Lernen am Kanalzug erzeugt standardmäßig die „feste Adresse der Spur“ (Z.36), Szenario 8 ebenso (Z.210).
- Folge: Lernt man in Projekt B denselben Eingang neu, wird die Belegung aus Projekt A ersetzt („ein Eingang genau ein Ziel“, Z.32). `unresolved`-Einträge sammeln sich ohne Aufräumen an.
- Reichweite: ARCHITEKTURPRÄGEND (Dateiformat).

**H2 · Feste 16-Byte-FIFO trägt keine OSC-Strings.**
- D295 (Z.25): Der `RealtimeCallback` schreibt **nur** in eine FIFO mit 16-Byte-Einträgen, „keine Allokation“.
- Aufgabe 5 (Z.142) schickt OSC-Empfang „in dieselbe FIFO“, inklusive `/yoka/command` (`s` + `s` JSON) und beliebiger lernbarer Adressen (Z.34).
- Wie die Daten von Thread zu Thread übergeben werden, ist für diesen Fall nicht festgelegt.
- Reichweite: QUERSCHNITTLICH.

**H3 · Review-Ausnahme gegen die Prozessdatei.**
- Paket 4: „Katalog → Review nur bei Zonenänderung“ (Z.150). „Fertig, wenn“ (Z.159) verlangt kein Review.
- PROCESS.md:42 zählt `registry/mcp_tools.json`, `catalog.py` und `runtime.py` zu den Kernpfaden. PROCESS.md:27 verlangt bei Kernänderungen ein Review.
- Zusätzlich ist das Paket selbst eine Zonenänderung: „rot nur für `osc`“ (Z.156).
- Reichweite: QUERSCHNITTLICH.

### LECK

**L1 · OSC erreicht Rot über den Tasten- und Lernpfad.**
- Die Aktion `record` steht in der Tastenliste (Z.27). `/yoka/transport/<action>` und jede gelernte OSC-Adresse nutzen „dieselbe Belegung“ (Z.34).
- Der Rot-Test prüft nur `/yoka/command` (Z.144).

**L2 · Zustandskreuz Rollenwechsel und Neuverbindung.**
- `set_device role=control` bei einem Gerät, das bereits Spur-Eingang ist, umgeht die Ablehnung durch `track.set_input`.
- `reconnect` bzw. Neuerkennung während einer **Aufnahme** sind nicht getestet.

**L3 · Plugin-eigenes Lernen geht am Bus vorbei.**
- Belegt durch Z.26, aber weder als offener Punkt noch als Aufgabe verankert.
- Ungeprüft ist, ob eine CC-Änderung allein das Projekt als geändert markiert. Ohne Markierung droht Verlust beim Schließen.
- Laut Ziel (Z.7) läuft Hardware „über denselben Bus“. Reichweite: QUERSCHNITTLICH.

**L4 · Lebenszyklus von Geste und Hub.**
- Offene Geste bei Projektwechsel, Undo oder Beenden; Callbacks während des Herunterfahrens.
- Kein Test vorhanden.

**L5 · Fork-Patch wird vor dem Review veröffentlicht.**
- Aufgabe 3 Schritt 1: „auf `yoka/main` des Forks committen und pushen“ (Z.113). Das Review folgt erst bei „Fertig, wenn“ (Z.118).
- Einen Blocker hebt laut PROCESS.md:53 nur der zweite Review-Durchgang auf. Bis dahin stünde ungeprüfter Echtzeit-Code schon auf dem Fork-Hauptzweig.

**L6 · Aufräum-Regeln fehlen.**
- Für `unresolved`-Einträge, `.invalid`-Dateien und `controller_raw.jsonl` gibt es keine Regel.
- Annahme 1 stützt ihren Rot-Nachweis auf `query.controllers` `last_input` und `controller_raw.jsonl` (Z.57). Beides kommt weder im Abfrage-Schema D303 (Z.33) noch in einer Aufgabe vor.

### SYNC

**S1 · D295 ändert D141, ohne es zu sagen.**
- D141 (PHASE_4_PLAN.md:23, Orig. Z.104): „MIDI- und OSC-Callbacks reichen per `MessageManager::callAsync` ein“.
- D295 (Z.25): FIFO und 60-Hz-Timer, überschrieben mit „D141 konkret“.
- Wird das unmarkiert gespiegelt, wird es HART.

**S2 · D293 weicht von der Upstream-Regel ab.**
- D293 (Z.23): „Kein eigenes Abgleich-Paket“. Aufgabe 1: „Andere neue Updates … einordnen“ (Z.95).
- PROCESS.md:75: „bei GELB … zuerst den Abgleich … als eigenes Paket … Mitten in einer Unterphase wird nichts abgeglichen“.
- Die Ausnahme ist plan-lokal und steht nicht in PROCESS.md.

**S3 · Kleinere Lücken in der Dateistruktur und bei den Messwerten.**
- `ControllerMath.h` (Z.169) fehlt in der Dateistruktur (Z.68–81). Liegt die Datei unter `src/core/yoka/controller/`, ist sie ein Kernpfad (Z.53), und dann widerspricht „kein `code-reviewer`“ (Z.163).
- Die Bank-Reihenfolge soll „dieselbe Funktion wie `MixerView`“ nutzen (Z.30), aber ein Umzug in den Kern ist anders als bei FaderLaw nicht geplant.
- Die Messwert-Zeile „Controller → Befehl“ (Z.226) sagt nicht, über welchen Weg gemessen wird (OSC, virtuelles MIDI, Hardware-MIDI). Die Grenze könnte so nur über OSC erfüllt werden.

## Plan-gegen-Ist

Entfällt im Modus PLAN.

## Operatoren

**Abwärts**
- **Jetzt, vor Paket 1:** Korrekturen 1–7 in den Plan einarbeiten. H1 braucht eine eigene Entscheidungsnummer.
- **Bis zur Abnahme:** Tests aus L1, L2 und L4. Den Test „8 gleichzeitige Fader = 8 Schritte“ von Paket 6 in Aufgabe 2 vorziehen.
- **Ab nächster Unterphase:** D141 als geändert spiegeln. Katalogregel (28/28) für Phase 5/6 als offenen Punkt eintragen.

**Aufwärts (Hypothesen)**
- *Datenwachstum:* Nach einem Jahr mit vielen Projekten wächst jede Gerätedatei um tote `track_id`-Ziele. Die Belegung kippt beim Wechsel zwischen Projekten.
- *Muster-Wiederholung:* Weitere Quellen (Skript-API, Matrix Z.163) würden die Zähler-Geste und die gemeinsame FIFO erben. Ohne klare Regel für mehrere Schreiber wächst das Risiko mit jeder Quelle.
- *Katalog:* Nach 4I ist der Katalog voll. Phase 5/6 (CLAP, Live) müssen entweder bestehende Tools erweitern oder D142 anheben.

## Vorentscheidung: **FAIL**

Gründe: H1–H3 (Bedingung 1) und L6 (Bedingung 4). Bedingungen 2, 3 und 5 sind erfüllt; die Grenzen aus D307 haben Messaufgaben.

## Korrekturliste (priorisiert)

1. **Plan Z.27 und Z.36 (D297, D306):** Ziel-Geltungsbereich festlegen. Zur Wahl stehen:
   - feste Spur- und Plugin-Ziele im Projekt ablegen, nur Bank-, Fokus- und Tastenziele global; oder
   - Belegungen je Projekt-ID schlüsseln;
   - Rechtsklick-Standard „Kanalzug der Bank“.

   Dazu eine neue D-Nummer und ein Test „Projekt B überschreibt Projekt A nicht“. *Warum:* H1. *Reichweite:* ARCHITEKTURPRÄGEND.
2. **Plan Z.25, Z.34, Z.142 (D295, D304):** Eigenen Weg für `/yoka/command` festlegen (z. B. `MessageLoopCallback` oder eine begrenzte zweite Warteschlange mit Höchstlänge für JSON). Lernbare Adressen über eine Adress-Tabelle mit fester Größe auf Kennungen abbilden. *Warum:* H2. *Reichweite:* QUERSCHNITTLICH.
3. **Plan Z.150 und Z.159 (Paket 4):** „Review `code-reviewer` (Kernpfad Katalog, PROCESS.md:42)“ als Pflicht eintragen und in „Fertig, wenn“ aufnehmen. *Warum:* H3. *Reichweite:* QUERSCHNITTLICH.
4. **Plan Z.144 (Aufgabe 5, Tests):** Fall „`/yoka/transport/record` und gelernte OSC-Adresse auf `{action: record}` → abgelehnt, gezählt“ mit Rot-Nachweis. *Warum:* L1. *Reichweite:* LOKAL.
5. **Plan Z.113 und Z.118 (Aufgabe 3):** Fork-Patch erst nach dem Review ohne Blocker auf `yoka/main` pushen; bis dahin auf einem Arbeitszweig. Den Patch-Diff des Forks (`<alter Pin>..<neuer Pin>`) ausdrücklich ins Review geben. *Warum:* L5, F4. *Reichweite:* QUERSCHNITTLICH.
6. **Plan Z.27, Z.57, Z.33:** Aufräum-Regeln festlegen:
   - `unresolved` sichtbar machen und per „Profil zurücksetzen“ oder Befehl entfernen;
   - `.invalid` auf N Dateien begrenzen;
   - `controller_raw.jsonl` mit Schalter und Löschung nach Paket 7.

   `last_input` in D303 aufnehmen oder Annahme 1 auf einen geplanten Mechanismus umstellen. *Warum:* L6, Bedingung 4. *Reichweite:* LOKAL.
7. **Plan Z.116 und Z.130 (Tests Aufgabe 3/4):**
   - Rollenwechsel auf `control` bei einem Gerät, das schon Spur-Eingang ist (Wirkung festlegen: Eingang lösen oder Wechsel ablehnen);
   - `reconnect` während einer laufenden Aufnahme;
   - Geste offen bei Projektwechsel, Strg+Z und Beenden.

   *Warum:* L2, L4. *Reichweite:* QUERSCHNITTLICH.
8. **PHASE_4_PLAN § Offene Punkte:** Plugin-eigenes MIDI-Lernen über unbelegte CCs (ohne Bus, Undo, Geändert-Markierung) eintragen, dazu Test oder Handprobe „Projekt nach reiner CC-Änderung als geändert markiert?“. *Warum:* L3. *Reichweite:* QUERSCHNITTLICH.
9. **Plan Z.25 (D295):** „ändert D141 (callAsync → FIFO und Timer)“ ausdrücklich vermerken und in Schritt 4 (Z.215) beim Spiegeln D141 anpassen. *Warum:* S1. *Reichweite:* ARCHITEKTURPRÄGEND (Registereintrag).
10. **Plan Z.23 und Z.95 (D293):** Den Satz „Andere neue Updates einordnen“ auf „nur notieren, Abgleich nach 4I“ beschränken. Die Ausnahme „Python-Patch-Sprung ohne eigenes Paket“ in PROCESS.md:75 aufnehmen oder als Regelabweichung kennzeichnen. *Warum:* S2. *Reichweite:* LOKAL.
11. **Plan Z.68–81, Z.30, Z.226:** Pfad für `ControllerMath.h` angeben (bei Kernpfad: Review). Die Bank-Reihenfolge wie FaderLaw in den Kern ziehen. In der Messwert-Zeile die Quelle (OSC / MIDI virtuell / MIDI Hardware) angeben. *Warum:* S3. *Reichweite:* LOKAL.
12. **Plan Z.29 und Z.105 (Aufgabe 2, Tests):** Fall „8 Controller-Fader gleichzeitig unter der Zähler-Geste = 8 Undo-Schritte“ ergänzen. Heute wird das erst in Paket 6 gemessen (Z.37), also zu spät für eine Umplanung. *Warum:* F2. *Reichweite:* QUERSCHNITTLICH.

## Vorgeschlagene Messaufgaben

| Was | Womit | Grenze |
|---|---|---|
| `/yoka/command`-Flut, z. B. 500/s gelbe Befehle für 10 s | `measure_controller.ps1` | Message-Thread-Block ≤ 50 ms |
| MIDI-Tastendruck „Stop“ unter OSC-Last 2000/s | virtueller Eingang, falls Annahme 8 grün | 0 verlorene Tastendrücke |
| Zuwachs von `usage.jsonl` und `events` bei Lauf D307 (8 Fader, 5 s) und OSC 10 s | Dateigröße vorher/nachher | Grenze in MB je Minute festlegen |

## Offene Fragen (degradiert)

- **F1:** Verträgt `juce::AbstractFifo` mehrere gleichzeitige Schreiber (MIDI-Threads je Gerät, OSC-Thread)? Falls nicht: eine FIFO je Schreiber.
- **F2:** Ergibt die gemeinsame Zähler-Geste (Z.29) zusammen mit dem `UndoTransactionInhibitor` getrennte Schritte je `coalesce_key`, so wie Z.29 („zwei Schritte“) und Z.37 („genau 8“) es verlangen?
- **F3:** Erreichen verbrauchte Nachrichten noch `externalController`, `controllerParser` oder einen Rückblick-Aufnahmepuffer, der für `keys`-Geräte aktiv bleibt?
- **F4:** Zeigt `git diff HEAD` den Inhalt des Fork-Patches oder nur den Submodul-Hash?
- **F5:** Wie viele Zeilen schreibt `UsageLog` bei zusammengefassten (`coalesced`) Befehlen?

## Selbst-Falsifikation

- **H1** ruht auf Plan Z.27, Z.32 und Z.36 (V). Ob `track_id` in fremden Projekten wiederverwendet wird, ist unverifiziert. Das betrifft nur die zusätzliche Fehlwirkung, nicht den Kern des Befunds.
- **H2** ruht auf Z.25, Z.34 und Z.142 (V).
- **H3** ruht auf Z.150 und PROCESS.md:27 und :42 (V).
- **L5:** Der Teil „Push vor Review“ ist V. Der Teil „Diff unsichtbar“ ist als F4 degradiert.
- **F1** ist absichtlich kein Befund, weil der JUCE-Quellcode nicht vorliegt.

## Einschränkungen

- Aussagen über Code und Tracktion stammen aus „Geprüfte Fakten“ (S) und sind nicht gegen den Code geprüft.
- `PHASE_4_PLAN.md` lag nur als Ausschnitt vor.
- Ob D53, D277 und D289 den Plan tragen, wurde nicht geprüft.
- Ressourcen-Hochrechnungen sind Hypothesen.