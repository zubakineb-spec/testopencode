---
name: 1c-testing-verification
description: Шестиступенчатая верификация 1С: static, structural, build, round-trip, runtime и regression.
---

# Verification

## Уровни
1. BSL diagnostics;
2. structural/metadata validation;
3. Designer build;
4. round-trip;
5. runtime smoke;
6. regression against acceptance criteria.

PASS означает наличие доказательств.

## FAIL
Сохранить точную ошибку → определить минимальный дефект → вернуть developer → повторить failed level и все downstream levels → записать итерацию в trace.

## Golden Path
Golden Path является regression baseline. Любое изменение skills, agents, model, permissions, MCP или orchestration требует его повторного запуска.
