# GoldenPathSmoke — технический план (1c-architect)

## Цель
Создать новый минимальный канонический EPF в `src/GoldenPathSmoke/`, изолированный от существующих
`OpenCodeSmoke` и `BPV_AccessToCorrespondence`, и проверить полный цикл:
BSL LS -> сборка 1cv8.exe DESIGNER /LoadExternalDataProcessorOrReportFromFiles -> round-trip.

## Факты (эталон src/OpenCodeSmoke/, канон платформы 8.5.1.1343 схема 2.21)
- 4 файла: <Name>.xml, Forms/Форма.xml, Forms/Форма/Ext/Form.xml, Forms/Форма/Ext/Form/Module.bsl (объектного модуля нет).
- version="2.21" у всех XML.
- Событие <Event name="OnOpen">ПриОткрытии</Event>, секция Events сразу после AutoCommandBar.
- xmlns:pal сразу после xmlns:lf; UsePurposes=PlatformApplication; UseInInterfaceCompatibilityMode=Any.
- Команда с <CurrentRowUse>DontUse</CurrentRowUse>; модуль формы — &НаКлиенте ПриОткрытии(Отказ).
- 3 набора xmlns: корневой/дескриптор (MDClasses, полный набор), тело формы (logform, dcscor/dcssch/dcsset, без cmi/xen/xpr).

## Имя артефакта
GoldenPathSmoke. Объект ExternalDataProcessor.GoldenPathSmoke, тип ExternalDataProcessorObject.GoldenPathSmoke, форма "Форма".

## Файлы (создаются только в src/GoldenPathSmoke/)
- 6 новых GUID (не переиспользовать из эталона).
1. src/GoldenPathSmoke/GoldenPathSmoke.xml (корневой, DefaultForm = ExternalDataProcessor.GoldenPathSmoke.Form.Форма, синоним "GoldenPath 1C smoke test").
2. src/GoldenPathSmoke/GoldenPathSmoke/Forms/Форма.xml (дескриптор, Managed, PlatformApplication, UseInInterfaceCompatibilityMode=Any).
3. src/GoldenPathSmoke/GoldenPathSmoke/Forms/Форма/Ext/Form.xml (тело формы: AutoCommandBar -> Events(OnOpen) -> Attributes(Объект MainAttribute, cfg:ExternalDataProcessorObject.GoldenPathSmoke) -> Commands(Проверить)).
4. src/GoldenPathSmoke/GoldenPathSmoke/Forms/Форма/Ext/Form/Module.bsl (ПриОткрытии(Отказ) пишет маркер build/logs/goldenpath-marker.txt).

## Сборка
1cv8.exe DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N Администратор /P <DPAPI>
/DisableStartupDialogs /Out build/logs/goldenpath-build-01.log
/LoadExternalDataProcessorOrReportFromFiles src/GoldenPathSmoke/GoldenPathSmoke.xml build/output/GoldenPathSmoke.epf
Ожидание: exit 0.

## Round-trip
/DumpExternalDataProcessorOrReportToFiles build/output/GoldenPathSmoke.epf build/output/roundtrip
Сравнение 4 файлов после нормализации EOL+BOM — критерий идентичность.

## Тестирование
1. BSL LS анализ Module.bsl — 0 ошибок (допустимы Info/Warning, в т.ч. UsingHardcodePath для тестового пути).
2. Сборка exit 0.
3. Round-trip идентичность.
4. UI runtime-smoke — невыполним в headless (необязателен).

## Риски
Блокировка ИБ Конфигуратором; коллизия GUID; пропуск подстановки имени; неканоничная шапка; EOL/BOM; утечка секретов (пароль только DPAPI).

## Rollback
Удалить src/GoldenPathSmoke/ (+ build/output/GoldenPathSmoke.epf, build/output/roundtrip/GoldenPathSmoke/).