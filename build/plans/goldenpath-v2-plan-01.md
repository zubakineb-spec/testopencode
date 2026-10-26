# GoldenPathV2Smoke — технический план (1c-architect)

## PLAN_STATUS: PASS

## Цель
Создать новый минимальный канонический EPF `GoldenPathV2Smoke` в `src/GoldenPathV2Smoke/` с одной управляемой формой:
1. Реквизит формы `СтрокаТеста` типа Строка(100).
2. Команда `УстановитьМаркер`.
3. Обработчик команды устанавливает `СтрокаТеста = "GOLDEN_PATH_V2_PASS"`.
4. Элемент поля (InputField), связанный с реквизитом `СтрокаТеста`.
5. Клиент/сервер по правилам управляемого приложения.
6. Сборка штатным Designer 8.5.1.1343 + round-trip.

## Использованные SuperSkills (загружены через skill tool)
1. `1c-platform` — загружен (ClassId vs GUID, Gate inspect→minimal change→Designer build→round-trip).
2. `1c-metadata-engineering` — загружен (probe до кода, иерархия источников истины).
3. `1c-bsl-engineering` — загружен (client/server контекст, BSL LS после изменения).
4. `1c-ai-tooling` — загружен (Designer = authority для EPF/XML-артефактов).
Дополнительно (по системному требованию) загружены: `1c-metadata-probe`, `1c-core`.
Проектные скилы прочитаны напрямую (read-only): `1c-managed-form-engineering`, `1c-epf-erf-engineering`, `1c-testing-verification`.

## Источники доказательств (прочитанные файлы)
- `src/GoldenPathSmoke/GoldenPathSmoke.xml` — канон верхнего уровня EPF (ClassId, uuid/ObjectId/TypeId/ValueId, DefaultForm, ChildObjects).
- `src/GoldenPathSmoke/GoldenPathSmoke/Forms/Форма.xml` — дескриптор формы (Form uuid, Managed, UsePurposes, UseInInterfaceCompatibilityMode).
- `src/GoldenPathSmoke/GoldenPathSmoke/Forms/Форма/Ext/Form.xml` — тело формы (порядок секций, команда Action+CurrentRowUse).
- `src/GoldenPathSmoke/GoldenPathSmoke/Forms/Форма/Ext/Form/Module.bsl` — `&НаКлиенте Процедура ПриОткрытии(Отказ)`.
- `src/OpenCodeSmoke/...` (4 файла) — второй эталон, подтверждает структуру EPF.
- `build/output/roundtrip/GoldenPathSmoke/...` — round-trip идентичен src (эталон уже каноничен).
- `build/output/meta-dump/DataProcessors/ВводКонтактнойИнформации/Forms/ВебСайт/Ext/Form.xml` — реальный пример InputField+DataPath, StringQualifiers Length, порядок секций AutoCommandBar→Events→ChildItems→Attributes→Commands→Parameters.
- `build/output/meta-dump/DataProcessors/ВводКонтактнойИнформации/Forms/ВебСайт/Ext/Form/Module.bsl` — сигнатура обработчика команды формы `&НаКлиенте Процедура ОК(Команда)`.
- `build/plans/goldenpath-plan-01.md` — формат предыдущего плана, команда сборки/round-trip.
- ЗАМЕЧАНИЕ: файл `1c-platforms.json` в проекте ОТСУТСТВУЕТ (AGENTS.md ссылается, но файла нет). Путь платформы берётся из задачи/AGENTS.md: `C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe` (Test-Path = True).

## Имя и идентификаторы артефакта
- Имя EPF: `GoldenPathV2Smoke`
- Объект: `ExternalDataProcessor.GoldenPathV2Smoke`
- Генерируемый тип: `ExternalDataProcessorObject.GoldenPathV2Smoke`
- DefaultForm: `ExternalDataProcessor.GoldenPathV2Smoke.Form.Форма`
- Форма: `Форма` (FormType = Managed)

