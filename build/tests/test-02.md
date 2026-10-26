# Тест GoldenPathSmoke — 1c-tester (итерация 2, после исправления)

Вердикт: PASS

1. ClassId подтверждён: <xr:ClassId>c3831ec8-d8d5-4f93-8a22-f9bfae07327f</xr:ClassId>.
2. BSL LS: 0 ошибок (1 Warning UnusedLocalMethod — ложное, 2 Info).
3. Сборка: exit 0, лог "Загрузка завершена... 12819 мс" (goldenpath-build-02.log).
4. Выход: build/output/GoldenPathSmoke.epf = 5821 байт.
5. Round-trip: exit 0, 4 файла (GoldenPathSmoke.xml, Forms/Форма.xml, Forms/Форма/Ext/Form.xml, Forms/Форма/Ext/Form/Module.bsl).

Замечание: порядок аргументов /DumpExternalDataProcessorOrReportToFiles — <каталог> <epf> (не наоборот).