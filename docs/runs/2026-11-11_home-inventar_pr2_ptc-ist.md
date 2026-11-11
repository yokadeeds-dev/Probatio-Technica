# Lauf 2026-11-11 · home-inventar PR #2 und #1 · PTc:IST im Vergleich mit Code-/Security-Review (D40)

| Feld | Wert |
|---|---|
| Datum | 2026-11-11, Start 19:31 (beide Läufe parallel) |
| Projekt | home-inventar (GitHub `yokadeeds-dev/home-inventar`, privat), Klon im Scratchpad dieser Session; das Projekt-Repo wurde nicht verändert |
| Objekt | PR #2 `claude/home-inventar-bewertung-593c2a` (`92a5287`, +680/−281, 25 Dateien) und PR #1 `fix/express-dep-und-pfade` (`f2bf91d`), beide offen gegen `main` `2e5229e`. Plan-Ersatz: beide PR-Beschreibungen (die „Entwicklungsstand-Bewertung vom 2026-11-10“ liegt nicht als Datei vor) |
| Werkzeug | **PTc v1.1.0** (deployt, byte-gleich mit `agent/ptc.md`) |
| Modus | `PTc:IST` |
| Modell | Sonnet 5.5 für beide Läufe (D7: IST mit Sonnet; gleiches Modell für einen fairen Vergleich) |
| Token / Dauer / Aufrufe | PTc: **143 133** Token, 217 s, 35 Aufrufe · Review: **146 424** Token, 171 s, 29 Aufrufe (Agent-Abrechnung) |
| Art | **Vergleichslauf, kein Vorhersagetest** (D14: Umsetzung lag vor); zählt nicht für D8 (D40) |
| Gegenlauf | `general-purpose`-Subagent (Sonnet), Auftrag „Code- und Security-Review vor dem Merge“, gleiches Material (Diffs, Checkouts, PR-Beschreibungen), nur Read/Grep/Glob, keine PTc-Interna |

## Ergebnis

| | PTc:IST | Review |
|---|---|---|
| Urteil | beide PRs gemeinsam **FAIL** (2 HART aus dem Zusammenspiel); PR #2 allein PASS nach K2–K4; PR #1 überholt | PR #2 „mergen nach Korrekturen“; PR #1 „nicht mergen“ |
| Befunde | 2 HART, 8 LECK, 3 SYNC, 8 Korrekturen, 4 Messaufgaben, 4 offene Fragen | 3 hoch, 4 mittel, 5 niedrig (12) |

## Vergleich (Auswertung der Session)

| Thema | PTc | Review |
|---|---|---|
| PR #1 gegen PR #2: Platzhalter, Variablennamen, Modify/Delete, PR #1 schließen | HART 1 (mit stillem Autostart-Defekt bei Merge-Reihenfolge PR1 → PR2) | M5 |
| `config.js`-Rückfall auf `localhost` | HART 2 | M6 |
| CORS spiegelt jeden Origin ohne Token | LECK 3 | H1 (**zusätzlich DNS-Rebinding, Host-Header-Prüfung**) |
| Rollout Handy (Bind, Token, alte APK) | LECK 1 | H2 (**zusätzlich: laufender Task mit `IgnoreNew` muss beendet werden**) |
| Migration ohne Sperre, zwei Prozesse | LECK 2 | M4 |
| Compose-Split entzieht Provolution Env und Mount | LECK 5 | H3 |
| `data/inventory.db` fehlt → Docker legt Ordner an | LECK 7 | H3 (Folgepunkt) |
| n8n-Workflow ohne Token | LECK 6 | N10 |
| Tests nicht hermetisch, kein Bind-/CORS-Test | LECK 8 | N11 |
| `HOST` als Variablenname | Hypothese unter Fehlerarten | N8 (dazu IPv4-only, Klartext-Token im LAN) |
| doppelter `engines`-Key | als Hypothese, kein Befund | M5 |
| **nur PTc:** Backup und Migrationsprobe an einer Kopie der Produktiv-DB | LECK 4 | – |
| **nur PTc:** HILFE.md nennt weiter den n8n-Webhook | SYNC 3 | – |
| **nur PTc:** Plan gegen Ist der Beschreibung (0 Abweichungen, Behauptungen als V/S markiert), Messaufgaben mit Grenzen | ja | – |
| **nur Review:** `install-autostart.ps1` ohne Platzhalter-Prüfung und XML-Escape | – | M7 |
| **nur Review:** Token in URLs (`?token=`), Token im APK-Bundle | – | N9 |
| **nur Review:** Actions auf Major-Tags, `after()` wartet nicht auf Prozessende | – | N11, N12 |

