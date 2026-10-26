# Тест GoldenPathSmoke — 1c-tester (итерация 1)

Вердикт: FAIL (сборка)

1. BSL LS статический анализ Module.bsl: PASS (0 Error; 1 Warning UnusedLocalMethod — ложное, 2 Info).
2. Кодировка: PASS (все 4 файла UTF-8 без BOM, LF).
3. Штатная сборка: FAIL — exit 1, EPF не создан.
   Ошибка: "Неверный идентификатор класса хранимого объекта" для xr:ClassId=31471234-4484-4dda-a3b4-8b6a9c006b15.
   Причина: <xr:ClassId> — фиксированная платформенная константа c3831ec8-d8d5-4f93-8a22-f9bfae07327f
   (одинакова у OpenCodeSmoke и BPV_AccessToCorrespondence), а не per-object GUID.
4. Round-trip: не выполнялся (нет EPF).

Фикс: установить <xr:ClassId> = c3831ec8-d8d5-4f93-8a22-f9bfae07327f.