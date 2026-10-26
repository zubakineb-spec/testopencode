# Configurator lock resolution 01

The user explicitly authorized termination of the blocking local Configurator session.

Verified process:

- PID: `6156`
- Process: `1cv8`
- Started: `19.08.2026 11:08:39`
- Window: an external processor opened in Configurator.

Command result: `Stop-Process -Id 6156` failed with Windows `Access denied`.

No privilege escalation or security bypass was attempted. The session must be closed by its owner or from an elevated session.