**Deckung:** 11 Themen von beiden gefunden, mit gleicher Richtung und im Kern gleichem Urteil. **Nur PTc:** 3 (Backup/Migrationsprobe, Doku-Drift, Messaufgaben). **Nur Review:** 4 (Skript-Robustheit, Token in URLs, CI-Pinning, Test-Abbau) plus zwei Vertiefungen (DNS-Rebinding, `IgnoreNew`).

**Einordnung:**
- Bei einem PR mit Rollout-Anteil liefern beide fast dasselbe. Das Review ist stärker bei Sicherheitsdetails und Skript-Robustheit, PTc bei Betrieb und Nachweis (Backup vor der Migration, Messaufgaben mit Grenzen, Kennzeichnung V/S, Plan-gegen-Ist der Beschreibung).
- Der einzige PTc-Befund mit möglichem Datenschaden ohne Gegenstück im Review ist LECK 4 (keine Migrationsprobe an der Produktiv-DB).
- Kosten: praktisch gleich (PTc 143 133 Token / 217 s, Review 146 424 Token / 171 s); unter dem 4K-PLAN-Lauf mit Opus (168 504).
- Folgerung für Phase 1/2: Für fertige PRs ohne eigenen Plan ersetzt PTc:IST kein Review und ein Review kein PTc vollständig; einer von beiden plus die Messaufgaben/den Backup-Schritt aus PTc reicht. Den Mehrwert von PTc belegen weiter nur Vorhersagetests (D14).

## Für die Inventar-Session (nicht weitergegeben, Änderungen dort nur durch deren Session, D13)

Vereinigte Korrekturliste vor dem Merge: PR #1 schließen · `config.js` ohne stillen `localhost`-Rückfall · Migration mit `BEGIN IMMEDIATE`, Version in der Transaktion, `timeout` · CORS ohne Token nicht spiegeln, Host-Header prüfen · Rollout-Reihenfolge (APK mit EAS-Variablen → Token → Server-Neustart inkl. Task beenden → `install-autostart.ps1`) · `COMPOSE_FILE` mit Provolution-Override · DB-Backup und Migrationsprobe an der Kopie · `install-autostart.ps1` absichern · Tests hermetisch, Bind-/CORS-Tests · Hinweis „DB-Datei muss existieren“ zurück · n8n-Workflow/HILFE.md angleichen.

---

## Karte PTc:IST (wörtlich, Rückgabe des Subagenten `ptc`)

