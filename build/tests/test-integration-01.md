TEST_STATUS: PASS

# Тест сборки двух внешних обработок настройки интеграции — test-integration-01

Вердикт: **PASS**

## 1. BSL-анализ (bsl-language-server) — критерий 0 Error выполнен
- `src/БПВ_НастройкаИнтеграцииБПДО_JKX/БПВ_НастройкаИнтеграцииБПДО_JKX/Forms/Форма/Ext/Form/Module.bsl` — **0 ошибок**, 12 диагностик (не блокирующие: 3 Warning UnusedLocalMethod, 2 Info NestedFunctionInParameters, 3 Info LineLength, 3 Hint Typo, 1 Info DuplicateStringLiteral).
- `src/БПВ_НастройкаИнтеграцииБПДО_ДО/БПВ_НастройкаИнтеграцииБПДО_ДО/Forms/Форма/Ext/Form/Module.bsl` — **0 ошибок**, 9 диагностик (не блокирующие: 3 Warning UnusedLocalMethod, 4 Info LineLength, 2 Info DuplicateStringLiteral).

Предупреждения UnusedLocalMethod («Проверить», «Применить», «ПриСозданииНаСервере») — обработчики событий/действий управляемой формы, связаны в Form.xml; ожидаемые ложные срабатывания BSL LS при изолированном анализе модуля формы. Блокирующих дефектов (ParseError, отсутствующие символы, несовместимые типы, нарушение client/server) нет.

## 2. Сборка EPF1 (JKX) — PASS
- ИБ: `Srvr="HOME";Ref="JKX"`
- Команда: `1cv8.exe DESIGNER /IBConnectionString "Srvr=""HOME"";Ref=""JKX"";" /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\integration-jkx-build-01.log /LoadExternalDataProcessorOrReportFromFiles src\БПВ_НастройкаИнтеграцииБПДО_JKX\БПВ_НастройкаИнтеграцииБПДО_JKX.xml build\output\БПВ_НастройкаИнтеграцииБПДО_JKX.epf`
- Exit code: **0**
- EPF: `build\output\БПВ_НастройкаИнтеграцииБПДО_JKX.epf`, **7629 байт**
- Лог: «Загрузка завершена. Суммарное время выполнения операции: 34529 миллисекунд.»

## 3. Сборка EPF2 (ДО) — PASS
- ИБ: `Srvr="HOME";Ref="DocMng30"`
- Команда: `1cv8.exe DESIGNER /IBConnectionString "Srvr=""HOME"";Ref=""DocMng30"";" /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\integration-do-build-01.log /LoadExternalDataProcessorOrReportFromFiles src\БПВ_НастройкаИнтеграцииБПДО_ДО\БПВ_НастройкаИнтеграцииБПДО_ДО.xml build\output\БПВ_НастройкаИнтеграцииБПДО_ДО.epf`
- Exit code: **0**
- EPF: `build\output\БПВ_НастройкаИнтеграцииБПДО_ДО.epf`, **7181 байт**
- Лог: «Загрузка завершена. Суммарное время выполнения операции: 21720 миллисекунд.»

## 4. Замечание по инвокации (не дефект артефакта)
Первая попытка сборки JKX через `Start-Process -ArgumentList` (массив) дала exit 1 и не создала лог: в PowerShell 5.1 элементы массива с пробелами не экранируются, путь `...\Default Project\...` разбился на `...\Default` и `Project\...` (появился мусорный файл `C:\Users\Home\Documents\Default`, удалён). Пересборка через `System.Diagnostics.Process` с корректным квотированием — exit 0. Обе финальные сборки выполнены корректным способом.

## 5. Round-trip / runtime smoke — NOT_RUN
UI/runtime smoke в headless-среде недоступен. Не блокирует PASS при успешных BSL + сборке.

## 6. Воспроизведение
1. `bsl-language-server_analyze_file` для обоих Module.bsl → 0 Error.
2. Сборка JKX (ИБ JKX) → exit 0, EPF 7629 байт.
3. Сборка ДО (ИБ DocMng30) → exit 0, EPF 7181 байт.
