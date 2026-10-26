---
name: 1c-ai-tooling
description: Политика интеграции AI tooling для 1С: skills, BSL LS, metadata MCP, live-IB MCP и provenance.
---

# AI Tooling

## Слои
- Skills = методология.
- BSL LS = статический интеллект BSL.
- Metadata MCP = исследование структуры ИБ.
- Live-IB MCP = данные/runtime evidence.
- Designer = authority для сборки EPF/ERF и XML-артефактов.

## MCP
По умолчанию discovery read-only. Отдельно контролировать metadata, queries, code execution и write operations.

Инструмент `execute_code` не считать read-only инструментом.

## Upstream skills
Не копировать upstream skill packs целиком. Извлекать методологию в project-native skills и сохранять проектные permission/build/test правила.

## Provenance
Для каждого существенного заимствования фиксировать upstream source, purpose и project-specific adaptation.
