# OpenCodeSmoke EPF — финальный отчёт о проверке

Дата: 2026-08-20
Платформа: 1C:Enterprise 8.5.1.1343 (`C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe`)
ИБ: `Srvr="HOME";Ref="DocMng30"` (серверная), пользователь `Администратор`

## Итоговый статус: ПРОВЕРЕНО через официальный round-trip

| Проверка | Результат | Доказательство |
|---|---|---|
| BSL-диагностика | PASS (нет блокирующих) | только Info/Warning + намеренные UsingHardcodePath для тестовых путей |
| Сборка EPF (XML → EPF) | PASS | `designer-build-17.log`: exit 0, 13–15 c |
| Выгрузка EPF (EPF → XML) | PASS | `designer-dump-17.log`: exit 0, 8 c |
| **Round-trip идентичность** | **PASS** | все 4 файла байт-в-байт идентичны после нормализации EOL+BOM |
| UI runtime-тест (форма + маркер) | НЕВЫПОЛНИМО в этом окружении | клиент 1С не создаёт ни одного видимого окна (MainWindowHandle=0) даже без `/Execute` |

## Ключевые выводы

### 1. Окружение не отображает UI 1С
`ENTERPRISE`-запуск (с `/Execute` и без него) стартует процесс 1cv8 (остаётся живым, session=1), но **не создаёт видимых окон** (EnumWindows: 0 видимых, MainWindowHandle=0). UI Automation через `RootElement.FindAll` бросает COMException. Это ограничение среды запуска, а не дефект EPF — форма физически не открывается, поэтому обработчик `ПриОткрытии` не срабатывает и маркерный файл не создаётся. Требуется интерактивный рабочий стол для UI-smoke.

### 2. Каноническая форма XCF для платформы 8.5.1.1343 (схема 2.21)
Round-trip выявил нормализацию, которую платформа применяет при загрузке XML:

| Элемент | Наш исходник (принят) | Канон платформы (dump) |
|---|---|---|
| version | 2.4 | **2.21** (должна совпадать у всех файлов) |
| `<Event name=...>` | `ПриОткрытии` (русский алиас) | **`OnOpen`** (английское каноническое имя) |
| `<UsePurposes>` | `PersonalComputer` | **`PlatformApplication`** |
| `UseInInterfaceCompatibilityMode` | отсутствовал | **добавлен `Any`** |
| `<CurrentRowUse>` в команде | удаляли | **платформа возвращает `DontUse`** |
| Порядок секций | Events в конце | **Events сразу после AutoCommandBar** |
| xmlns:pal | в конце списка | **сразу после xmlns:lf** |
| BOM / EOL | нет BOM, LF | **+BOM, CRLF** (кодировка выгрузки) |

Вывод: исходник приведён к канону платформы, и теперь загрузка→выгрузка даёт байт-идентичный результат. Связка события → обработчик сохранена: `<Event name="OnOpen">ПриОткрытии</Event>` + процедура `ПриОткрытии(Отказ)` в `Module.bsl`.

### 3. Структура EPF подтверждена
- Корневой XML: `ExternalDataProcessor.OpenCodeSmoke`, uuid стабилен, `DefaultForm` указывает на форму `Форма`.
- Форма: `FormType=Managed`, атрибут `Объект` (MainAttribute, тип `ExternalDataProcessorObject.OpenCodeSmoke`), команда `Проверить` (Title ru + Action).
- Модуль формы: обработчик пишет маркер `build/logs/runtime-marker.txt` (строка `PASS <дата сеанса>`), при ошибке — `runtime-error.txt`.

## Артефакты
- `src/OpenCodeSmoke/OpenCodeSmoke.xml` — корневой XML (канон, version 2.21)
- `src/OpenCodeSmoke/OpenCodeSmoke/Forms/Форма.xml` — дескриптор формы (канон)
- `src/OpenCodeSmoke/OpenCodeSmoke/Forms/Форма/Ext/Form.xml` — форма (канон, OnOpen)
- `src/OpenCodeSmoke/OpenCodeSmoke/Forms/Форма/Ext/Form/Module.bsl` — модуль формы
- `build/output/OpenCodeSmoke.epf` — собранная обработка (build 17)
- `build/output/roundtrip/` — выгрузка EPF обратно в XML (dump 17)
- `build/logs/designer-build-17.log`, `build/logs/designer-dump-17.log` — логи (exit 0)

## Рекомендация по дальнейшей проверке
Для полноценного runtime-smoke (открытие формы и запись маркера) нужен интерактивный рабочий стол: запуск из консольной сессии пользователя с видимым UI, либо тестовый клиент (Vanessa Automation / TestClient) в такой сессии. В текущем headless-контексте round-trip является самой сильной доступной проверкой целостности и правильности EPF.