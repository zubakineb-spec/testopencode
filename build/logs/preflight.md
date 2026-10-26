# Preflight

## 1C platform

Command:

```powershell
& "C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe" DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N "Администратор" /P "***" /DisableStartupDialogs /CheckModules
```

Result: exit code `1`. No output log was specified during this pre-project probe, so the cause must be reproduced with `/Out` during the build step.

## EPF build command

```powershell
& "C:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe" DESIGNER /IBConnectionString 'Srvr="HOME";Ref="DocMng30";' /N "Администратор" /P "***" /DisableStartupDialogs /Out "build\logs\designer-build.log" /LoadExternalDataProcessorOrReportFromFiles "src\OpenCodeSmoke\OpenCodeSmoke.xml" "build\output\OpenCodeSmoke.epf"
```

## Source format

The source is a Designer external-data-processor file tree: a root `MetaDataObject/ExternalDataProcessor` XML file, `Forms` metadata XML, and a managed-form XML/module beneath `Forms/<form>/Ext/Form`.
