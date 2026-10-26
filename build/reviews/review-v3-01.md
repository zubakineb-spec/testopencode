# Review: GoldenPathV3Smoke (review-v3-01)

Reviewer: 1c-reviewer (model deepseek-v4-pro)
Date: 2026-08-26
Plan: build/plans/goldenpath-v3-plan-01.md

## Verdict

REVIEW_STATUS: FAIL
ITERATION: 1
BLOCKING_DEFECTS: 1

## Blocking defect

D1 (BLOCKING) — ClassId не совпадает с планом архитектора.

- Plan (line 8): ClassId = c3831ec8-d8d5-4f93-8a22-f9bfae07327f
  («фиксированная платформенная константа, НЕ менять»).
- Plan (line 30, критерий PASS): «ClassId=c3831ec8-...».
- Actual (src/GoldenPathV3Smoke/GoldenPathV3Smoke.xml line 6):
  a07cb786-f338-4c5b-a987-212f70d52f07.
- Все 4 sibling EPF используют c3831ec8-d8d5-4f93-8a22-f9bfae07327f:
  GoldenPathSmoke, GoldenPathV2Smoke, OpenCodeSmoke, BPV_AccessToCorrespondence.
- xr:ClassId для ExternalDataProcessor — фиксированный идентификатор
  платформенного класса, а НЕ новый GUID объекта (skill 1c-platform,
  Golden Path lesson). Разработчик сгенерировал новое значение для
  фиксированной константы.
- Impact: нарушает критерий PASS плана; с высокой вероятностью приведёт к
  ошибке Designer /LoadExternalDataProcessorOrReportFromFiles или к
  некорректному round-trip.

## Non-blocking notes

- BSL Language Server: 0 ошибок, 4 warning (UnusedLocalMethod ×2,
  UnusedLocalVariable ×2). Это ожидаемые false-positive для обработчиков
  управляемой формы и реквизита формы при анализе Module.bsl без контекста
  формы. Не блокирует.

## Conformity matrix

- Структура: ровно 4 файла, лишних нет — PASS.
- Имена: Name=GoldenPathV3Smoke; GeneratedType=ExternalDataProcessorObject.GoldenPathV3Smoke;
  DefaultForm=ExternalDataProcessor.GoldenPathV3Smoke.Form.Форма — PASS.
- GUID: uuid/ObjectId/TypeId/ValueId/Form-uuid совпадают с планом и уникальны
  (нет коллизий с V1/V2/прочими) — PASS.
- XML: version 2.21, xmlns корректны, порядок секций формы
  AutoCommandBar->Events->ChildItems->Attributes->Commands — PASS.
- Form.xml: реквизит СтрокаТеста (xs:string, Length=100, AllowedLength=Variable);
  команда УстановитьМаркер (Action=УстановитьМаркер, CurrentRowUse=DontUse);
  InputField DataPath=СтрокаТеста (+ContextMenu, ExtendedTooltip) — PASS.
- Module.bsl: &НаКлиенте ПриОткрытии(Отказ) [СтрокаТеста=""];
  &НаКлиенте УстановитьМаркер(Команда) [СтрокаТеста="GOLDEN_PATH_V3_PASS"];
  серверных вызовов нет — PASS.
- Кодировка: UTF-8 без BOM, LF (все 4 файла) — PASS.
- Область изменений: ссылок на GoldenPathV3Smoke вне плана и src/** нет;
  в репозитории нет коммитов (всё untracked), git-diff неприменим — PASS.

## Contract

REVIEW_STATUS: FAIL
ITERATION: 1
BLOCKING_DEFECTS: 1
FAIL_REASON: ClassId= a07cb786-f338-4c5b-a987-212f70d52f07 не совпадает с
  планом (c3831ec8-d8d5-4f93-8a22-f9bfae07327f) и с 4 sibling EPF.
FILES_REVIEWED:
  - src/GoldenPathV3Smoke/GoldenPathV3Smoke.xml
  - src/GoldenPathV3Smoke/GoldenPathV3Smoke/Forms/Форма.xml
  - src/GoldenPathV3Smoke/GoldenPathV3Smoke/Forms/Форма/Ext/Form.xml
  - src/GoldenPathV3Smoke/GoldenPathV3Smoke/Forms/Форма/Ext/Form/Module.bsl
  - build/plans/goldenpath-v3-plan-01.md
  - src/GoldenPathV2Smoke/** (эталон для сравнения)
SKILLS_USED: 1c-platform, 1c-metadata-engineering, 1c-bsl-engineering,
  1c-managed-form-engineering, 1c-epf-erf-engineering, 1c-query-skd,
  1c-testing-verification
EVIDENCE:
  - grep ClassId: только V3 имеет a07cb786-...; остальные 4 EPF — c3831ec8-...
  - bsl-language-server_analyze_file: diagnosticsCount=4, все Warning, 0 error
  - bash-проверка кодировки: NO-BOM + LF для всех 4 файлов
  - grep 5 новых GUID: встречаются только в V3 и плане (уникальность подтверждена)
RECOMMENDATION: FIX_BY_DEVELOPER
FINAL_REVIEW_REPORT: Реализация структурно корректна и полностью повторяет
  GoldenPathV2Smoke (имена, типы, связи, секции, обработчики, кодировка),
  НО содержит один блокирующий дефект: ClassId сгенерирован как новый GUID
  (a07cb786-...) вместо фиксированной платформенной константы
  c3831ec8-d8d5-4f93-8a22-f9bfae07327f, заданной планом. Требуется исправление
  ClassId в src/GoldenPathV3Smoke/GoldenPathV3Smoke.xml (строка 6).