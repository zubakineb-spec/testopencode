# Designer build 03

Result: exit code `1`.

Designer imported the metadata tree and reported an XDTO read error in:

`src/OpenCodeSmoke/OpenCodeSmoke/Forms/Форма/Ext/Form.xml`

Correction: restored the complete namespace declarations from the official Designer-form export template before retrying.