```text
PTc-KARTE · 2026-11-11

OBJEKT  : Home-Inventar, PR #2 (Branch pr2, 92a5287) und PR #1 (f2bf91d), beide gegen main 2e5229e, plus Zusammenspiel
MODUS   : IST (Plan-Ersatz = PR-Beschreibungen, vor Merge und Rollout)
STAND   : beide PRs offen, nicht gemergt
PRÄMISSE: geklärt. Der Plan ist die PR-Beschreibung. Keine PROCESS.md und keine Entscheidungsliste, daher kein Drift gegen ein Register, nur Beschreibung gegen Diff und Code.

HERKUNFT
  Gelesen: inv_plan.md komplett. pr1.diff komplett. pr2.diff Zeilen 1-560 und 700-1375 (schema.js nur über den Checkout). Im Checkout pr2: lib/schema.js, webhook-server.js, init-db.js, task.xml, launch-hidden.vbs, start-inventory-server.cmd, eas.json, mobile-app/.gitignore, .gitignore, mobile-app/lib/api.js (Grep), Treffer-Grep auf index.js, den n8n-Workflow und public/app.js. Grep auf Pfade und kachi in beiden Checkouts.
  Nicht gelesen: git log, Quellcode von index.js im Detail, Mobile-App-Screens, Produktiv-DB und Produktiv-.env, Tests wurden nicht ausgeführt, kein `git merge` zur Konfliktprüfung (nur lesender Zugriff).
  V (Beispiele): webhook-server.js:842 `const HOST = process.env.HOST?.trim() || (AUTH_TOKEN ? '0.0.0.0' : '127.0.0.1');`. schema.js:126 `const from = db.prepare('PRAGMA user_version').get().user_version;` liegt vor `db.exec('BEGIN')` in Zeile 131. task.xml:37 `__MCP_SERVER_DIR__`. pr1.diff:51 README `.Replace('__REPO_DIR__', …)`. pr1.diff:181 `|| 'http://192.168.178.106:3456'` gegen pr2.diff:1295 `|| 'http://localhost:3456'`.
  S: "8/8 grün (Node 24)", "init-db/migrate/index starten gegen leere DB", "`./data/inventory.db` entspricht dem bisherigen Pfad", "`kachi` kommt im Repo nicht mehr vor". Das Zählen der 8 Tests (5 API + 3 Schema) bestätige ich am Code (V). Das Grün-Ergebnis bleibt S. Die kachi-Aussage stimmt in beiden Checkouts (Grep, V).
  [UNVERIFIZIERT]: Commit `c177063` in project_status.md. EAS-Verhalten von `--visibility sensitive` bei EXPO_PUBLIC_-Variablen. Ob der Build-Profil-Name `preview` automatisch die EAS-Umgebung `preview` wählt (eas.json hat kein `environment`-Feld). Ob das Repo real unter `…/Asset Management System` liegt.
  Degradiert: siehe Offene Fragen.

EBENEN
  Nano : migrate() läuft pro Migration in einer Transaktion mit Rollback und wirft bei zu neuer Version. Fail-closed, gut. Aber siehe LECK 2.
  Mikro: schema.js ist klar geschnitten. 3 Schema-Tests (frisch, Altbestand, zu neu) können bei kaputter Migration rot werden. 5 API-Tests. Die Bind-Logik (Kernänderung Sicherheit) hat keinen Test, die Tests setzen immer HOST=127.0.0.1 und ein Token.
  Meso : Meta-Befunde dominieren (PR1 gegen PR2, README gegen XML). Dazu CORS/Auth-Grenze, Docker-Compose-Split, Mobile-Config gegen Server-Bind.
  Makro: Ziel "portabel und abgesichert" wird erreicht, kostet aber einen koordinierten Rollout: Server, Token, APK-Neubau, Task-Neuregistrierung, Compose-Aufruf. Es gibt keinen Rückfallweg für die alte APK (HART 2/LECK 1).
  Meta : zwei offene PRs mit überlappendem Gegenstand und widersprüchlichen Festlegungen. PR #2 ist erklärtermaßen Obermenge von PR #1.

SCHNITTSTELLEN-MATRIX
| A | B | Vertrag benannt? | Test über Grenze? | Weg vorbei? | Befund |
|---|---|---|---|---|---|
| PR1 | PR2 | nein | nein | gleiche Dateien, andere Festlegungen | HART 1, SYNC 2 |
| Server-Bind | Handy-APK | ja, in Rollout-Hinweisen | nein | alte APK sendet kein Token (401) oder erreicht nichts | LECK 1 |
| Server-Auth/CORS | Browser fremder Origin | teils | CORS-Test nur Header | Ohne Token reflektiert CORS jeden Origin | LECK 3 |
| webhook-server | index.js (MCP) | gemeinsam schema.js | nein | beide migrieren beim Start | LECK 2 |
| Autostart-Task | install-autostart.ps1 | ja (PR2) | nein | README aus PR1 nutzt anderen Platzhalter | HART 1 |
| compose | compose.provolution | ja | nein | `docker compose up -d` ohne Override entzieht n8n Env und Mount | LECK 5 |
| n8n-Workflow | Server /inventory | nein | nein | Workflow sendet kein Token, URL `localhost:3456` im Container | LECK 6 |
| Scanner | Server | ja | nur py_compile | kein Test mit Token | kein Befund (Default localhost passt zum Bind) |
| compose | data/inventory.db | Kommentar PR1, in PR2 entfallen | nein | Docker legt Ordner an | LECK 7 |

QUERACHSEN
  Nebenläufigkeit: zwei Prozesse (webhook-server, MCP-index.js von Claude Desktop) öffnen dieselbe DB und migrieren beide beim Start. Siehe LECK 2. Sonst keine neuen Thread-Fragen.
  Lebenszyklus : Update/Migration der Produktiv-DB nur synthetisch getestet ("Nicht getestet: echte Produktiv-DB", S). Ein Backup vor der ersten Migration steht nirgends. Autostart: alter Task zeigt auf den alten Pfad, Neuregistrierung per `/F` ist überschreibend (V). Container-Recreate bei `docker compose up -d` bricht einen laufenden n8n-Job ab (Zustandskreuz, klein). Rollback auf main-Code ist unkritisch, `user_version` wird dort ignoriert.
  Ressourcen   : keine Grenze, auf die der Plan sich stützt (kein Muss-Kriterium, kein Akzeptanztest, keine Folgephase). Nach § 2.3 daher kein Befund. Notiz: `inventory_log` und `scan_events` wachsen ohne Aufräumregel (nicht Teil der PRs). Temp-DB und Temp-Datei der Tests und des Installers werden aufgeräumt (V).
  Fehlerarten  : Teilfehler bei Migration abgedeckt (Rollback). Abhängigkeit fehlt: fehlende DB-Datei führt bei compose zum Ordner (LECK 7). Konflikt der Kennung: `HOST` ist ein generischer Variablenname (Hypothese, auf Windows meist ungesetzt).

PLAN-GEGEN-IST
  Drift Beschreibung gegen Code, PR #2: 0 harte Abweichungen. Geprüft und bestätigt: 6 Tools, `HOST`-Logik, CORS ohne Credentials mit PUT, `--token` im Scanner, Migrationen 1-3, `openDatabase` in allen vier Einstiegen, Task-Platzhalter, install-autostart.ps1, 8 Tests.
  Kleine Abweichung Beschreibung gegen Doku: HILFE.md nennt weiter `POST http://localhost:5678/webhook/inventory` (HILFE.md:182) direkt vor dem umgeschriebenen Tool-Ablauf, während die Beschreibung n8n als optional einstuft (SYNC 3).
  Gewanderte Falschaussagen: PR1 schreibt in README und `.env.example` `YOKA_WORKSPACE`, PR2 `YOKA_WORKSPACE_PATH`. Sobald PR1 zuerst gemergt wird, steht die falsche Variable in der Doku (SYNC 2).
  Leere Tabellen, tote Lernkreise, Regelkonflikte: nicht anwendbar (keine Prozessdatei).

