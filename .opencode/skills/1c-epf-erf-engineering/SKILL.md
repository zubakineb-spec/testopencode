---
name: 1c-epf-erf-engineering
description: Полный инженерный цикл EPF/ERF: XML, формы, модули, сборка Designer и round-trip.
---

# EPF / ERF

## Цикл
inspect → model → edit → static validation → Designer build → round-trip → review → test.

## EPF
Сохранять canonical XML, namespace и идентификаторы. Не генерировать заново фиксированные платформенные ClassId.

## ERF
Не считать XML EPF и ERF взаимозаменяемыми; проверять report-specific metadata и MainDataCompositionSchema.

## Ограничение
Developer меняет только разрешённый `src/**`. Конфигурацию OpenCode, skills, AGENTS.md и платформенные настройки не изменять.

## Build gate
Артефакт не считается готовым, пока установленный Designer не принимает его.
