TEST_STATUS: PASS

# Тест сборки двух внешних обработок настройки интеграции — test-integration-02

Вердикт: **PASS** (после добавления кнопок/полей форм).

## 1. BSL-анализ (bsl-language-server) — критерий «0 Error» выполнен

- `src/БПВ_НастройкаИнтеграцииБПДО_JKX/БПВ_НастройкаИнтеграцииБПДО_JKX/Forms/Форма/Ext/Form/Module.bsl` — **0 Error**, всего 12 диагностик (не блокирующие: 3 Warning UnusedLocalMethod, 2 Information NestedFunctionInParameters, 3 Information LineLength, 3 Hint Typo, 1 Information DuplicateStringLiteral).
- `src/БПВ_НастройкаИнтеграцииБПДО_ДО/БПВ_НастройкаИнтеграцииБПДО_ДО/Forms/Форма/Ext/Form/Module.bsl` — **0 Error**, всего 9 диагностик (не блокирующие: 3 Warning UnusedLocalMethod, 4 Information LineLength, 2 Information DuplicateStringLiteral).

Предупреждения UnusedLocalMethod («Проверить», «Применить», «ПриСозданииНаСервере») — обработчики событий/действий управляемой формы, связаны в Form.xml; ожидаемые ложные срабатывания BSL LS при изолированном анализе модуля формы. Блокирующих дефектов (ParseError, отсутствующие символы, несовместимые типы, нарушение client/server) нет.

## 2. Сборка EPF1 (JKX) — PASS
- ИБ: `Srvr="HOME";Ref="JKX"`
- Команда: `1cv8.exe DESIGNER /IBConnectionString "Srvr=""HOME"";Ref=""JKX"";" /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\integration-jkx-build-02.log /LoadExternalDataProcessorOrReportFromFiles src\БПВ_НастройкаИнтеграцииБПДО_JKX\БПВ_НастройкаИнтеграцииБПДО_JKX.xml build\output\БПВ_НастройкаИнтеграцииБПДО_JKX.epf`
- Exit code: **0**
- EPF: `build\output\БПВ_НастройкаИнтеграцииБПДО_JKX.epf`, **8187 байт** (было 7629, прирост +558 — новые кнопки/поля формы).
- Лог: «Загрузка завершена. Суммарное время выполнения операции: 57960 миллисекунд.»

## 3. Сборка EPF2 (ДО) — PASS
- ИБ: `Srvr="HOME";Ref="DocMng30"`
- Команда: `1cv8.exe DESIGNER /IBConnectionString "Srvr=""HOME"";Ref=""DocMng30"";" /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\integration-do-build-02.log /LoadExternalDataProcessorOrReportFromFiles src\БПВ_НастройкаИнтеграцииБПДО_ДО\БПВ_НастройкаИнтеграцииБПДО_ДО.xml build\output\БПВ_НастройкаИнтеграцииБПДО_ДО.epf`
- Exit code: **0**
- EPF: `build\output\БПВ_НастройкаИнтеграцииБПДО_ДО.epf`, **7882 байт** (было 7181, прирост +701).
- Лог: «Загрузка завершена. Суммарное время выполнения операции: 21400 миллисекунд.»

## 4. Проверка логов
Оба лога (OEM/866) содержат только «Загрузка внешней обработки или отчета из XML. … Загрузка завершена.» — ошибок, предупреждений или «Код возврата != 0» нет. Оба .epf существуют, не пусты, время записи соответствует сборке (2026-08-27 13:53).

## 5. Round-trip / runtime smoke — NOT_RUN
UI/runtime smoke в headless-среде недоступен. Не блокирует PASS при успешных BSL + сборке.

## 6. Воспроизведение
1. `bsl-language-server_analyze_file` для обоих Module.bsl → 0 Error.
2. Сборка JKX (ИБ JKX) → exit 0, EPF 8187 байт.
3. Сборка ДО (ИБ DocMng30) → exit 0, EPF 7882 байт.