KONSISTENZ
HART:
 1. Merge-Reihenfolge PR1 vor PR2 erzeugt einen stillen Defekt (V gegen V). PR1-README (pr1.diff:51) ersetzt `__REPO_DIR__` und registriert den Task per `Register-ScheduledTask -Xml`. PR2 benennt den Platzhalter in `__MCP_SERVER_DIR__` um (task.xml:37). Wer nach dem Merge dem PR1-README folgt, registriert einen Task mit dem Pfad `__MCP_SERVER_DIR__\launch-hidden.vbs`. Der Task meldet Erfolg und startet beim Login nichts. Gleiche Konfliktklasse: `<REPO_PFAD>` gegen `<PROJEKTPFAD>`, `YOKA_WORKSPACE` gegen `YOKA_WORKSPACE_PATH` (setzt jemand die PR1-Variable, fällt compose still auf `C:/yoka-workspace` zurück), und `mcp/claude_desktop_config.json` wird von PR1 geändert und von PR2 gelöscht (Modify/Delete). Reichweite ARCHITEKTURPRÄGEND.
 2. config.js: PR1 behält den Fallback `http://192.168.178.106:3456` ("damit APK-Builds ohne .env wie bisher laufen"), PR2 setzt `localhost` (pr2.diff:1295). Die beiden PRs verlangen sich gegenseitig ausschließende Zustände. Bei PR2 zeigt ein Build ohne EAS-Variablen still auf die localhost des Handys, ohne Build-Fehler. Beschrieben, aber ohne technische Sperre. Reichweite QUERSCHNITTLICH.
 (package.json: beide PRs fügen `express` und `engines` an unterschiedlichen Stellen ein. Ob Git das sauber oder als doppelter `engines`-Key zusammenführt, ist Hypothese; kein Merge versucht.)

