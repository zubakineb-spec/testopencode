# BSL Language Server analysis 01

File: `src/OpenCodeSmoke/Forms/Форма/Ext/Form/Module.bsl`

Result before correction: 0 errors, 1 warning and 1 informational diagnostic.

- `UnusedLocalMethod`: the analyzer does not load the managed-form command XML, so it cannot resolve `Проверить` as a command handler.
- `DeprecatedMessage`: `Сообщить` is deprecated.

Correction: replaced `Сообщить` with client-side `ПоказатьОповещениеПользователя` after its BSL LS signature was verified.
