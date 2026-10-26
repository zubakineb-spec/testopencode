# Тест EPF GoldenPathV3Smoke — test-v3-02

Вердикт: **PASS**

Tester: 1c-tester (model deepseek-v4-pro)
Date: 2026-08-26
Iteration: 2 (повторная проверка после исправления ClassId)

## 1. BSL-анализ (bsl-language-server)

Файл: `src/GoldenPathV3Smoke/GoldenPathV3Smoke/Forms/Форма/Ext/Form/Module.bsl`
Результат: **0 ошибок, 4 предупреждения** (не блокирующие).

Ложные срабатывания (модуль формы без контекста формы):
- `UnusedLocalMethod` "ПриОткрытии" — обработчик события OnOpen (связан в Form.xml).
- `UnusedLocalMethod` "УстановитьМаркер" — действие команды (связан в Form.xml).
- `UnusedLocalVariable` "СтрокаТеста" (×2) — реквизит формы (объявлен в Form.xml).

## 2. Штатная сборка (Designer) — PASS

Команда: `1cv8.exe DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\goldenpath-v3-build-02.log /LoadExternalDataProcessorOrReportFromFiles src\GoldenPathV3Smoke\GoldenPathV3Smoke.xml build\output\GoldenPathV3Smoke.epf`

Exit code: **0**
Лог: `build\logs\goldenpath-v3-build-02.log`
Ключевая строка лога (дословно):
```
Загрузка завершена. Суммарное время выполнения операции: 15149 миллисекунд.
```
EPF создан: `build\output\GoldenPathV3Smoke.epf`, размер **5924 байт**.

## 3. Round-trip — PASS

Команда: `1cv8.exe DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\goldenpath-v3-roundtrip-02.log /DumpExternalDataProcessorOrReportToFiles build\output\roundtrip build\output\GoldenPathV3Smoke.epf`

Exit code: **0**
Лог: `build\logs\goldenpath-v3-roundtrip-02.log`
Ключевая строка лога (дословно):
```
Выгрузка завершена. Суммарное время выполнения операции: 9839 миллисекунд.
```

Файлы round-trip (ожидаемо 4, фактически 4):
1. `build\output\roundtrip\GoldenPathV3Smoke.xml` (1956)
2. `build\output\roundtrip\GoldenPathV3Smoke\Forms\Форма.xml` (1581)
3. `build\output\roundtrip\GoldenPathV3Smoke\Forms\Форма\Ext\Form.xml` (2629)
4. `build\output\roundtrip\GoldenPathV3Smoke\Forms\Форма\Ext\Form\Module.bsl` (312)

Контроль идентификаторов после round-trip:
- `xr:ClassId` = c3831ec8-d8d5-4f93-8a22-f9bfae07327f (совпадает с планом и 4 sibling EPF)
- `uuid` = 798ed456-d5b5-4810-887f-680520bba90e (совпадает с исходником)
- `xr:ObjectId` = 01216d0a-904a-4f2f-ae41-de922dc97885 (совпадает с исходником)
- `Name` = GoldenPathV3Smoke

## 4. Проверка исправления дефекта итерации 1

Итерация 1: сборка exit 1 — «Неверный идентификатор класса хранимого объекта» на узле `xr:ContainedObject/xr:ClassId` (значение a07cb786-f338-4c5b-a987-212f70d52f07).

Итерация 2: `xr:ClassId` = c3831ec8-d8d5-4f93-8a22-f9bfae07327f. Сборка exit 0, round-trip exit 0. Дефект устранён.

## 5. Как воспроизвести (PASS-проверка)

1. Выполнить команду сборки из п. 2.
2. Наблюдать `EXIT=0`, EPF создан (5924 байт).
3. Выполнить команду round-trip из п. 3.
4. Наблюдать `EXIT=0` и 4 файла выгрузки.

## Contract

TEST_STATUS: PASS
ITERATION: 2
VERIFICATION_LEVELS:
  - 1. BSL diagnostics: 0 errors, 4 warnings (non-blocking)
  - 2. Designer build: EXIT=0, EPF 5924 bytes
  - 3. Round-trip: EXIT=0, 4 files
BUILD_EXIT_CODE: 0
ROUNDTRIP_EXIT_CODE: 0
CLASSID: c3831ec8-d8d5-4f93-8a22-f9bfae07327f
BLOCKING_DEFECTS: 0
FAIL_REASON: —
EVIDENCE:
  - build\logs\goldenpath-v3-build-02.log: «Загрузка завершена…»
  - build\output\GoldenPathV3Smoke.epf: EXISTS, 5924 bytes
  - build\logs\goldenpath-v3-roundtrip-02.log: «Выгрузка завершена…»
  - build\output\roundtrip\GoldenPathV3Smoke*: 4 файла
  - roundtrip ClassId = c3831ec8-d8d5-4f93-8a22-f9bfae07327f (совпадает с планом)
SKILLS_USED: 1c-build-epf, 1c-testing, 1c-platform, 1c-metadata-engineering,
  1c-bsl-engineering, 1c-managed-form-engineering, 1c-epf-erf-engineering,
  1c-query-skd, 1c-testing-verification, 1c-ai-tooling
RECOMMENDATION: RELEASE
FINAL_TEST_REPORT: Блокирующий дефект итерации 1 устранён: xr:ClassId приведён
  к фиксированной платформенной константе c3831ec8-d8d5-4f93-8a22-f9bfae07327f.
  Официальная сборка Designer (exit 0, EPF 5924 байт) и round-trip (exit 0,
  4 файла) прошли успешно. ClassId/uuid/ObjectId/Name сохранены после round-trip.
  BSL — 0 ошибок (4 неблокирующих предупреждения). GoldenPathV3Smoke готов.
