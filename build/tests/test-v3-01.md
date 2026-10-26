# Тест EPF GoldenPathV3Smoke — test-v3-01

Вердикт: **FAIL**

## 1. BSL-анализ (bsl-language-server)
Файл: `src/GoldenPathV3Smoke/GoldenPathV3Smoke/Forms/Форма/Ext/Form/Module.bsl`
Результат: **0 ошибок, 4 предупреждения** (не блокирующие).

Предупреждения (ложные срабатывания для модуля формы):
- `UnusedLocalMethod` "ПриОткрытии" — обработчик события OnOpen, связан в `Form.xml`.
- `UnusedLocalMethod` "УстановитьМаркер" — действие команды, связан в `Form.xml`.
- `UnusedLocalVariable` "СтрокаТеста" (×2) — реквизит формы, объявлен в `Form.xml`.

## 2. Штатная сборка (Designer) — FAIL
Команда: `1cv8.exe DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N Администратор /P <DPAPI> /DisableStartupDialogs /Out build\logs\goldenpath-v3-build-01.log /LoadExternalDataProcessorOrReportFromFiles src\GoldenPathV3Smoke\GoldenPathV3Smoke.xml build\output\GoldenPathV3Smoke.epf`

Exit code: **1**
Лог: `build/logs/goldenpath-v3-build-01.log`
EPF **не создан**: `build/output/GoldenPathV3Smoke.epf` отсутствует.

Точная ошибка (дословно из лога):
```
Файл - C:/Users/Home/Documents/Default Project/src/GoldenPathV3Smoke/GoldenPathV3Smoke.xml, узел - /Configuration/XCFInternalInfo/xr:ContainedObject/xr:ClassId, значение - a07cb786-f338-4c5b-a987-212f70d52f07: Неверный идентификатор класса хранимого объекта.
Ошибка загрузки документа.
```

## 3. Техническая причина (root cause)
В `src/GoldenPathV3Smoke/GoldenPathV3Smoke.xml` узел `InternalInfo/xr:ContainedObject/xr:ClassId` содержит случайный GUID `a07cb786-f338-4c5b-a987-212f70d52f07`.

Это поле — **фиксированный идентификатор класса хранимого объекта** (`ExternalDataProcessor`), а не GUID экземпляра объекта.

Корректное значение: `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`.

Подтверждено по трём проходящим аналогам, где `xr:ClassId` совпадает, а уникальным является `xr:ObjectId`:
- `src/GoldenPathSmoke/GoldenPathSmoke.xml` → ClassId `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`
- `src/GoldenPathV2Smoke/GoldenPathV2Smoke.xml` → ClassId `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`
- `src/OpenCodeSmoke/OpenCodeSmoke.xml` → ClassId `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`

Минимальное исправление (за разработчиком): заменить `xr:ClassId` на `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`, оставив `xr:ObjectId` уникальным.

## 4. Round-trip
Не выполнялся — сборка завершилась FAIL (шаг 4 условен).

## 5. Как воспроизвести
1. Выполнить команду сборки из п. 2 в рабочем каталоге `C:\Users\Home\Documents\Default Project`.
2. Прочитать `build\logs\goldenpath-v3-build-01.log`.
3. Наблюдать `EXIT=1` и ошибку «Неверный идентификатор класса хранимого объекта» на узле `/Configuration/XCFInternalInfo/xr:ContainedObject/xr:ClassId`.
