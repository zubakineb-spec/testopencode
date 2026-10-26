PLAN_STATUS: PASS

OBJECT: GoldenPathV5Smoke (ExternalDataProcessor.GoldenPathV5Smoke), DefaultForm=ExternalDataProcessor.GoldenPathV5Smoke.Form.Форма, Форма (Managed).

CLASS_ID (фиксированная константа, НЕ менять): c3831ec8-d8d5-4f93-8a22-f9bfae07327f

OBJECT_GUIDS (5 новых):
1. ExternalDataProcessor uuid = 74d9e67f-b231-40cd-8206-3eb14f7257ae
2. xr:ObjectId = 36efd414-a8c8-4254-981f-71f3108adb6d
3. xr:TypeId = 6bb6a771-19e4-45b9-beb1-6bf9d95ae9cb
4. xr:ValueId = 36559b4d-b922-4636-a2f1-a1e3b646d639
5. Form uuid = 9460a645-eee4-4242-a585-a74c23cea40e

FORM_ATTRIBUTES:
- Объект (id=1, cfg:ExternalDataProcessorObject.GoldenPathV5Smoke, MainAttribute=true)
- СтрокаТеста (id=2, xs:string Length=100 AllowedLength=Variable)
- РезультатСервера (id=3, xs:string Length=100 AllowedLength=Variable)

FORM_COMMANDS:
- ВыполнитьТест (id=1, Action=ВыполнитьТест, CurrentRowUse=DontUse, Title="Выполнить тест")

FORM_ELEMENTS (ChildItems): InputField СтрокаТеста (DataPath=СтрокаТеста) + ContextMenu/ExtendedTooltip; InputField РезультатСервера (DataPath=РезультатСервера) + ContextMenu/ExtendedTooltip.

CLIENT_PROCEDURES:
- &НаКлиенте Процедура ПриОткрытии(Отказ): СтрокаТеста=""; РезультатСервера="";
- &НаКлиенте Процедура ВыполнитьТест(Команда): СтрокаТеста="GOLDEN_PATH_V5_CLIENT_PASS"; РезультатСервера=ПолучитьРезультатСервера();

SERVER_PROCEDURES:
- &НаСервереБезКонтекста Функция ПолучитьРезультатСервера(): Возврат "GOLDEN_PATH_V5_SERVER_PASS";

FILES (4, только src/GoldenPathV5Smoke/): GoldenPathV5Smoke.xml, Forms/Форма.xml, Forms/Форма/Ext/Form.xml, Forms/Форма/Ext/Form/Module.bsl.
Порядок секций формы: AutoCommandBar -> Events -> ChildItems -> Attributes -> Commands.
Все XML version=2.21, UTF-8 без BOM, LF.

BUILD: 1cv8.exe DESIGNER /LoadExternalDataProcessorOrReportFromFiles src\GoldenPathV5Smoke\GoldenPathV5Smoke.xml build\output\GoldenPathV5Smoke.epf
ROUNDTRIP: /DumpExternalDataProcessorOrReportToFiles build\output\roundtrip build\output\GoldenPathV5Smoke.epf

ACCEPTANCE_CRITERIA: ClassId корректен, 5 GUID уникальны, реквизиты/команда/элементы на месте, client/server директивы корректны, BSL 0 ошибок, build exit 0, round-trip идентичен.