## ClassId и GUID
- ClassId (фиксированная платформенная константа класса, НЕ менять): `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`
- 5 новых GUID (сгенерированы, не переиспользовать из эталонов):
  1. ExternalDataProcessor `uuid` = `76ff91d2-4eba-4f53-92fa-325c1cc75da7`
  2. `<xr:ObjectId>` = `27a86797-34cd-42bc-9622-f356ef65fa6f`
  3. `<xr:TypeId>` = `0eeaa9b9-7f12-41ac-a521-364223475b1f`
  4. `<xr:ValueId>` = `f89c8eee-cad9-4936-932c-dc4d6b371435`
  5. Форма `uuid` (в `Форма.xml`) = `6e364a10-2cdd-4e31-ae9a-bc660551ba2f`

## Файлы для создания (ТОЛЬКО в src/GoldenPathV2Smoke/)
4 файла (объектного модуля нет — как в эталоне):
1. `src/GoldenPathV2Smoke/GoldenPathV2Smoke.xml`
2. `src/GoldenPathV2Smoke/GoldenPathV2Smoke/Forms/Форма.xml`
3. `src/GoldenPathV2Smoke/GoldenPathV2Smoke/Forms/Форма/Ext/Form.xml`
4. `src/GoldenPathV2Smoke/GoldenPathV2Smoke/Forms/Форма/Ext/Form/Module.bsl`

Все XML: `version="2.21"`, кодировка UTF-8, CRLF, отступы табами (как эталон). Не менять файлы вне `src/GoldenPathV2Smoke/`, конфигурацию, AGENTS.md, skills.

---

## Структура XML (полные тексты)

### 1. src/GoldenPathV2Smoke/GoldenPathV2Smoke.xml
Корень MetaDataObject c полным набором xmlns (MDClasses + cmi/xen/xpr). Содержимое — копия эталона с подстановкой имён и GUID:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<MetaDataObject xmlns="http://v8.1c.ru/8.3/MDClasses" xmlns:app="http://v8.1c.ru/8.2/managed-application/core" xmlns:cfg="http://v8.1c.ru/8.1/data/enterprise/current-config" xmlns:cmi="http://v8.1c.ru/8.2/managed-application/cmi" xmlns:ent="http://v8.1c.ru/8.1/data/enterprise" xmlns:lf="http://v8.1c.ru/8.2/managed-application/logform" xmlns:pal="http://v8.1c.ru/8.1/data/ui/colors/palette" xmlns:style="http://v8.1c.ru/8.1/data/ui/style" xmlns:sys="http://v8.1c.ru/8.1/data/ui/fonts/system" xmlns:v8="http://v8.1c.ru/8.1/data/core" xmlns:v8ui="http://v8.1c.ru/8.1/data/ui" xmlns:web="http://v8.1c.ru/8.1/data/ui/colors/web" xmlns:win="http://v8.1c.ru/8.1/data/ui/colors/windows" xmlns:xen="http://v8.1c.ru/8.3/xcf/enums" xmlns:xpr="http://v8.1c.ru/8.3/xcf/predef" xmlns:xr="http://v8.1c.ru/8.3/xcf/readable" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.21">
	<ExternalDataProcessor uuid="76ff91d2-4eba-4f53-92fa-325c1cc75da7">
		<InternalInfo>
			<xr:ContainedObject>
				<xr:ClassId>c3831ec8-d8d5-4f93-8a22-f9bfae07327f</xr:ClassId>
				<xr:ObjectId>27a86797-34cd-42bc-9622-f356ef65fa6f</xr:ObjectId>
			</xr:ContainedObject>
			<xr:GeneratedType name="ExternalDataProcessorObject.GoldenPathV2Smoke" category="Object">
				<xr:TypeId>0eeaa9b9-7f12-41ac-a521-364223475b1f</xr:TypeId>
				<xr:ValueId>f89c8eee-cad9-4936-932c-dc4d6b371435</xr:ValueId>
			</xr:GeneratedType>
		</InternalInfo>
		<Properties>
			<Name>GoldenPathV2Smoke</Name>
			<Synonym>
				<v8:item>
					<v8:lang>ru</v8:lang>
					<v8:content>GoldenPath V2 smoke test</v8:content>
				</v8:item>
			</Synonym>
			<Comment/>
			<DefaultForm>ExternalDataProcessor.GoldenPathV2Smoke.Form.Форма</DefaultForm>
			<AuxiliaryForm/>
		</Properties>
		<ChildObjects>
			<Form>Форма</Form>
		</ChildObjects>
	</ExternalDataProcessor>
