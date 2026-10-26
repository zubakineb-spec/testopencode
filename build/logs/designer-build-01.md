# Designer build 01

Command:

```powershell
& "C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe" DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N "Администратор" /P "***" /DisableStartupDialogs /Out "build\logs\designer-build-01.log" /LoadExternalDataProcessorOrReportFromFiles "src\OpenCodeSmoke\OpenCodeSmoke.xml" "build\output\OpenCodeSmoke.epf"
```

Result: exit code `1`.

Designer log: the test infobase is locked for configuring by an existing session: computer `Home`, user `Администратор`, session `2`, started `19.08.2026 11:08:42`, application `Конфигуратор`.
