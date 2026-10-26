# Designer build 04

Result: exit code `1`.

The XDTO error persisted in `Form.xml`. A comparison with a real Designer-exported command identified two schema violations:

- `Command/Title` must be a localized `v8:item` collection.
- `Command/Action` is a text value and must not use `xsi:type="v8ui:Action"`.

Both elements were corrected for build 05.