</MetaDataObject>
```

### 2. src/GoldenPathV2Smoke/GoldenPathV2Smoke/Forms/Форма.xml
Дескриптор формы (MDClasses xmlns):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<MetaDataObject xmlns="http://v8.1c.ru/8.3/MDClasses" xmlns:app="http://v8.1c.ru/8.2/managed-application/core" xmlns:cfg="http://v8.1c.ru/8.1/data/enterprise/current-config" xmlns:cmi="http://v8.1c.ru/8.2/managed-application/cmi" xmlns:ent="http://v8.1c.ru/8.1/data/enterprise" xmlns:lf="http://v8.1c.ru/8.2/managed-application/logform" xmlns:pal="http://v8.1c.ru/8.1/data/ui/colors/palette" xmlns:style="http://v8.1c.ru/8.1/data/ui/style" xmlns:sys="http://v8.1c.ru/8.1/data/ui/fonts/system" xmlns:v8="http://v8.1c.ru/8.1/data/core" xmlns:v8ui="http://v8.1c.ru/8.1/data/ui" xmlns:web="http://v8.1c.ru/8.1/data/ui/colors/web" xmlns:win="http://v8.1c.ru/8.1/data/ui/colors/windows" xmlns:xen="http://v8.1c.ru/8.3/xcf/enums" xmlns:xpr="http://v8.1c.ru/8.3/xcf/predef" xmlns:xr="http://v8.1c.ru/8.3/xcf/readable" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.21">
	<Form uuid="6e364a10-2cdd-4e31-ae9a-bc660551ba2f">
		<Properties>
			<Name>Форма</Name>
			<Synonym>
				<v8:item>
					<v8:lang>ru</v8:lang>
					<v8:content>GoldenPath V2 smoke test</v8:content>
				</v8:item>
			</Synonym>
			<Comment/>
			<FormType>Managed</FormType>
			<IncludeHelpInContents>false</IncludeHelpInContents>
			<UsePurposes>
				<v8:Value xsi:type="app:ApplicationUsePurpose">PlatformApplication</v8:Value>
			</UsePurposes>
			<UseInInterfaceCompatibilityMode>Any</UseInInterfaceCompatibilityMode>
			<ExtendedPresentation/>
		</Properties>
	</Form>
</MetaDataObject>
```

