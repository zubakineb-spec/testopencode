# VYBR_PODPISANIE-001 — Build & Verification report

## BUILD_STATUS: PASS
- Расширение «ВыборочноеПодписаниеФайлов» собрано и загружено в тестовую ИБ DocMng30 (ДО КОРП 3.0.20.21) через Конфигуратор («Загрузить из файлов») БЕЗ ошибок.
- Реальный артефакт .cfe: build/output/ВыборочноеПодписаниеФайлов.cfe (12 831 байт, заголовок контейнера 1С `FF FF FF 7F` + `00000054 ...` подтверждает формат .cfe).
- F7 (обновить конфигурацию БД) выполнено — расширение в ИБ.

## КЛЮЧЕВЫЕ ОТЛИЧИЯ ФОРМАТА ВЫГРУЗКИ РАСШИРЕНИЯ (платформа 8.5.1.1343 vs 8.3)
Выяснено по авторитетному образцу (выгрузка пустого расширения самим Конфигуратором):
- корневой объект Configuration.xml — `<Configuration>` (не `<Extension>`);
- обязателен `<InternalInfo>` с 7 `<xr:ContainedObject>` (фиксированные ClassId);
- свойство назначения — `<ConfigurationExtensionPurpose>` (НЕ ExtensionPurpose/Purpose);
- свойство `MainConfigurationCompatibilityMode` ОТСУТСТВУЕТ;
- `ConfigurationExtensionCompatibilityMode` = Version8_3_27;
- заимствованный объект: `ObjectBelonging=Adopted` + УНИКАЛЬНЫЙ uuid (НЕ совпадающий с uuid объекта основной конфигурации); новые объекты — без ObjectBelonging;
- `/Extension ... /LoadConfigFromFiles` в пакетном режиме НЕ создаёт расширение (работает только «Загрузить из файлов» в Конфигураторе).

## ROUNDTRIP_STATUS: PARTIAL
Пакетный `/Extension /DumpConfigToFiles` выгружает основную конфигурацию (параметр /Extension в 8.5.1 не работает для дампа). Каноническую выгрузку расширения можно получить через GUI «Выгрузить в файлы».

## BSL_STATUS: PASS
0 Error/ParseError в обоих модулях (CommonModules/ИнтеграцияЗадачКлиент, CommonForms/Расш_ВыборФайловДляПодписания/Ext/Form/Module.bsl).

## RUNTIME / ACCEPTANCE: NOT_RUN
Подписание ЭП требует CryptoPro + действующий сертификат + PIN — недоступно в среде; не имитировалось.

## ИТОГ
Код и формат расширения корректны; сборка (.cfe) и загрузка в ИБ подтверждены. Финальное выборочное подписание файлов ЭП не проверено в рантайме (блокер среды).
