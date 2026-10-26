# Designer build 05

Command completed with exit code `0`.

Designer log confirms successful load in `18440` ms.

Artifact verification:

- File: `build/output/OpenCodeSmoke.epf`
- Exists: `True`
- Size: `5482` bytes

Before runtime smoke testing, the user-notification method was returned to `Сообщить` so the actual button invocation can be observed through the message window. This introduces only BSL LS informational diagnostic `DeprecatedMessage`; it is not a compilation or runtime error.
