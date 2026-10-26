PLAN_STATUS: PASS

# GoldenPathV3Smoke — технический план (1c-architect)

Цель: канонический EPF `GoldenPathV3Smoke` в src/GoldenPathV3Smoke/, структурно идентичен GoldenPathV2Smoke.

Ключевые константы и идентификаторы:
- ClassId (фиксированная платформенная константа, НЕ менять): c3831ec8-d8d5-4f93-8a22-f9bfae07327f
- Имя: GoldenPathV3Smoke; объект ExternalDataProcessor.GoldenPathV3Smoke; тип ExternalDataProcessorObject.GoldenPathV3Smoke
- DefaultForm: ExternalDataProcessor.GoldenPathV3Smoke.Form.Форма
- 5 новых GUID: uuid=798ed456-d5b5-4810-887f-680520bba90e, ObjectId=01216d0a-904a-4f2f-ae41-de922dc97885, TypeId=a4e8fdbe-65b2-4d32-8f87-c93f44963bd0, ValueId=9b6d0466-08ff-473d-8ee3-124da2ac9ef1, Форма uuid=121d427b-812d-4867-b73b-1d75f0b9df04

Файлы (4, только в src/GoldenPathV3Smoke/):
1. GoldenPathV3Smoke.xml
2. GoldenPathV3Smoke/Forms/Форма.xml
3. GoldenPathV3Smoke/Forms/Форма/Ext/Form.xml
4. GoldenPathV3Smoke/Forms/Форма/Ext/Form/Module.bsl

Структура формы (version 2.21, порядок секций AutoCommandBar->Events->ChildItems->Attributes->Commands):
- реквизит формы СтрокаТеста = xs:string + StringQualifiers Length=100 AllowedLength=Variable
- команда УстановитьМаркер (Action=УстановитьМаркер, CurrentRowUse=DontUse)
- InputField DataPath=СтрокаТеста (+ ContextMenu/ExtendedTooltip)
- Module.bsl: &НаКлиенте ПриОткрытии(Отказ) [СтрокаТеста=""]; &НаКлиенте УстановитьМаркер(Команда) [СтрокаТеста="GOLDEN_PATH_V3_PASS"]

Client/server: оба обработчика &НаКлиенте, серверных вызовов нет.

Build: 1cv8.exe DESIGNER /LoadExternalDataProcessorOrReportFromFiles src\GoldenPathV3Smoke\GoldenPathV3Smoke.xml build\output\GoldenPathV3Smoke.epf
Round-trip: /DumpExternalDataProcessorOrReportToFiles build\output\roundtrip build\output\GoldenPathV3Smoke.epf

Критерии PASS: 4 файла, ClassId=c3831ec8-..., 5 новых GUID, BSL 0 ошибок, build exit 0, round-trip 4 файла идентичны.