LECK:
 1. Rollout-Lücke Handy. Ohne Token bindet der Server nur 127.0.0.1 (V). Die installierte APK hat Token '' und feste IP (main config.js, V). Setzt man ein Token, sendet die alte APK keins und bekommt 401. Setzt man keins, ist der Server aus dem LAN weg. Funktionierender Weg: `HOST=0.0.0.0` ohne Token oder Token plus neu gebaute APK. Der Hinweis steht in der Beschreibung, aber ohne Reihenfolge und ohne Rückfall. Korrektur: Rollout-Reihenfolge in der PR-Beschreibung festlegen (zuerst APK mit EAS-Variablen bauen und testen, dann Token setzen), und in config.js einen Build-Fehler oder auffälligen Hinweis bei fehlendem `EXPO_PUBLIC_API_BASE`. LOKAL/QUERSCHNITTLICH.
 2. Migration ohne Sperre. `PRAGMA user_version` wird vor `BEGIN` gelesen (schema.js:126 gegen 131) und es gibt weder `BEGIN IMMEDIATE` noch ein busy_timeout (Grep: kein Treffer). webhook-server und index.js starten unabhängig voneinander und migrieren beide auf einer DB mit Version 0. Heute sind 1-3 idempotent, nur deshalb unkritisch. Die Regel in der Datei ("nur neue Einträge am Ende") garantiert aber nicht, dass spätere nicht-idempotente Migrationen doppelt laufen, und der zweite Prozess kann bei SQLITE_BUSY abbrechen. Korrektur in schema.js: Version innerhalb `BEGIN IMMEDIATE` lesen, busy_timeout setzen, Test mit zwei parallelen Prozessen. Reichweite QUERSCHNITTLICH.
 3. CORS ohne Token. `CORS_ORIGINS` leer reflektiert jeden Origin (webhook-server.js:163-167), `application/json` löst Preflight aus, der für jeden Origin gelingt. Läuft der Server ohne Token (Standardfall des neuen Localhost-Binds), kann jede Webseite im Browser des Nutzers die API lesen und schreiben, inklusive Gemini-Aufrufen. "Nur localhost" gilt für Netzwerkgeräte, nicht für Websites. Korrektur: ohne Token CORS nicht reflektieren (oder nur localhost-Origins), plus Test für den Zweig. Reichweite LOKAL.
 4. Kein Backup und keine Migrationsprobe an der Produktiv-DB (Beschreibung: "Nicht getestet: echte Produktiv-DB"). Die Gitignore führt `data/*.db.backup-*`, die Praxis existiert also. Korrektur: Rollout-Schritt "DB-Datei samt -wal/-shm kopieren, Kopie durch `node migrate.js` mit `DB_PATH` laufen lassen" in den PR aufnehmen. LOKAL.
 5. Compose-Split. Nach `docker compose up -d` ohne Override wird der n8n-Container ohne GITHUB_TOKEN, MONITOR_*, `/yoka-workspace`-Mount und `NODE_FUNCTION_ALLOW_BUILTIN` neu erzeugt; die laufende Provolution-Cron-Pipeline schlägt danach still fehl. Der Hinweis steht in der Beschreibung, es gibt aber keinen Schutz (kein `.env`-Eintrag `COMPOSE_FILE`, kein Skript). Korrektur: `COMPOSE_FILE=docker-compose.yml;docker-compose.provolution.yml` in die produktive `.env` dokumentieren. LOKAL.
 6. n8n-Workflow `workflow-inventory-webhook.json:32` ruft `http://localhost:3456/inventory` ohne Token-Header (V). Im Container ist localhost der Container selbst (S, vor den PRs bereits so), mit gesetztem Token kommt zusätzlich 401. Beschreibung bezeichnet n8n als optional, daher kein Blocker. Eintrag in offene Punkte oder Workflow anpassen. LOKAL.
 7. PR2-compose-Kommentar verliert den Hinweis aus PR1, dass `data/inventory.db` vor dem Start existieren muss (sonst legt Docker einen Ordner an und der Server kann die DB nicht öffnen). Gegen das Portabilitätsziel auf frischem Rechner. Korrektur: Hinweis zurück in docker-compose.yml, oder Start über `npm run init-db` in der README vor compose ordnen. LOKAL.
 8. Tests: nicht hermetisch. Der `.env`-Loader überschreibt leere Werte (`!process.env[...]`, `GEMINI_API_KEY: ''` zählt als ungesetzt). Steht in der echten `.env` `CORS_ORIGINS`, schlägt der CORS-Test fehl. Dazu fehlt ein Test für den Bind ohne Token/HOST (Kernänderung Sicherheit) und für den CORS-Allowlist-Zweig. Korrektur: Test-Env um `CORS_ORIGINS: ''` ergänzen, Bind-Test ergänzen. LOKAL.

