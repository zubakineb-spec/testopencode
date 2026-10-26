---
name: 1c-bsl-engineering
description: Инженерная разработка BSL с BSL Language Server, контролем контекста выполнения и client/server границ.
---

# BSL Engineering

## До изменения
- прочитать окружающий модуль;
- исследовать symbols/references/definition;
- определить client/server context;
- проверить существующие процедуры и функции.

## После изменения
1. BSL LS diagnostics;
2. targeted symbols/references;
3. reviewer;
4. Designer build для артефактов;
5. runtime smoke при наличии среды.

## Blocking defects
ParseError, отсутствующие символы, некорректные client/server вызовы и несовместимые типы — блокирующие дефекты.

Не подавлять диагностику ради PASS.