### 3. src/GoldenPathV2Smoke/GoldenPathV2Smoke/Forms/Форма/Ext/Form.xml
Тело управляемой формы. Порядок секций (канон Designer, подтверждён ВебСайт и эталоном):
`AutoCommandBar → Events → ChildItems → Attributes → Commands`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Form xmlns="http://v8.1c.ru/8.3/xcf/logform" xmlns:app="http://v8.1c.ru/8.2/managed-application/core" xmlns:cfg="http://v8.1c.ru/8.1/data/enterprise/current-config" xmlns:dcscor="http://v8.1c.ru/8.1/data-composition-system/core" xmlns:dcssch="http://v8.1c.ru/8.1/data-composition-system/schema" xmlns:dcsset="http://v8.1c.ru/8.1/data-composition-system/settings" xmlns:ent="http://v8.1c.ru/8.1/data/enterprise" xmlns:lf="http://v8.1c.ru/8.2/managed-application/logform" xmlns:pal="http://v8.1c.ru/8.1/data/ui/colors/palette" xmlns:style="http://v8.1c.ru/8.1/data/ui/style" xmlns:sys="http://v8.1c.ru/8.1/data/ui/fonts/system" xmlns:v8="http://v8.1c.ru/8.1/data/core" xmlns:v8ui="http://v8.1c.ru/8.1/data/ui" xmlns:web="http://v8.1c.ru/8.1/data/ui/colors/web" xmlns:win="http://v8.1c.ru/8.1/data/ui/colors/windows" xmlns:xr="http://v8.1c.ru/8.3/xcf/readable" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.21">
	<AutoCommandBar name="ФормаКоманднаяПанель" id="-1"/>
	<Events>
		<Event name="OnOpen">ПриОткрытии</Event>
	</Events>
	<ChildItems>
		<InputField name="СтрокаТеста" id="1">
			<DataPath>СтрокаТеста</DataPath>
			<Title>
				<v8:item>
					<v8:lang>ru</v8:lang>
					<v8:content>Строка теста</v8:content>
				</v8:item>
			</Title>
			<ContextMenu name="СтрокаТестаКонтекстноеМеню" id="2"/>
			<ExtendedTooltip name="СтрокаТестаРасширеннаяПодсказка" id="3"/>
		</InputField>
	</ChildItems>
	<Attributes>
		<Attribute name="Объект" id="1">
			<Type>
				<v8:Type>cfg:ExternalDataProcessorObject.GoldenPathV2Smoke</v8:Type>
			</Type>
			<MainAttribute>true</MainAttribute>
		</Attribute>
		<Attribute name="СтрокаТеста" id="2">
			<Title>
				<v8:item>
					<v8:lang>ru</v8:lang>
					<v8:content>Строка теста</v8:content>
				</v8:item>
			</Title>
			<Type>
				<v8:Type>xs:string</v8:Type>
				<v8:StringQualifiers>
					<v8:Length>100</v8:Length>
					<v8:AllowedLength>Variable</v8:AllowedLength>
				</v8:StringQualifiers>
			</Type>
		</Attribute>
	</Attributes>
	<Commands>
		<Command name="УстановитьМаркер" id="1">
			<Title>
				<v8:item>
					<v8:lang>ru</v8:lang>
					<v8:content>Установить маркер</v8:content>
				</v8:item>
			</Title>
			<Action>УстановитьМаркер</Action>
			<CurrentRowUse>DontUse</CurrentRowUse>
		</Command>
	</Commands>
</Form>
```

Примечания по структуре:
- Реквизит `СтрокаТеста` — реквизит ФОРМЫ (не реквизит объекта), `xs:string` + `StringQualifiers Length=100 AllowedLength=Variable`.
- `InputField` — элемент поля, `DataPath=СтрокаТеста` (имя реквизита формы напрямую, без `Объект.`).
- `ContextMenu`/`ExtendedTooltip` — авто-дети InputField (как в реальном примере ВебСайт), нужны для идентичности round-trip.
- Команда `УстановитьМаркер` — `Action=УстановитьМаркер`, `CurrentRowUse=DontUse` (как эталон).
- Пространства имён id раздельные: атрибуты (1,2), команды (1), элементы (1,2,3) — совпадение id допустимо (подтверждено ВебСайт).

### 4. src/GoldenPathV2Smoke/GoldenPathV2Smoke/Forms/Форма/Ext/Form/Module.bsl

```bsl
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СтрокаТеста = "";
КонецПроцедуры

&НаКлиенте
Процедура УстановитьМаркер(Команда)
	СтрокаТеста = "GOLDEN_PATH_V2_PASS";
КонецПроцедуры
```

## Client/server архитектура
- Оба обработчика — `&НаКлиенте` (обработчик события формы OnOpen и обработчик команды формы).
- `СтрокаТеста` — реквизит ФОРМЫ, доступен на клиенте напрямую. Присваивание из клиентского обработчика команды корректно и НЕ требует серверного вызова.
- Серверных процедур/вызовов нет; привилегированный режим не используется.
- Обработчик команды формы имеет каноничную сигнатуру `Процедура УстановитьМаркер(Команда)` (параметр типа КомандаФормы), подтверждено реальным модулем (`Процедура ОК(Команда)`).

## Build strategy
Штатная сборка Designer (платформа 8.5.1.1343). Пароль 1С — только из DPAPI-контейнера, НЕ хранить в репозитории/логах.

```
& "C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe" DESIGNER `
  /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' `
  /N Администратор /P <DPAPI-пароль> `
  /DisableStartupDialogs `
  /Out "C:\Users\Home\Documents\Default Project\build\logs\goldenpath-v2-build-01.log" `
  /LoadExternalDataProcessorOrReportFromFiles "C:\Users\Home\Documents\Default Project\src\GoldenPathV2Smoke\GoldenPathV2Smoke.xml" "C:\Users\Home\Documents\Default Project\build\output\GoldenPathV2Smoke.epf"
```
Ожидание: exit code 0, создан `build/output/GoldenPathV2Smoke.epf`.