SYNC:
 1. PR2 `.env.example` führt `YOKA_WORKSPACE_PATH` im Provolution-Block, PR1 `YOKA_WORKSPACE` (siehe HART 1).
 2. Nach PR1-vor-PR2-Merge stehen widersprüchliche Doku-Zeilen in README, `.env.example` und mobile-app/README (zwei Task-Platzhalter, zwei Variablennamen).
 3. HILFE.md:182 nennt den n8n-Webhook als Endpunkt neben dem MCP-Tool-Ablauf.

OFFENE FRAGEN (je mit fehlender Quelle)
 - Liegt das Repo real unter dem bisherigen Pfad, sodass `./data/inventory.db` "dem bisherigen Pfad entspricht"? Quelle: Pfad der Produktiv-Installation und `.env`.
 - Akzeptiert `eas env:create --visibility sensitive` Variablen mit EXPO_PUBLIC_-Präfix, und wählt Profil `preview` die Umgebung `preview`? Quelle: EAS-Dokumentation oder ein Probelauf. Hinweis: EXPO_PUBLIC_-Werte landen im Bundle, das steht in PR1 (V).
 - Ist in der Produktiv-.env bereits ein `INVENTORY_TOKEN` gesetzt? Quelle: Produktiv-.env (bestimmt, wie hart LECK 1 trifft).
 - Existiert Commit `c177063`? Quelle: git log.

OPERATOREN
  Abwärts: Jetzt: PR1 schließen oder auf PR2 rebasen (PR2 ist Obermenge, siehe HART 1). Aus PR1 in PR2 übernehmen: den Fallback in config.js (oder einen Build-Fehler, HART 2) und den compose-Hinweis (LECK 7). Bis zum Merge: LECK 2, 3, 8 im Code korrigieren. Bis zur Abnahme: Rollout-Reihenfolge und Backup-Schritt (LECK 1, 4, 5) in die PR-Beschreibung. Ab nächster Änderung: neue Migrationen nur mit Sperre und Zwei-Prozess-Test.
  Aufwärts (Hypothese): Bei jeder weiteren Migration verschärft sich LECK 2, weil dann nicht-idempotente Schritte hinzukommen. Datenwachstum: `inventory_log` und `scan_events` ohne Aufräumregel; ein Jahr Nutzung belastet die Tabellen voraussichtlich nicht, die Embedding-Bilder in `items.image` eher (nicht Teil der PRs).

