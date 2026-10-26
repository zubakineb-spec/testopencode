---
name: 1c-platform
description: Платформенные правила 1С:Предприятие для version-sensitive разработки, XML, Designer и фиксированных идентификаторов.
---

# 1C Platform

## Главный принцип
Платформа 1С и фактический результат Designer имеют приоритет над предположениями модели.

## Правила
- Перед version-sensitive изменениями читать `1c-platforms.json`.
- Не придумывать ClassId, namespace, XML-структуру или семантику Designer.
- Различать GUID объекта и фиксированный ClassId платформенного класса.
- Для EPF/ERF доверять round-trip через Designer больше, чем синтетически сгенерированному XML.
- Ошибка сборки, противоречащая плану архитектора, означает дефект плана/реализации, а не повод игнорировать сборку.

## Gate
inspect → minimal change → Designer build → round-trip → compare.

## Golden Path lesson
`xr:ClassId` у ExternalDataProcessor — фиксированный идентификатор класса, а не новый GUID объекта.

## Sources
Официальное руководство разработчика 1С, v8std.ru, проектный Golden Path.
