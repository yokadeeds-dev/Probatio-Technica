# Probatio Technica (PTc)

Nur lesendes Prüfwerkzeug für Software-Pläne, als Claude-Code-Subagent. PTc prüft einen Plan oder eine halb umgesetzte Unterphase über alle Ebenen – von der einzelnen Operation bis zur Prozessebene – und liefert PASS/FAIL mit einer konkreten Korrekturliste. Keine Punktzahl.

- **Ebenen:** Operation · Komponente · Schnittstelle · System · Prozess
- **Querachsen:** Nebenläufigkeit · Lebenszyklus · Ressourcen (CPU, RAM, Platte, Thread-Zeit, Latenz, Kontingente) · Fehlerarten
- **Werkzeuge:** Schnittstellen-Matrix · Abwärts-/Aufwärts-Operator · Plan gegen Ist
- **Quellen-Bindung:** jede Aussage hat eine Belegklasse (verankert, Selbstauskunft, Test/Messung, unverifiziert)

Abgeleitet aus MiMaMa v1.1 (Vor-Linse der Probatio-Familie), aber eigenständig.

## Benutzung

```powershell
.\scripts\check.ps1    # statische Prüfung
.\scripts\deploy.ps1   # nach ~/.claude/agents/ptc.md kopieren
```

In Claude Code als Subagent `ptc`:

| Befehl | Wann | Modell |
|---|---|---|
| `PTc:PLAN <Plan>` | nach dem Detailplan, vor der Umsetzung | Opus |
| `PTc:IST <Plan>` | mitten in der Unterphase oder vor der Abnahme | Sonnet |
| `PTc:VERIFY <Karte>` | Befunde nachprüfen | Sonnet |
| `PTc:LITE <Plan>` | kleine Pläne | Sonnet |

Stand und Planung: `docs/PHASE_1_PLAN.md`. Regeln: `CLAUDE.md`, `docs/PROCESS.md`.