Round-trip (канонизация обратно в XML для сверки):
```
& "C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe" DESIGNER `
  /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' `
  /N Администратор /P <DPAPI-пароль> `
  /DisableStartupDialogs `
  /Out "C:\Users\Home\Documents\Default Project\build\logs\goldenpath-v2-roundtrip-01.log" `
  /DumpExternalDataProcessorOrReportToFiles "C:\Users\Home\Documents\Default Project\build\output\GoldenPathV2Smoke.epf" "C:\Users\Home\Documents\Default Project\build\output\roundtrip"
```
Ожидание: `build/output/roundtrip/GoldenPathV2Smoke/` c 4 файлами, идентичными src (после нормализации EOL+BOM).

## Test strategy
1. BSL LS (`bsl-language-server_analyze_file`) для `Module.bsl` — 0 ошибок (Info/Warning допустимы). Диагностику НЕ подавлять.
2. Preflight управляемой формы: сверка Form.xml ↔ Module.bsl — каждый Action/Event разрешается в процедуру; `СтрокаТеста` объявлен в Attributes; InputField.DataPath указывает на существующий реквизит; типы корректны; client/server границы соблюдены.
3. Сборка Designer — exit 0 (читать build-лог, при ошибке чинить фактическую причину).
4. Round-trip — идентичность 4 файлов после нормализации EOL+BOM.
5. (Опционально) runtime smoke: открыть форму, вызвать команду `УстановитьМаркер`, проверить `СтрокаТеста = "GOLDEN_PATH_V2_PASS"` (headless-среда может не позволить — тогда ограничиться пунктами 1–4).

## Риски
- Блокировка ИБ `DocMng30` другим сеансом Конфигуратора.
- Коллизия/опечатка GUID (все 5 — новые, ClassId — фиксированный, не менять).
- Пропуск подстановки имени/типа (`GoldenPathV2Smoke`, `ExternalDataProcessorObject.GoldenPathV2Smoke`).
- Неканоничная шапка xml (xmlns/version 2.21) или неверный порядок секций формы.
- Round-trip расхождение из-за EOL/BOM или отсутствующих авто-детей InputField (ContextMenu/ExtendedTooltip).
- Утечка пароля в логи (пароль только DPAPI; в команду подставлять на время запуска).
- `1c-platforms.json` отсутствует — не блокирует (путь платформы задан явно в задаче).

## Rollback
Удалить `src/GoldenPathV2Smoke/` (+ артефакты `build/output/GoldenPathV2Smoke.epf`, `build/output/roundtrip/GoldenPathV2Smoke*`, логи `build/logs/goldenpath-v2-*`). Не затрагивает существующие `GoldenPathSmoke`/`OpenCodeSmoke`/конфигурацию.

## Критерии PASS
- Созданы ровно 4 файла в `src/GoldenPathV2Smoke/`, ничего вне этой папки не изменено.
- ClassId = `c3831ec8-d8d5-4f93-8a22-f9bfae07327f`; 5 GUID — уникальные, новые.
- Form.xml содержит: реквизит `СтрокаТеста` (Строка(100) = Length 100), команду `УстановитьМаркер` (Action+CurrentRowUse), элемент поля InputField с DataPath=`СтрокаТеста`, порядок секций AutoCommandBar→Events→ChildItems→Attributes→Commands.
- Module.bsl содержит `ПриОткрытии(Отказ)` и `УстановитьМаркер(Команда)`, оба `&НаКлиенте`; команда присваивает `СтрокаТеста = "GOLDEN_PATH_V2_PASS"`.
- BSL LS: 0 ошибок.
- Designer build: exit 0.
- Round-trip: 4 файла идентичны src (после нормализации EOL+BOM).