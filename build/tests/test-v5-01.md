# Тест EPF GoldenPathV5Smoke — test-v5-01

Вердикт: **PASS**

## 1. BSL-анализ (bsl-language-server)
Файл: `src/GoldenPathV5Smoke/GoldenPathV5Smoke/Forms/Форма/Ext/Form/Module.bsl`
Результат: **0 ошибок, 6 предупреждений** (не блокирующие).

Предупреждения (ложные срабатывания для модуля управляемой формы):
- `UnusedLocalMethod` "ПриОткрытии" — обработчик события OnOpen, связан в `Form.xml` (`<Event name="OnOpen">ПриОткрытии</Event>`).
- `UnusedLocalMethod` "ВыполнитьТест" — действие команды, связано в `Form.xml` (`<Command name="ВыполнитьТест"><Action>ВыполнитьТест</Action></Command>`).
- `UnusedLocalVariable` "СтрокаТеста" (×2) — реквизит формы, объявлен в `Form.xml` (`<Attribute name="СтрокаТеста">`).
- `UnusedLocalVariable` "РезультатСервера" (×2) — реквизит формы, объявлен в `Form.xml` (`<Attribute name="РезультатСервера">`).

BSL Language Server анализирует модуль формы изолированно и не видит связывание реквизитов/обработчиков из Form.xml — все 6 предупреждений являются ожидаемыми ложными срабатываниями, блокирующих дефектов (ParseError, отсутствующие символы, несовместимые типы, нарушение client/server) нет.

## 2. Штатная сборка (Designer) — PASS
Команда: `1cv8.exe DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\goldenpath-v5-build-01.log /LoadExternalDataProcessorOrReportFromFiles src\GoldenPathV5Smoke\GoldenPathV5Smoke.xml build\output\GoldenPathV5Smoke.epf`

Exit code: **0**
Лог: `build/logs/goldenpath-v5-build-01.log` — «Загрузка завершена. Суммарное время выполнения операции: 10619 миллисекунд.»
EPF создан: `build/output/GoldenPathV5Smoke.epf`, размер **6097 байт**.

## 3. Round-trip — PASS
Команда: `1cv8.exe DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\goldenpath-v5-roundtrip-01.log /DumpExternalDataProcessorOrReportToFiles build\output\roundtrip build\output\GoldenPathV5Smoke.epf`

Exit code: **0**
Лог: `build/logs/goldenpath-v5-roundtrip-01.log` — «Выгрузка завершена. Суммарное время выполнения операции: 9849 миллисекунд.»

Файлы выгрузки (соответствуют структуре source):
- `build\output\roundtrip\GoldenPathV5Smoke.xml` (1956 байт)
- `build\output\roundtrip\GoldenPathV5Smoke\Forms\Форма.xml` (1581 байт)
- `build\output\roundtrip\GoldenPathV5Smoke\Forms\Форма\Ext\Form.xml` (3528 байт)
- `build\output\roundtrip\GoldenPathV5Smoke\Forms\Форма\Ext\Form\Module.bsl` (630 байт)

Сравнение с source: содержимое `Module.bsl` идентично после нормализации переводов строк (source LF → Designer round-trip CRLF — канонизация платформы). Маркеры `GOLDEN_PATH_V5_CLIENT_PASS`, `GOLDEN_PATH_V5_SERVER_PASS`, директива `&НаСервереБезКонтекста`, функция `ПолучитьРезультатСервера` присутствуют. Разница в размерах XML — ожидаемая канонизация Designer (ре-сериализация).

## 4. Runtime/UI smoke — NOT_RUN
UI/runtime smoke в headless-среде недоступен (нет интерактивного клиента для открытия управляемой формы). Не блокирует PASS при успешных BSL + сборке + round-trip.

## 5. Технические замечания
- `xr:ClassId` = `c3831ec8-d8d5-4f93-8a22-f9bfae07327f` — корректный фиксированный ClassId хранимого объекта `ExternalDataProcessor` (совпадает с проходящими аналогами GoldenPathSmoke/V2/V3/OpenCodeSmoke), уникальным является `xr:ObjectId` = `36efd414-a8c8-4254-981f-71f3108adb6d`.
- Файл `1c-platforms.json` отсутствует в корне рабочего каталога (платформа задана в AGENTS.md и параметрах задачи). Не влияет на результат сборки.

## 6. Как воспроизвести
1. BSL: `bsl-language-server_analyze_file src/GoldenPathV5Smoke/GoldenPathV5Smoke/Forms/Форма/Ext/Form/Module.bsl` → 0 ошибок.
2. Сборка: команда из п. 2 в рабочем каталоге → `EXIT=0`, EPF 6097 байт.
3. Round-trip: команда из п. 3 → `EXIT=0`, 4 файла, содержимое Module.bsl сохранено.