VORENTSCHEIDUNG
  Beide PRs gemeinsam: FAIL (HART 1 und 2, V gegen V, beide aus dem Zusammenspiel).
  PR #2 allein, PR #1 geschlossen oder verworfen: kein HART im Code. PASS nach Abarbeiten von Korrekturen 2-4, sinnvollerweise vor dem Merge.
  PR #1 allein: unproblematisch, aber durch PR #2 überholt.

KORREKTURLISTE (priorisiert)
 1. PR #1 verwerfen oder PR #2 zuerst mergen und PR #1 neu aufsetzen (Platzhalter, Variablennamen, claude_desktop_config, config.js, README) — verhindert den stillen Autostart-Defekt — ARCHITEKTURPRÄGEND.
 2. mobile-app/config.js (PR2): Rückfall `192.168.178.106` aus PR1 übernehmen oder bei fehlendem `EXPO_PUBLIC_API_BASE` im Release-Build abbrechen — verhindert APK auf localhost — QUERSCHNITTLICH.
 3. mcp-server/lib/schema.js:126-139: Version innerhalb `BEGIN IMMEDIATE` lesen, busy_timeout setzen, Test mit zwei Prozessen — verhindert Doppellauf und Abbruch — QUERSCHNITTLICH.
 4. mcp-server/webhook-server.js:159-171: ohne Token CORS nicht für beliebige Origins öffnen, plus Test — LOKAL.
 5. PR-Beschreibung/README: Rollout-Reihenfolge (APK mit EAS-Variablen, Token, Task neu registrieren, `COMPOSE_FILE` mit Provolution-Override setzen) und DB-Backup samt Migrationsprobe als Schritt — LOKAL.
 6. docker-compose.yml: Hinweis "DB-Datei muss vor dem Start existieren" zurück — LOKAL.
 7. mcp-server/test/api.test.js: `CORS_ORIGINS: ''` setzen, Bind-Test ohne Token und HOST, CORS-Allowlist-Test — LOKAL.
 8. HILFE.md:182 und n8n/workflow-inventory-webhook.json:32: Endpunkt und Token-Header angleichen oder als offener Punkt vermerken — LOKAL.

VORGESCHLAGENE MESSAUFGABEN
 - Kopie der Produktiv-DB (inkl. -wal) durch `node migrate.js` mit `DB_PATH=<Kopie>` laufen lassen. Erwartet: "Migration 0 → 3", Zeilenzahlen von items/locations/inventory_log unverändert. Danach `npm test`.
 - webhook-server und index.js gleichzeitig gegen eine Version-0-DB starten (Skript, 20 Wiederholungen). Grenze: kein Abbruch, `user_version`=3.
 - Zugriff von einer fremden Webseite (Origin `http://example.test`, Content-Type JSON) gegen Server ohne Token: erwartet kein Allow-Origin-Header.
 - Phone-Test mit neu gebauter APK gegen den Server mit Token, vor dem Umschalten des Produktiv-Servers.

SELBST-FALSIFIKATION: HART 1 (Platzhalter) und HART 2 (Fallback) stützen sich auf zwei gelesene Diffs und die Beschreibungen (V gegen V), nicht auf Hypothesen. Die Behauptung "doppelter `engines`-Key" ist als Hypothese gekennzeichnet und kein Befund. LECK 2 hängt am Code (schema.js:126/131) und der fehlenden busy_timeout-Treffer. LECK 3 ist am Code verankert. LECK 5 stützt sich auf die gelesenen Compose-Dateien, das Container-Verhalten selbst ist S. LECK 6 ("localhost im Container") ist vor den PRs bereits so und S.

EINSCHRÄNKUNGEN: kein Test, kein Merge, kein Docker-Lauf. pr2.diff Zeilen 560-700 (schema.js-Diff) nicht gelesen, dafür der Checkout-Stand. Index.js nur per Grep. Die Aussage "PR #2 ist Obermenge von PR #1" folgt aus den Beschreibungen und den gelesenen Diffs, nicht aus einem Git-Vergleich.
```
