# Phase 4I „Controller und OSC" – Umsetzungsplan

Status: **Detailplan fertig** (2026-11-06) · Pakete 1–6 ohne Yoka, Paket 7 mit Yoka in **einem** Block (Hardware, GUI, Claude Desktop, siehe „Für Yoka") · Grundlage: [PHASE_4_PLAN.md](PHASE_4_PLAN.md) (Zeile 4I, Tabelle Zeilen 49 und 52, D138, D141, D142, D146, D147, D153, D154, D161, D163, D186, D192, D197, D289, D291, D292, § Offene Punkte „Belegung des nanoKONTROL2“ und „Restlücke `ModalState`“), [PHASE_4H_PLAN.md](PHASE_4H_PLAN.md) (Aufbau, Zeiten, Makros D283), [PHASE_4G_PLAN.md](PHASE_4G_PLAN.md) (Adressen D256, `automation_active` D258), [PHASE_3_PLAN.md](PHASE_3_PLAN.md) (D86 Nicker), [vision/feature_matrix.md](vision/feature_matrix.md) (Zeilen 139, 149, 158, 163, 166–174, 290–298), [research/auswertung_ki-studio-mackie.md](research/auswertung_ki-studio-mackie.md) (§ 6 Hardware, loopMIDI-Ports), [UPSTREAM.md](UPSTREAM.md), [PROCESS.md](PROCESS.md)

> **Für die ausführende Session (D291):** **Eine** Session setzt die ganze Unterphase um, Paket 1 bis Abnahme, ohne Rückfrage zwischen den Paketen. Modell und Effort stehen am Paket (D161); Effort bei Paketwechsel anpassen. Alle Aufgaben sind `Ort: Lokal` (D112). Punkte aus „Ungeprüfte Annahmen" im genannten Schritt zuerst prüfen. Abweichungen unter „Erkenntnisse" eintragen. Nach **jedem Paket** (bei Paket 1 nach jeder Aufgabe): `.\scripts\run_tests.ps1` in Debug **und** `-Config RelWithDebInfo` grün, Rot-Nachweis für Schutz- und Regressionstests (PROCESS § Testregel), bei Kernpfaden Review `code-reviewer` nach D292 (Opus 5.5, Diff mechanisch `git add -N .` + `git diff HEAD`, Urteil wörtlich in die Erkenntnisse), Plan pflegen (diese Datei und `PHASE_4_PLAN.md` Statuszeile + § Fortschritt im selben Commit), Commit `phase 4I: …`, Push, Zeile in „Zeiten“. Anhalten nur für Yoka (Paket 7) oder bei einem echten Blocker. Testausgaben nicht vollständig in den Kontext holen (D163). Fehlersuche, die nicht in einem Anlauf gelingt: als Blocker eintragen und eine Opus-Session vorschlagen (D161).

**Ziel:** Hardware steuert die DAW über denselben Bus wie Maus und KI. Der nanoKONTROL2 bedient acht Kanalzüge (Fader, Regler, S/M/R), den Transport und Bänke; die Regler des Xboard49 wirken auf das gerade fokussierte Gerät; jeder Bedienteil lässt sich per MIDI-Lernen auf Lautstärke, Pan, Send, Plugin-Parameter oder Makro legen. Eine Fader-Fahrt ist **ein** Undo-Schritt. OSC erreicht dieselbe Schicht, nur von `127.0.0.1`, standardmäßig aus. Die KI sieht und ändert die Belegung über `yoka-mcp`. Feature-Matrix Zeilen 139 (MIDI-Learn und Controller-Mapping, Muss) und 158 (OSC-Steuerung, Muss), Hardware Zeilen 290–291.

**Optik und Bedienung wie Cubase (D153, D154):** MIDI-Lernen über Rechtsklick am Bedienelement (wie Cubases „Quick Controls“/„Learn“), Belegungen in einem Einstellungsdialog als Tabelle wie Cubases „MIDI-Remote“-Zuweisungen, im Mixer ein schmaler Balken über den acht gesteuerten Kanälen. Kein Controller-Bild, keine Ableton-Begriffe („Remote“, „Takeover“), kein Overdesign.

**Technik:** C++ (Tracktion: `PhysicalMidiInputDevice::addListener`, `DeviceManager` MIDI-Eingänge, `MidiInputDevice::handleIncomingMidiMessage`; JUCE: `juce::AbstractFifo`, `juce::OSCReceiver::connectToSocket`, `juce::DatagramSocket::bindToPort (port, "127.0.0.1")`, `juce::OSCSender`), doctest, Python für das Tool. Keine neue Abhängigkeit (`juce_osc` ist schon Abhängigkeit von Tracktion, `tracktion_engine.h:28,55`). **Ein kleiner Patch am Tracktion-Fork** (D296), sonst keine Fork-Änderung.

**Branch:** `phase-4i-controller-osc` aus `main` (`1ea9e66`, nach Tag `phase-4h`, Tracktion-Pin `c6eb111`), Draft-PR „phase 4I: Controller und OSC“ gegen `main`. Merge-Commit und Tag `phase-4i` erst nach der Abnahme mit Yoka (Paket 7).

**Entscheidungen:** D1–D292 siehe Phasenpläne. Neu D293–D308 (unten), alle **nach Empfehlung** (D114); Yoka kann sie jederzeit ändern. Keine G4-Frage offen. **Beim Merge in den Phasenplan spiegeln:** `PHASE_4_PLAN.md` trägt D293–D308 erst mit der Abnahme (Muster 4G, 4H).

---

## Entscheidungen 4I (D293–D308, von Claude nach Empfehlung, D114)

| # | Thema | Entscheidung | Begründung |
|---|---|---|---|
| D293 | Upstream vor 4I | `upstream_check.ps1` am 2026-11-06 nach Tag `phase-4h`: **GELB**. Tracktion `develop` = `a5e4499` (0 neue Commits), JUCE nicht geprüft (Submodul ohne eigenes Repo; Tracktion pinnt `7ff644f`), Umgebung unverändert seit 2026-11-02, Python: `click` 8.5.0 → 8.5.1. Kein eigenes Abgleich-Paket: Paket 1 nimmt `click` vor jedem Code mit (`uv lock --upgrade-package click`, `uv sync --frozen`, pytest), Muster D277 | D208; ein Patch-Sprung, kein Tracktion-Abgleich nötig |
| D294 | **Abgrenzung zu `ki-studio-mackie` (D86)** | Die Mapping-Schicht ist **nativ in YokaDAW** (C++ im App-Prozess, Daten im Yoka-Datenordner) und hat **keine** Kopplung an `ki-studio-mackie`. Nicker bleibt in Yoka-DAW reiner Wissens-Server: seine DAW- und MIDI-Tools (`nicker_send_midi_cc*`, `transport_*`, `bank_*`, `channel_*`, `set_track_volume*`, AHK, Mackie-Bridge) bleiben in `registry/nicker_tools.json` ausgeschlossen und in `.claude/settings.json` gesperrt; 4I ändert daran nichts. Kein Mackie-Control-Protokoll in 4I (kein Mackie-Gerät vorhanden, `auswertung_ki-studio-mackie.md` § 6.2; Matrix „Lehren“: das Mackie-Gerüst entfällt). Yoka bietet **virtuelle Ports** (loopMIDI: `MACKIE_*`, `AI_*`, `XBOARD_BRIDGED`, `MasterPC`) nicht als Steuergerät an (Erkennung über den Namen und `getDeviceType`; ausdrücklich per `controller.set_device` nur für Tests). Hält ein anderes Programm (Cubase, die Mackie-Bridge) ein Gerät, meldet `query.controllers` es mit `available: false` und Grund, Yoka läuft weiter (Annahme 3) | D86 („Nickers DAW-Tools gelten für Yoka-DAW nicht“); die Bridge-Ports gehören der Cubase-Welt, Doppelbelegung wäre ein zweiter Weg an den Bus vorbei |
| D295 | **Schicht und Datenfluss** (D141 konkret) | Kern `src/core/yoka/controller/` (ohne GUI und ohne Gerät testbar): `ControllerMap` (Belegung, Laden/Speichern), `ControlInput` (Rohnachricht → Eingang), `ControlTargets` (Ziel → Bus-Befehl), `ControllerHub` (FIFO, Gesten, Übernahme, Lernen). Eingang: Listener am `PhysicalMidiInputDevice` (MIDI-Thread) bzw. `OSCReceiver` mit `RealtimeCallback` schreiben **nur** in eine `juce::AbstractFifo` fester Größe (1024 Einträge à 16 Byte, keine Allokation, keine Sperre; Überlauf zählt `dropped`); der Message-Thread leert sie mit einem `juce::Timer` zu 60 Hz und nimmt je Bedienteil nur den **neuesten** Wert (Tasten: jedes Drücken). Ausführung über `CommandBus::execute` mit Quelle `controller` bzw. `osc`, Nutzungs-Log und Verlauf zeigen die Quelle (Transaktionsname `controller:…`/`osc:…`, D103-Muster). Rechte: **Controller** wie Tastatur und Maus (grün, gelb, aus Rot nur `transport.record` mit `confirmed`, wie der Aufnahmeknopf der Transportleiste); **OSC** nur grün und gelb, Rot nie (D141). Läuft ein Modalzustand (`ModalState`, D147/D155), werden gelbe Befehle aus Controller und OSC **verworfen** (gezählt in `query.controllers`, kein Stau), wie Pipe-Befehle mit `modal_active` | D6 (nur Message-Thread), D141, D147; 60 Hz genügt für Fader (16 ms) und deckelt die Bus-Last je Regler |
| D296 | **Geräte, Rollen, Verbrauchen (Fork-Patch)** | Jedes physische MIDI-Eingangsgerät hat in Yoka eine Rolle: **`control`** (nur Steuerung: nanoKONTROL2; `track.set_input` lehnt es mit `invalid_target` ab, Tracktions eigener Controller-Parser wird abgeschaltet, `setReadingControllerMessages (false)`), **`keys`** (Spieleingang mit Steuerelementen: Xboard49, nanoPAD; Noten gehen wie bisher an Spuren) oder **`off`** (Standard für unbekannte Geräte, wird nicht ausgewertet). Belegte Nachrichten eines `keys`-Geräts werden **verbraucht**: Ein Regler, der einen Send steuert, schreibt kein CC in eine Aufnahme und verstellt nicht das Instrument. Dafür ein **Patch am Tracktion-Fork** (Branch `yoka/main`, Muster der bisherigen Patches, Eintrag in `UPSTREAM.md`): `PhysicalMidiInputDevice::Listener` bekommt `virtual bool consumesMessage (const juce::MidiMessage&) { return false; }`; `handleIncomingMidiMessageInt` überspringt `sendMessageToInstances`, wenn ein Listener sie verbraucht. Yokas Listener prüft das über eine feste Bit-Tabelle (16 Kanäle × 128 CC/Noten, atomar ausgetauscht beim Ändern der Belegung), echtzeitfest. Unbelegte CCs gehen weiter an die Spur, so bleibt plugin-eigenes MIDI-Lernen möglich (Matrix Zeile 139: ohne Undo und Event, wie D53) | Tracktion schickt jede Nachricht eines Geräts an alle Spur-Instanzen (`tracktion_PhysicalMidiInputDevice.cpp:458-486`, Fakt 2); ohne Verbrauch stört jeder belegte Xboard-Regler die Aufnahme. Ein Haken im Listener ist der kleinste Eingriff |
| D297 | **Belegung (Mapping-Datei)** | Global je Gerät (D141), nicht im Projekt: `DataFolders::settings()/controller/<Gerätename>.json` (`"version": 1`, `role`, `profile`, `mappings`). Eintrag: `input` {`type`: `cc` \| `note` \| `osc`, `channel` 1–16, `number` 0–127 bzw. `address`}, `target` (eines von): **Kanalzug der Bank** `{strip: 1–8, param: gain \| pan \| mute \| solo \| arm \| send:<n>}` (`send:<n>` = n-ter Send der Spur); **feste Adresse** wie D256 `{track_id (auch "master"), param: gain \| pan \| mute \| solo \| arm \| send:<bus_id> \| plugin:<plugin_id>:<param_id>}` (Makros als `plugin:<rack_id>:macro:<n>`, D283); **Fokus-Regler** `{focus: 1–8}` (D301); **Taste** `{action: …}` aus der festen Liste `play`, `stop`, `play_stop`, `record`, `loop`, `rewind`, `forward` (je ein Takt über `transport.set_position`), `marker_add`, `marker_prev`, `marker_next`, `bank_prev`, `bank_next`, `undo`, `redo`. Fehlt ein Ziel (Spur gelöscht, Plugin weg), bleibt der Eintrag stehen und ist `unresolved` (keine Wirkung, kein Fehler im Strom). Schreiben atomar (temporäre Datei + Umbenennen, UTF-8 ohne BOM); eine kaputte Datei wird beiseitegelegt (`.invalid`) und das Gerät läuft mit seinem Standardprofil weiter (Meldung in `query.controllers`). Relative Drehgeber, NRPN, Pitchbend als Ziel, mehrere Belegungssätze je Gerät: nicht in 4I | Belegung gehört zum Gerät, nicht zum Song (Cubase: Remote-Einstellungen global); D256-Adressen vermeiden ein zweites Adressschema |
| D298 | **Werte** | Fader/Regler (absolut, 0–127, OSC 0…1): `gain` über **dieselbe Fader-Kurve wie der Mixer-Fader der UI** (eine Funktion; liegt sie heute in `src/app/ui`, zieht Paket 1 sie nach `src/core/yoka/` um), 127 = +6 dB, 0 = −∞; `pan` −1…1 mit Mitte bei 64; `send` wie `gain`; Plugin-Parameter und Makros linear 0…1 über den normierten Wert (`plugin.set_param` mit `normalized`, falls vorhanden, sonst Paket 1 ergänzt es). **Übernahme (Pick-up):** Ein absoluter Regler wirkt erst, wenn er den aktuellen Wert des Ziels kreuzt oder auf ±2 Schritte trifft (nach Bankwechsel, nach Mausänderung, nach Undo); `query.controllers` meldet `pickup_pending`. Tasten: Wert > 0 = Drücken; `mute`, `solo`, `arm`, `loop`, `play_stop` schalten um (aktueller Zustand aus dem Modell), alle übrigen lösen beim Drücken aus, Loslassen wird ignoriert. Auf automatisierte Ziele (D258 `automation_active`) wirkt der Regler nicht (gezählt, kein Fehlerton) | Fader ohne Motor: ohne Übernahme springt die Lautstärke beim Bankwechsel (Cubase „Pick-up“-Modus der Quick Controls) |
| D299 | **Ein Undo-Schritt je Fader-Fahrt** | Der Controller hat keinen Berührungssensor. Der `ControllerHub` öffnet deshalb beim ersten Wert eines absoluten Reglers eine **Geste** (`CommandBus::beginGesture`, D192) und schließt sie **1 s** nach dem letzten Wert dieses Reglers; alle Werte dazwischen sind über `coalesced` (D24) ein Undo-Schritt. Weil der Bus heute nur **eine** Geste kennt (`std::optional<UndoTransactionInhibitor>`, `CommandBus.h:144`), wird daraus ein **Zähler** (Geste offen, solange mindestens ein Halter sie hält; UI-Fader und Controller-Fader überlappen sich so ohne gegenseitiges Beenden). `mixer.set_pan` und `mixer.set_send` werden wie `mixer.set_gain` **`coalesced`** (`coalesce_key` `track_id` bzw. `track_id`+`bus_id`), sonst wäre jeder Pan-Schritt ein Undo-Schritt; die Pan-Regler der UI profitieren mit. Zwei Regler gleichzeitig = zwei Schritte (Schlüssel je Ziel). Tasten sind je Druck ein Schritt (`transaction`) | D141, D24, D192; 1 s überbrückt Handpausen, ohne zwei bewusst getrennte Fahrten zu verschmelzen |
| D300 | **nanoKONTROL2: Standardbelegung** (§ Offene Punkte) | Werksszene, CC-Modus, Kanal 1, Rolle `control`, Profil `nanokontrol2` (Datei `registry/controller_profiles/nanokontrol2.json`, beim ersten Erkennen in den Datenordner kopiert). Kanalzug 1–8 = **Bank** von 8 Spuren in Mixer-Reihenfolge (dieselbe Funktion wie `MixerView`, ohne Master): Fader (CC 0–7) → `gain`, Regler (CC 16–23) → `pan`, S (CC 32–39) → `solo`, M (CC 48–55) → `mute`, R (CC 64–71) → `arm`. Transport: ◀◀ (43) `rewind`, ▶▶ (44) `forward`, ■ (42) `stop`, ▶ (41) `play`, ● (45) `record`, Cycle (46) `loop`. Track ◀/▶ (58/59) → `bank_prev`/`bank_next` (um 8), Marker Set (60) `marker_add`, Marker ◀/▶ (61/62) `marker_prev`/`marker_next`. Bank-Grenzen: erste Bank beginnt bei Spur 1, die letzte darf leere Kanalzüge haben; Bank fällt beim Projektwechsel auf 1. LEDs: keine Rückmeldung in 4I (Werks-LED-Modus „intern“ leuchtet beim Drücken; externer Modus braucht den Korg-Editor) | Cubase-übliche Belegung (Mixer-Bank, Transport, Bankwechsel); CC-Nummern der Werksszene sind Annahme 1, die erste Minute der Abnahme prüft sie (Profil ist eine Datei, Korrektur ohne Neubau) |
| D301 | **Xboard49: Fokus-Regler** | Rolle `keys`, Profil `xboard49`. Die ersten **acht** Regler sind **Fokus-Regler** `{focus: 1–8}`: Sie wirken auf das zuletzt fokussierte Gerät, wie Cubases „Fokus-Quick-Controls“: ein offenes **Rack-Gerät** → Makros 1–8; ein offenes **Plugin-Fenster oder eine Reglerseite** → die ersten acht automatisierbaren Parameter in der Reihenfolge von `query.plugin`; sonst nichts (`unresolved`). Weitere Regler sind frei für MIDI-Lernen. Da die CC-Nummern der Xboard-Regler vom Gerätespeicher abhängen, enthält das Profil **keine** festen Nummern: die erste Abnahme-Minute weist die acht Regler per Lernen „Fokus-Regler 1–8“ zu (Szenario 1). Der App-Teil meldet den Fokus über eine schmale Schnittstelle `ControlFocus` an den Kern (Plugin-Kennung oder Rack-Kennung) | Matrix: „Xboard49-Regler“; Fokus statt fester Ziele hält die Regler in jedem Song nützlich, ohne je Projekt zu belegen |
| D302 | **MIDI-Lernen** | `controller.learn` {`target` wie D297, optional `device`, `timeout_s` 1–60, Standard 10; oder `cancel: true`} startet einen Lernvorgang; die **nächste** Nachricht eines Geräts mit Rolle `control` oder `keys` (bei Noten nur Note-on, bei CC jeder Wert) bzw. jede OSC-Adresse mit einer Zahl wird gebunden: alte Belegung desselben Eingangs und alte Belegung desselben Ziels auf diesem Gerät werden ersetzt (ein Ziel je Gerät genau ein Eingang, ein Eingang genau ein Ziel). Ergebnis als Event `controller.learned` {`device`, `input`, `target`}; Ablauf ohne Nachricht → `controller.learn_timeout`. Nur ein Lernvorgang zugleich (neuer ersetzt den alten). Lernen schreibt die Datei sofort | Cubase und Ableton: „bewegen, fertig“; das Event erlaubt der UI und der KI, den Erfolg zu sehen |
| D303 | **Befehle und Abfrage** | Neu, alle gelb, `undo: none` (globale Einstellungen wie `groove.*`), je mit Event: **`controller.set_device`** {`device`, optional `role`, `profile` (Name eines Profils oder `none`), `reset_mappings: true`, `reconnect: true`} (`controller.device_changed`); **`controller.set_mapping`** {`device`, `input`, `target` oder `remove: true`} (`controller.mapping_changed`); **`controller.learn`** (D302; `controller.learn_started`, `controller.learned`, `controller.learn_timeout`); **`controller.set_bank`** {`bank` ≥ 1 oder `step` ±1} (`controller.bank_changed`, Bankzustand ist Sitzungszustand, nicht im Projekt). Rot: **`osc.set_config`** {`enabled`, optional `port` 1024–65535, Standard 9000, `reply_port`, Standard 9001} (`osc.config_changed`), rot, weil er einen Netzzugang öffnet. Neue Abfrage **`query.controllers`** grün: `devices` [{`name`, `available`, `reason`, `role`, `profile`, `virtual`, `mappings` [{`input`, `target`, `resolved`, `pickup_pending`}]}], `bank` {`number`, `tracks` [{`strip`, `track_id`, `name`}]}, `focus`, `learn` {`active`, `target`, `remaining_s`}, `osc` {`enabled`, `port`, `listening`, `error`}, `counters` {`received`, `executed`, `dropped`, `modal_skipped`, `automation_skipped`}. `track.set_input` lehnt Geräte mit Rolle `control` ab (D296) | Jede Funktion über den Bus; UI und KI nutzen dieselben Befehle; Bank ist Bedienzustand wie Zoom, aber über den Bus, damit die UI-Pfeile nicht am Bus vorbeigehen |
| D304 | **OSC** | Aus bis `osc.set_config` (Einstellung im Datenordner `osc.json`, überlebt Neustart; **beim Start nie automatisch aus einer fremden Quelle eingeschaltet**). Empfang über einen eigenen `juce::DatagramSocket`, gebunden an **`127.0.0.1`** (`bindToPort (port, "127.0.0.1")`, dann `OSCReceiver::connectToSocket`), nie an alle Adressen (`OSCReceiver::connect (port)` bindet an alle, darum verboten, Annahme 5). Zwei Formen: (1) **Befehl** `/yoka/command` mit `s` Befehls-ID und `s` JSON-Argumenten → Bus, Quelle `osc`, nur grün und gelb (rot → `forbidden_zone`); Antwort als `/yoka/result` (`s` Befehls-ID, `s` Ergebnis-JSON) an `127.0.0.1:<reply_port>` über `OSCSender`. (2) **Regler** `/yoka/strip/<1–8>/<gain|pan|mute|solo|arm>` (`f` 0…1 bzw. 0/1), `/yoka/bank` (`i`), `/yoka/transport/<action>` und jede andere Adresse mit **einer** Zahl als lernbarer Eingang (`input.type = osc`, Gerät `OSC`) über dieselbe Belegung, Übernahme und Gesten wie MIDI. Grenze 2000 Nachrichten/s; was die FIFO nicht fasst, zählt `dropped`. Keine Bündel mit Zeitstempel-Planung (sofort ausführen), kein Zeroconf, keine Antwort an fremde Adressen | D141 (nur lokal, standardmäßig aus, nie rot); die Pipe bleibt die Vertrauensgrenze (D73), OSC hat keine Authentifizierung, darum nur Loopback |
| D305 | **MCP-Tool (D142, D289)** | **Ein** neues Tool **`controllers`** (write, `mode: single` mit `action`: `get` → `query.controllers`, `set_device`, `map`, `unmap`, `learn`, `set_bank`; `osc` → `osc.set_config`, rot mit Rückfrage wie `project_file`). `get_status` bekommt **keinen** Controller-Teil (ein Ort). Katalog **28 von 28**: Damit ist der letzte Platz belegt; **4J und 4K dürfen nur bestehende Tools erweitern** (Vorgabe für die Detailpläne, z. B. Browser-Suche als Modus von `import_audio`, Projektversionen in `project_file`) | D289 hat 4I–4K einen Platz gelassen; Controller-Belegung ist eine eigene Absicht („leg Fader 1 auf den Hall-Send“) ohne passendes Tool, Browser und Versionen haben je ein naheliegendes Tool |
| D306 | **UI** | (a) **Rechtsklick „MIDI lernen“** an Kanalzug-Fader, Pan, Send-Regler, Mute/Solo/Arm, Makro-Drehregler des Rack-Geräts, Reglern der generischen Plugin-Seite und den Transportknöpfen: startet `controller.learn` mit dem passenden Ziel (Kanalzug-Elemente: feste Adresse der Spur; im Menü zusätzlich „Kanalzug der Bank lernen“ für Mixer-Elemente). Während des Lernens blinkt das Element in der Theme-Akzentfarbe, Esc bricht ab; „MIDI-Zuweisung entfernen“, wenn belegt. (b) **Einstellungen → „Controller“** (Dialog wie Audio-Einstellungen, D-4B-Muster): Geräteliste mit Rolle (Steuerung / Tasten / aus) und Profil, darunter Tabelle der Belegungen (Eingang, Ziel, Zustand) mit Entfernen und „Lernen …“, Knopf „Profil zurücksetzen“; Abschnitt OSC: Ein/Aus, Port, Antwort-Port, Status. (c) **Mixer:** schmaler Balken über den acht Kanälen der aktuellen Bank, Pfeile daneben = `controller.set_bank`; Tooltip am Fader „Controller: Kanalzug n“ bzw. „Übernahme ausstehend“. Jede Geste genau **ein** Befehl; Farben aus `Theme.h` | D153, D154, D173; Cubase-Bedienung (Learn am Element, Liste im Einstellungsdialog) |
| D307 | Leistung, Echtzeit, Grenzen 4I | Audio-Thread unberührt (MIDI-Thread: nur FIFO-Schreiben und Bit-Tabelle lesen; Review mit Realtime-Checkliste für Listener und Fork-Patch). Grenzen (RelWithDebInfo): Controller → Befehl ausgeführt ≤ 20 ms Median, ≤ 40 ms 99. Perzentil; acht Fader gleichzeitig 5 s Vollhub über OSC-Last: Message-Thread-Block ≤ 50 ms, 0 Aussetzer bei 64 Samples (L-12), genau 8 Undo-Schritte; OSC 2000 Nachrichten/s für 10 s ohne Hänger, UI bedienbar, `dropped` gezählt; Rauchtest `measure_ui.ps1` A/B gegen `phase-4h` mit aktivem Controller-Hub und OSC an (Grenzen D186). **Nicht in 4I:** LED- und Motorfader-Rückmeldung, Mackie Control/HUI, relative Drehgeber, NRPN/14-Bit, Controller-Skript-API (Matrix Zeile 163, Soll), Traktor Kontrol S8 (Später), nanoPAD-Belegung über Noten hinaus (Clip-Start ist Soll), mehrere Belegungssätze/Seiten je Gerät, OSC-Abfragen außer `/yoka/command`, OSC über Netzwerk | D146, D186, D197; Matrix: Soll oder Später; D137 |
| D308 | D292 (3) Prüfwerkzeuge ohne KI | **Nicht in 4I**, sondern in **4K** (passt zu „Release-Build ohne Warnungen“: `/analyze` bzw. clang-tidy und ein AddressSanitizer-Lauf in einem Paket an der Grenze 4J/4K). Bis dahin gilt der Review-Subagent (PROCESS.md) | 4I ist Hardware-lastig; die Werkzeuge brauchen eigene Build-Konfigurationen und gehören zum Release-Build |

---

## Geprüfte Fakten (2026-11-06, gelesen auf Pin `c6eb111`; Pfade unter `external/tracktion_engine/modules/tracktion_engine/`)

1. **MIDI-Listener:** `PhysicalMidiInputDevice` hat eine eigene `Listener`-Klasse (`handleIncomingMidiMessage (const juce::MidiMessage&)`) mit `addListener`/`removeListener` unter `RealTimeSpinLock` (`playback/devices/tracktion_PhysicalMidiInputDevice.h:46-66, 84`). `handleIncomingMidiMessageInt` ruft die Listener **vor** jeder Filterung auf (`.cpp:458-463`), auf dem Thread des MIDI-Treibers.
2. **Kein Verbrauch ohne Patch:** Danach geht jede Nachricht an `externalController` (nur Tracktions Control-Surface-Weg, D141 verboten) oder über `handleIncomingMessage` (Kanal- und Notenfilter, `MidiInputDevice.cpp:1584-1613`) an `controllerParser` (Tracktions MIDI-Learn, `isTakingControllerMessages`) und `sendMessageToInstances` an alle Spur-Instanzen (`PhysicalMidiInputDevice.cpp:466-486`). Ein CC-genauer Filter fehlt; nur ganze Kanäle (`disallowedChannels`) und ein Notenbereich sind abschaltbar. Folge: D296.
3. **Tracktion-Mappings:** `ParameterControlMappings` und `CustomControlSurface` setzen Parameter direkt (D141); Yoka legt keine an. `setReadingControllerMessages (bool)` schaltet den Parser je Gerät ab.
4. **OSC:** `juce_osc` ist Abhängigkeit von Tracktion (`tracktion_engine.h:28, 55`). `OSCReceiver::connect (int)` und `connectToSocket (DatagramSocket&)` (`juce_osc/osc/juce_OSCReceiver.h:68, 76`), `MessageLoopCallback`/`RealtimeCallback` (`:94-116`); `DatagramSocket::bindToPort (int, const String& localAddress)` (`juce_core/network/juce_Socket.h:146`).
5. **Bus heute:** Quellen `"ui"`, `"mcp"`, `"script"`, `"controller"`, `"test"` sind in `CommandBus::Options` und `EventLog` vorgesehen (`CommandBus.h:30, 47`, `EventLog.h:15`), `"osc"` noch nicht. `describeTransaction`/`parseTransaction` kennen nur `mcp` mit Präfix (`CommandBus.h:107-122`). Eine Geste ist **ein** `std::optional<te::Edit::UndoTransactionInhibitor>` (`CommandBus.h:144`, `CommandBus.cpp:192-202`): ein zweites `beginGesture` ersetzt die laufende, `endGesture` beendet jede. `coalesceWindowMs = 300` (`CommandBus.h:61`).
6. **Register heute (Stand `1ea9e66`):** 81 Einträge (67 Befehle, 14 Abfragen), kein `controller.*`/`osc.*`. `mixer.set_gain` ist `coalesced` mit `coalesce_key: ["track_id"]`; `mixer.set_pan` und `mixer.set_send` sind `transaction` (`registry/commands.json:470-503`). `transport.record` ist rot; die UI ruft Befehle über `AppContext::run (id, args, confirmed)` mit Quelle `ui` (`AppContext.cpp:93-95`). Muster für globale Einstellungen ohne Undo: `groove.save_from_clip`/`groove.delete` (`undo: none`, Tool `manage_grooves`).
7. **Datenordner:** `DataFolders::settings()` (`%APPDATA%`, D46/D54) hält z. B. `grooves.xml` (`DataFolders.h:41, 64`); Kernpfad „Datei-I/O“ (PROCESS.md).
8. **MCP:** Katalog 27 Tools (`registry/mcp_tools.json`), `MAX_TOOLS = 28` (D289: ein Platz für 4I–4K). Nicker: `nicker_send_midi_cc*`, `transport_*`, `bank_*`, `set_track_volume*` stehen unter `excluded` in `registry/nicker_tools.json`.
9. **Rechner:** loopMIDI-Ports der KI-Studio-Mackie-Welt sind fest verdrahtet (`MACKIE_TO/FROM_CUBASE`, `XBOARD_BRIDGED`, `AI_*`, `auswertung_ki-studio-mackie.md` § 6.4); die 4E-Abnahme nahm zuerst versehentlich `XBOARD_BRIDGED` statt „E-MU Xboard49“ (`PHASE_4E_PLAN.md` Erkenntnisse). Daraus D294 (virtuelle Ports nicht anbieten).
10. **Kernpfade** laut `PROCESS.md`: `CommandBus.*`, `registry/*`, `commands/`, `DataFolders.h`, `ModalState.*`, `src/app/AppContext.*`, `InputCommands.cpp`. Neu (Paket 1 trägt sie in PROCESS.md ein): `src/core/yoka/controller/**` (MIDI-Thread, Datei-I/O), `src/core/yoka/commands/ControllerCommands.cpp`, `src/app/ControllerIO.*` (Geräte, OSC-Socket), der Fork-Patch.

## Ungeprüfte Annahmen (im genannten Schritt zuerst prüfen)

1. (Paket 7, erste Minute) Der nanoKONTROL2 steht in der Werksszene (CC-Nummern wie D300, Kanal 1, Tasten 127/0). Rot-Nachweis: Rohmitschnitt (`query.controllers` `last_input` bzw. Log `controller_raw.jsonl` nur während der Prüfung) gegen das Profil; Abweichung → Profil-Datei korrigieren (kein Neubau), Erkenntnis.
2. (Paket 1, zuerst) Ein über `PhysicalMidiInputDevice::handleIncomingMidiMessage (msg, {})` in einem Test eingespeister CC erreicht den Yoka-Listener, ohne dass eine Spur das Gerät als Eingang hat, und mit dem Fork-Patch erreicht ein verbrauchter CC **keine** Spur-Instanz (Aufnahme eines MIDI-Clips enthält ihn nicht), ein unverbrauchter schon. Sonst: Opus-Session, Rückfall: `keys`-Geräte nur mit Kanaltrennung (Regler auf eigenem Kanal, Handschritt Yoka).
3. (Paket 7) Hält ein anderes Programm ein Gerät (WinMM-Eingänge sind exklusiv), scheitert das Öffnen sauber: Yoka meldet `available: false` mit Grund, kein Absturz, kein Hänger; nach Freigabe bringt `controller.set_device {reconnect: true}` (oder Ab- und Anstecken) das Gerät zurück. Sonst: Befund, Blocker für die Abnahme.
4. (Paket 1) Mit Zähler-Geste bleibt eine Controller-Fahrt mit Pausen < 1 s **ein** Undo-Schritt, auch wenn gleichzeitig ein UI-Fader gezogen und losgelassen wird; Tracktions 350-ms-Timer schiebt keine unbenannte Transaktion dazwischen (D58). Test mit eigener Uhr (`setClock`). Sonst: Gesten je Quelle getrennt halten.
5. (Paket 3) Ein an `127.0.0.1` gebundener Socket ist von einer anderen lokalen Adresse des Rechners (z. B. der LAN-Adresse) **nicht** erreichbar, und `netstat -ano` zeigt `127.0.0.1:<port>`, nicht `0.0.0.0`. Sonst: OSC bleibt aus (Blocker), Erkenntnis.
6. (Paket 1) `mixer.set_pan`/`mixer.set_send` als `coalesced` ändern nichts an MCP-Gruppen (`mix`-Tool, `executeGroup` erlaubt `coalesced`, D102) und an der UI (Pan-Regler: ein Zug = ein Schritt). Bestehende Tests bleiben grün.
7. (Paket 2) Die Fokus-Meldung aus Plugin-Fenstern (`PluginEditorWindows`) und dem Rack-Gerät reicht für D301 (Fenster erhält Fokus → `ControlFocus`), auch bei VST3-Editoren, die den Tastaturfokus selbst halten. Sonst: Fokus = zuletzt geöffnetes bzw. angeklicktes Gerät.
8. (Paket 6) Ohne Hardware ist ein Ende-zu-Ende-Lauf über einen **virtuellen** Eingang möglich (Windows MIDI Services Loopback oder ein freier loopMIDI-Port, ausdrücklich per `controller.set_device` freigegeben, D294). Sonst: Ende-zu-Ende nur über OSC (gleicher Hub) und Unit-Tests; MIDI-Geräte erst in Paket 7.

## Dateistruktur

| Datei | Neu/geändert | Inhalt |
|---|---|---|
| `external/tracktion_engine` (Fork `yoka/main`), `docs/UPSTREAM.md` | geändert (Kern, MIDI-Thread) | `Listener::consumesMessage`, Pin-Anhebung, Patch-Eintrag (D296) |
| `src/core/yoka/controller/ControllerMap.*`, `ControlInput.h`, `ControlTargets.*`, `ControllerHub.*`, `FaderLaw.h` | neu (Kern) | Belegung, Eingang, Ziele, FIFO, Gesten, Übernahme, Lernen, Fader-Kurve (D295–D302) |
| `src/core/yoka/CommandBus.*`, `EventLog.*`, `UsageLog.*` | geändert (Kern) | Zähler-Geste, Quelle `osc`, Transaktionsnamen `controller:`/`osc:` |
| `src/core/yoka/commands/ControllerCommands.cpp`, `InputCommands.cpp`, `MixerCommands.cpp` | neu/geändert (Kern) | `controller.*`, `osc.set_config`, `query.controllers`; `track.set_input` lehnt `control` ab; Pan/Send coalesced |
| `registry/commands.json`, `registry/mcp_tools.json`, `registry/controller_profiles/*.json` | geändert/neu (Kern) | Befehle, Events, Abfrage; Tool `controllers`; Profile `nanokontrol2`, `xboard49` |
| `src/app/ControllerIO.*`, `src/app/AppContext.*` | neu/geändert (Kern) | Geräte öffnen, Listener, OSC-Socket und Antwort, Fokus-Meldung |
| `src/app/ui/ControllerDialog.*`, `MixerView.*`, `ChannelStrip.h`, `RackDevice.*`, `PluginEditorWindows.*`, `TransportBar.*`, `MainMenu.*`, `HistoryText.h`, `RefreshPlan.h` | neu/geändert | Lernen-Menü, Einstellungen „Controller“, Bankbalken, Quelle im Verlauf |
| `src/mcp/yoka_mcp/*`, `tests/mcp/*`, `src/mcp/README.md` | geändert | Tool `controllers`, Zählung 28 |
| `tests/` | neu/geändert | `ControllerMapTests`, `ControllerHubTests`, `ControllerCommandTests`, `OscTests`, `ControllerMidiTests` (Engine, eingespeiste Nachrichten), Fälle in `CommandBusTests`, `MixerTests`, `RegistryTests`, `RefreshPlanTests`, `tests/mcp` |
| `scripts/osc_send.ps1`, `scripts/measure_controller.ps1`, `scripts/prepare_abnahme_4i.ps1` | neu | OSC-Sender ohne Abhängigkeit (.NET `UdpClient`), Messung D307, Testprojekt |
| `.claude/skills/tracktion-daw/SKILL.md`, `docs/PROCESS.md` | geändert | Controller-Schicht, Rollen, Fork-Patch, Kernpfade |
| `docs/phase4i_abnahme.md` | neu (Paket 7) | Abnahme, Messwerte |

---

## Aufgaben

### Paket 1: Upstream, Mapping-Kern, MIDI-Eingang (Aufgaben 1–3)

**Modell: Sonnet 5.5, Effort medium** (D161) · Kern (Bus, Register, MIDI-Thread, Fork) → Review `code-reviewer` mit Realtime-Checkliste. Annahme 2 rot und nicht in einem Anlauf lösbar: Befund eintragen, Blocker.

### Aufgabe 1: Python-Mitnahme (D293)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** `upstream_check.ps1` erneut; ist er weiter nur wegen `click` GELB: `uv lock --upgrade-package click`, `uv sync --frozen`, pytest. Andere neue Updates nach `UPSTREAM.md` einordnen. Laufende `yoka-mcp.exe` sperren das venv: Reparatur wie 4H Paket 1 (Prüfung im Wegwerf-venv, gesperrte `.pyd` umbenennen), keine fremden Prozesse beenden.

**Fertig, wenn:** pytest grün, `yoka-mcp --check` ok, Commit `phase 4I: Paket 1, Aufgabe 1 (Python-Mitnahme)`.

### Aufgabe 2: Bus-Vorarbeiten (D295, D298, D299)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** Zähler-Geste im `CommandBus` (Annahme 4 zuerst als Test), Quelle `osc`, Transaktionsnamen mit `controller:`/`osc:` in `describeTransaction`/`parseTransaction`, Verlauf zeigt „Controller“/„OSC“.
- [ ] **Schritt 2:** `mixer.set_pan`, `mixer.set_send` → `coalesced` (Annahme 6); Fader-Kurve als `FaderLaw.h` in den Kern (UI nutzt sie).
- [ ] **Tests:** Geste überlappend (UI + Controller), Pause 0,9 s vs. 1,1 s, Pan-Zug ein Schritt, Gruppen mit Pan; Rot-Nachweis: Zähler aus (alte `optional`) → Überlappungstest rot.

**Fertig, wenn:** Tests grün in beiden Konfigurationen, Review ohne Blocker, Commit `phase 4I: Paket 1, Aufgabe 2 (Bus-Vorarbeiten)`.

### Aufgabe 3: Mapping-Kern und MIDI-Eingang (D294–D298, D300)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** Fork-Patch `consumesMessage` (Annahme 2 zuerst: Test mit eingespeistem CC an ein `PhysicalMidiInputDevice` einer Test-Engine), auf `yoka/main` des Forks committen und pushen, Pin anheben, `UPSTREAM.md`.
- [ ] **Schritt 2:** `ControllerMap` (Datei D297, atomar, `.invalid`-Rückfall), `ControlInput`, `ControlTargets` (Bank, feste Adressen, Tasten-Aktionen, `unresolved`), `ControllerHub` (FIFO, 60-Hz-Leerung, neuester Wert, Gesten 1 s, Übernahme, Zähler, Modal-Sperre), Profile `nanokontrol2`, `xboard49`.
- [ ] **Schritt 3:** `ControllerIO` in der App: Geräte nach Rolle öffnen, virtuelle Ports ausnehmen, Listener mit Bit-Tabelle, `setReadingControllerMessages (false)` für `control`; Neuerkennung bei Geräteänderung.
- [ ] **Tests:** nanoKONTROL2-Profil gegen eingespeiste CCs (Fader → `mixer.set_gain` der Bank-Spur, S/M/R, Transport, Bank ±8, Grenzen), Übernahme (kein Sprung nach Bankwechsel), ein Undo-Schritt je Fahrt, verbrauchter CC nicht in der Aufnahme / unbelegter schon, `unresolved` nach `track.delete`, kaputte Datei, Modal-Sperre, FIFO-Überlauf zählt. Rot-Nachweis: Verbrauch aus → Aufnahme-Test rot; Übernahme aus → Sprung-Test rot.

**Fertig, wenn:** Tests grün in beiden Konfigurationen, Review (Realtime) ohne Blocker, PROCESS.md-Kernpfade nachgezogen, Commit `phase 4I: Paket 1, Aufgabe 3 (Mapping-Kern, MIDI-Eingang)`.

### Paket 2: Befehle, Lernen, Fokus (Aufgabe 4)

**Modell: Sonnet 5.5, Effort medium** · Kern → Review

### Aufgabe 4: `controller.*`, `query.controllers`, MIDI-Lernen (D301–D303)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** Register und Handler `controller.set_device`, `controller.set_mapping`, `controller.learn`, `controller.set_bank`, `query.controllers`; `track.set_input` lehnt `control` ab. Events in den Resource-Listen von `daw://project`/`daw://history` (Muster 4H).
- [ ] **Schritt 2:** Lernen (D302) mit Ablauf, Ersetzen, Event; `ControlFocus` und Fokus-Regler (Annahme 7).
- [ ] **Tests:** Lernen mit eingespeistem CC und Note, Ablauf, Ersetzen (Eingang und Ziel), Fokus-Regler auf Rack-Makros und Plugin-Parameter, `automation_active`-Ziel ohne Wirkung, Bank über Befehl. Rot-Nachweis: Ersetzen aus → Doppelbelegungs-Test rot.

**Fertig, wenn:** Tests grün in beiden Konfigurationen, Review ohne Blocker, Commit `phase 4I: Paket 2 (Befehle, Lernen, Fokus)`.

### Paket 3: OSC (Aufgabe 5)

**Modell: Sonnet 5.5, Effort medium** · Kern (Netzzugang) → Review mit Sicherheitsblick (Bindung, Zonen, Grenzen)

### Aufgabe 5: OSC lokal (D304)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** Annahme 5 zuerst (Socket an `127.0.0.1`, `netstat`, Zugriff über LAN-Adresse scheitert). `osc.set_config` (rot), `osc.json`, Empfang mit `RealtimeCallback` in dieselbe FIFO, `/yoka/command` mit Antwort, Regler-Adressen, lernbare Adressen.
- [ ] **Schritt 2:** `scripts/osc_send.ps1` (.NET `UdpClient`, OSC-Kodierung im Skript, keine Abhängigkeit).
- [ ] **Tests:** `/yoka/command` grün/gelb ausgeführt, rot → `forbidden_zone`, kaputtes JSON → Fehlerantwort, Regler-Adressen über Bank, Lernen einer OSC-Adresse, Aus nach Neustart ohne Einstellung, 2000/s mit `dropped`. Rot-Nachweis: Bindung an alle Adressen → Bindungstest rot; Zonenprüfung aus → Rot-Test rot.

**Fertig, wenn:** Tests grün in beiden Konfigurationen, Review ohne Blocker, Commit `phase 4I: Paket 3 (OSC)`.

### Paket 4: MCP-Tool (Aufgabe 6)

**Modell: Sonnet 5.5, Effort medium** · Katalog → Review nur bei Zonenänderung

### Aufgabe 6: Tool `controllers` (D305)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** `registry/mcp_tools.json` (`controllers`, rot nur für `osc`), Builder, Beschreibung mit Beispielen („Fader 1 auf Hall-Send der Spur X“: `learn` vs. `map`), Katalog 28, README, Zähl-Tests; `test_catalog`: alle `controller.*`, `osc.set_config`, `query.controllers` erreichbar.
- [ ] **Tests:** pytest (Builder, Ablehnungen, Live-Fall `test_live_pipe` ohne laufende DAW übersprungen), `yoka-mcp --check` 28 Tools. Rot-Nachweis: `query.controllers` aus dem Tool → Erreichbarkeitstest rot.

**Fertig, wenn:** pytest grün in beiden Konfigurationen (`yoka_mcp_pytest`), Commit `phase 4I: Paket 4 (MCP-Tool controllers)`.

### Paket 5: UI (Aufgabe 7)

**Modell: Sonnet 5.5, Effort medium** · UI ohne neue Kernpfade (nur Bus-Aufrufe) → kein `code-reviewer`; Lints `check_bus_only`, `check_theme_colours`

### Aufgabe 7: Lernen-Menü, Einstellungen „Controller“, Bankbalken (D306)

**Ort: Lokal** · ohne Yoka

- [ ] **Schritt 1:** Rechtsklick „MIDI lernen“ / „MIDI-Zuweisung entfernen“ an den Elementen aus D306 (a), Blinken, Esc; Ziel-Abbildung als reine Funktion (`ControllerMath.h`, ohne GUI testbar).
- [ ] **Schritt 2:** Dialog „Controller“ (D306 b) im Menü Einstellungen; Mixer-Bankbalken und Pfeile (D306 c); `RefreshPlan` für `controller.*`/`osc.*`-Events (nur Mixer/Dialog, keine volle Aktualisierung).
- [ ] **Tests:** `ControllerMathTests` (Element → Ziel, Bank-Balken-Bereich), `RefreshPlanTests`. Rot-Nachweis: falsche Kanalzug-Abbildung → Test rot.

**Fertig, wenn:** Tests und Lints grün in beiden Konfigurationen, Commit `phase 4I: Paket 5 (UI)`.

### Paket 6: Messung ohne Yoka, Abnahme vorbereiten (Aufgabe 8)

**Modell: Sonnet 5.5, Effort medium**

### Aufgabe 8: Messskripte, Vergleichs-Build, Testprojekt (D307)

**Ort: Lokal** · ohne Yoka; L-12 nur, wenn frei (`query.devices`), sonst Messlauf in Paket 7

- [ ] **Schritt 1:** `scripts/measure_controller.ps1` (Latenz Controller → Befehl über OSC-Regler, acht Fader gleichzeitig, OSC-Last 2000/s, Undo-Zählung), Annahme 8 (virtueller MIDI-Eingang) prüfen und, wenn grün, denselben Lauf über MIDI.
- [ ] **Schritt 2:** Vergleichs-Build `phase-4h` seriell (`--parallel 1`, `C:\Yoka\Build\Yoka-DAW-4h`, Quelle per `git archive phase-4h`) **jetzt** bauen, damit Paket 7 nicht auf Builds wartet; RelWithDebInfo des Arbeitsstands bauen.
- [ ] **Schritt 3:** `scripts/prepare_abnahme_4i.ps1`: Projekt „Abnahme 4I“ mit 12 Spuren (2 Bänke), Bus „Hall“ mit Sends, Gesangsspur mit Plugin, Rack mit Makros, Marker; `docs/phase4i_abnahme.md` mit Szenarien anlegen.
- [ ] **Schritt 4:** Ist der L-12 frei: Messläufe D307 und Rauchtest A/B sofort; Werte unter „Messwerte“.

**Fertig, wenn:** Skripte gelaufen (ohne L-12 die Teile ohne L-12), Builds bereit, Commit `phase 4I: Paket 6 (Messung, Abnahme vorbereitet)`. Danach Yoka rufen (ein Block, siehe „Für Yoka“).

### Paket 7: Abnahme mit Yoka und Abschluss 4I (Aufgabe 9)

**Modell: Sonnet 5.5, Effort medium** · mit Yoka, **ein** Block

### Aufgabe 9: Abnahme und Abschluss

**Ort: Lokal** · mit Yoka (nanoKONTROL2, Xboard49, L-12, GUI, Claude Desktop) · RelWithDebInfo (D146); Belege nach PROCESS.md (Y nie allein)

- [ ] **Schritt 0 (ohne Yoka, direkt vor dem Block):** App mit „Abnahme 4I“ starten, `query.controllers` prüfen (beide Geräte `available`), fehlende L-12-Messläufe fahren, sobald Yoka „Cubase zu, Geräte dran“ gemeldet hat.
- [ ] **Schritt 1:** Szenarien in `docs/phase4i_abnahme.md` (Ansagen nennen Spurnamen und Bedienteil):

  | # | Szenario | Entscheidung | Beleg |
  |---|---|---|---|
  | 1 | Erste Minute: je ein Fader, Regler, S/M/R von Kanalzug 1 und alle Transport-/Track-/Marker-Tasten einmal (Annahme 1); acht Xboard-Regler per „Lernen“ auf Fokus-Regler 1–8 (Claude startet das Lernen per Befehl, Yoka dreht nur) | D300, D301, D302 | A Rohmitschnitt, `query.controllers` |
  | 2 | Fader 1–8 und Regler auf Bank 1, Strg+Z nimmt **eine** Fahrt zurück; S/M/R; Bank ▶ auf Spuren 9–12, Bankbalken im Mixer folgt; Fader springt nach Bankwechsel nicht (Übernahme) | D298–D300, D306 | A `usage.jsonl` (Quelle `controller`), `query.history`, D Foto |
  | 3 | Transport: Play, Stop, Cycle, ◀◀/▶▶, Aufnahme auf einer scharfen Spur, Marker setzen und anspringen | D297, D300 | A `usage.jsonl`, `query.project_overview` |
  | 4 | Xboard49: Plugin-Fenster der Gesangsspur öffnen, Fokus-Regler drehen; Rack-Gerät öffnen, Regler wirken auf Makros; zwei Takte einspielen und dabei einen Fokus-Regler drehen → Clip ohne dessen CC | D296, D301 | A `query.plugin`, `query.clip`, T Test Aufgabe 3 |
  | 5 | MIDI-Lernen per Rechtsklick: nanoKONTROL2-Regler 8 auf den Send „Hall“ der Gesangsspur; Zuweisung im Dialog „Controller“ sichtbar, dort entfernen | D302, D306 | A `usage.jsonl`, D Foto |
  | 6 | nanoKONTROL2 ab- und wieder anstecken während der Wiedergabe: kein Absturz, Gerät wieder verfügbar (Annahme 3); optional Cubase mit dem Gerät starten → `available: false`, nach Beenden zurück | D294, D303 | A `query.controllers`, `performance.jsonl` |
  | 7 | OSC: Claude schaltet OSC ein (Rückfrage, Yoka bestätigt), `osc_send.ps1` fährt Kanalzug-Fader und schickt einen roten Befehl (abgelehnt); `netstat` zeigt `127.0.0.1` | D304 | A `usage.jsonl` (Quelle `osc`), `netstat`, T Paket 3 |
  | 8 | Claude Desktop: „Leg den Fader 8 des nanoKONTROL2 auf den Hall-Send der Gesangsspur und zeig mir, was belegt ist“ → Yoka bewegt Fader 8 | D305 | A Audit (`controllers`), `call_id` |
  | 9 | Optik: Lernen-Menü, Dialog „Controller“, Bankbalken gegen „Cubase-nah, kein Overdesign, nichts nach Ableton“ | D153, D154, D306 | Y + D; Korrekturen als Befund |

- [ ] **Schritt 2:** Messwerte aus Aufgabe 8 übernehmen, fehlende L-12-Messung nachholen; Export gegen Wiedergabe unverändert (D197, kurzer Lauf).
- [ ] **Schritt 3:** Gesamtlauf `run_tests.ps1` Debug und RelWithDebInfo, pytest, `yoka-mcp --check`, Live-Fall aus Aufgabe 6.
- [ ] **Schritt 4:** Doku: Abnahme-Datei, Skill `tracktion-daw` (Controller-Schicht, Rollen, Fork-Patch, OSC nur lokal), `PROCESS.md`, `PHASE_4_PLAN.md` (Statuszeile, Zeile 4I, D293–D308 spiegeln, Fortschritt, § Offene Punkte: nanoKONTROL2-Punkt schließen, D292(3) → 4K), Feature-Matrix Zeilen 139 und 158 als erledigt, diese Datei.
- [ ] **Schritt 5:** Commit `phase 4I: Abnahme, 4I abgeschlossen`, Push; PR-Status prüfen (Memory „PR schon gemergt prüfen“), PR auf „bereit“, Merge-Commit nach `main`, Tag `phase-4i`, Tag pushen (D114). Danach `upstream_check.ps1` und Detailplan 4J in neuer Session (Opus 5.5, Effort medium).

**Fertig, wenn:** Abnahme mit Belegen A/T dokumentiert, alle Tests grün, gemergt, Tag gepusht.

---

## Messwerte

| Bezeichnung | Datum | Wert | Gerät / Bemerkung |
|---|---|---|---|
| Controller → Befehl ausgeführt (Median / 99. Perzentil) | – | – | D307: ≤ 20 / ≤ 40 ms |
| Acht Fader gleichzeitig 5 s: Message-Thread-Block, Aussetzer, Undo-Schritte | – | – | D307: ≤ 50 ms, 0 (64 Samples, L-12), 8 |
| OSC 2000 Nachrichten/s, 10 s: Hänger, `dropped` | – | – | D307: kein Hänger, UI bedienbar |
| Rauchtest A/B gegen `phase-4h` (Hub und OSC aktiv) | – | – | D186: Leerlauf ≤ +1, Wiedergabe ≤ +1,5, Block ≤ +0,2 ms |
| Export vs. Wiedergabe (I) | – | – | D197: ±0,1 LU |

---

## Für Yoka

Handschritte, die Claude ohne Yoka nicht erledigen kann. Alles andere läuft ohne Yoka. **Ein** Block am Ende (Paket 7), vorher nichts Aktives. Knöpfe neutral: Yoka meldet nur „erledigt“, das Ergebnis misst Claude.

0. (Vor dem Session-Start, passiv, optional) nanoKONTROL2 und Xboard49 eingesteckt lassen; Cubase und andere ASIO-Programme möglichst geschlossen. Dann kann Claude in Paket 1 die Geräteerkennung und in Paket 6 die L-12-Messung ohne Yoka fahren.
1. (Paket 7, Blockbeginn, 1 min) Cubase und ASIO-Programme beenden, L-12, nanoKONTROL2, Xboard49 anschließen, „erledigt“. Claude fährt die restlichen Messläufe (≈ 20 min, Yoka nicht nötig).
2. (Paket 7) Claude Desktop ganz beenden und neu starten (neues Tool `controllers`).
3. (Paket 7, Szenarien 1–6, 8, 9, ≈ 45–60 min) Bedienung wie angesagt, Optik ansehen und sagen, was nicht nach Cubase aussieht oder zu viel ist; Szenario 7 nur die OSC-Rückfrage bestätigen; Szenario 8 den vorgegebenen Satz in Claude Desktop eingeben.

---

## Erkenntnisse

### Planung (2026-11-06, PC)

- **Upstream (D293):** GELB nur wegen `click` 8.5.0 → 8.5.1; Tracktion ohne neue Commits. Mitnahme in Paket 1.
- **Größtes Risiko:** Ein belegter Regler eines Spielgeräts landet ohne Patch in jeder Aufnahme und im Instrument (Fakt 2). Darum steht der Test des Fork-Patches vor jedem anderen Controller-Code (Annahme 2), der Rückfall (Kanaltrennung) ist festgelegt.
- **Bus-Falle:** Die Geste des Busses ist einzeln (Fakt 5); ein Controller, der eine Geste hält, würde die eines UI-Faders beenden und umgekehrt. Zähler-Geste vor allem anderen (Aufgabe 2).
- **Pan und Send** sind heute je Schritt ein Undo-Schritt (Fakt 6); für „eine Fahrt = ein Schritt“ werden sie `coalesced` (D299).
- **Abgrenzung Nicker (D294):** keine Code- oder Port-Kopplung; virtuelle loopMIDI-Ports der Mackie-Welt sind kein Steuergerät (4E hat schon einmal den falschen Port erwischt).
- **Tool-Plätze:** Nach 4I 28 von 28. 4J und 4K nur noch Erweiterungen (D305).
- **Yoka-Zeit:** Alle Hardware-Schritte in einem Block am Ende; die Werks-CC-Nummern (Annahme 1) prüft die erste Minute, die Profile sind Dateien, Korrekturen brauchen keinen Neubau. Die Xboard-Regler werden in derselben Minute gelernt statt geraten.

### Zeiten (Schätzung je Paket und Ist, für PROCESS.md § Ablauf und Freigaben)

Grundlage der Schätzung (4H Ist): Kernpakete 1–4 h, kleine Pakete unter einer Stunde, ein Volltest in beiden Konfigurationen ≈ 17 min (in den Schätzungen enthalten).

| Paket | Inhalt | Schätzung | Start | Ende | Ist | Quelle |
|---|---|---|---|---|---|---|
| 1 | Python, Bus-Vorarbeiten, Mapping-Kern, MIDI-Eingang, Fork-Patch (3 Aufgaben, 3 Volltests, 2 Reviews) | 4–4,5 h | | | | |
| 2 | Befehle, Lernen, Fokus | 1,5–2 h | | | | |
| 3 | OSC | 1–1,5 h | | | | |
| 4 | MCP-Tool `controllers` | 0,5 h | | | | |
| 5 | UI | 1–1,5 h | | | | |
| 6 | Messskripte, Vergleichs-Build `phase-4h`, Testprojekt | 0,75–1 h (Build seriell ≈ 30 min davon) | | | | |
| **bis Yoka** | Paket 1 bis Ende Paket 6 | **≈ 9–11 h** | | | | |
| 7 | Abnahme: ≈ 20 min Messläufe (Yoka passiv) + ≈ 60 min mit Yoka + ≈ 1 h Doku, Gesamtlauf, Merge | ≈ 2,5–3 h | | | | |
