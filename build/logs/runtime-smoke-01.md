# Runtime smoke 01

Command started the built EPF with `ENTERPRISE /Execute` and created process `30536`.

Windows UI Automation failed before button discovery with a COM exception from `AutomationElement.RootElement.FindAll`. This execution context does not expose the desktop automation tree.

The smoke-test process was closed. No data in the infobase was modified.

For retry, the form-open event calls the same `Проверить` handler and the handler writes the observed message to `OpenCode1CSmoke.txt` in the platform temporary-files directory. This is a local test marker only; it neither reads nor writes infobase data.
