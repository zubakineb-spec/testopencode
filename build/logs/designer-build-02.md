# Designer build 02

Result: exit code `1`.

Designer reached the external-processor import. It reported the missing path:

`src/OpenCodeSmoke/OpenCodeSmoke/Forms/Форма.xml`

Cause: Designer requires child metadata beside the root XML in a directory whose name matches the root XML basename. The source tree was moved from `src/OpenCodeSmoke/Forms` to `src/OpenCodeSmoke/OpenCodeSmoke/Forms`.
