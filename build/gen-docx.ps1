Add-Type -AssemblyName System.IO.Compression.FileSystem

function Esc([string]$s) { $s = $s -replace '&','&amp;'; $s = $s -replace '<','&lt;'; $s = $s -replace '>','&gt;'; return $s }

$P = New-Object System.Collections.Generic.List[string]
function Title([string]$t){ $P.Add('<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="120"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="36"/></w:rPr><w:t>'+ (Esc $t) +'</w:t></w:r></w:p>') }
function Sub([string]$t){ $P.Add('<w:p><w:pPr><w:jc w:val="center"/><w:spacing w:after="240"/></w:pPr><w:r><w:rPr><w:i/><w:sz w:val="24"/></w:rPr><w:t>'+ (Esc $t) +'</w:t></w:r></w:p>') }
function H1([string]$t){ $P.Add('<w:p><w:pPr><w:spacing w:before="240" w:after="120"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="28"/></w:rPr><w:t>'+ (Esc $t) +'</w:t></w:r></w:p>') }
function H2([string]$t){ $P.Add('<w:p><w:pPr><w:spacing w:before="160" w:after="80"/></w:pPr><w:r><w:rPr><w:b/><w:sz w:val="23"/></w:rPr><w:t>'+ (Esc $t) +'</w:t></w:r></w:p>') }
function Body([string]$t){ $P.Add('<w:p><w:pPr><w:spacing w:after="80"/></w:pPr><w:r><w:rPr><w:sz w:val="22"/></w:rPr><w:t xml:space="preserve">'+ (Esc $t) +'</w:t></w:r></w:p>') }
function Bullet([string]$t){ $P.Add('<w:p><w:pPr><w:ind w:left="420" w:hanging="200"/><w:spacing w:after="40"/></w:pPr><w:r><w:rPr><w:sz w:val="22"/></w:rPr><w:t xml:space="preserve">&#8226; '+ (Esc $t) +'</w:t></w:r></w:p>') }

Title 'Выборочное подписание файлов электронной подписью'
Sub 'Руководство пользователя'

H1 '1. О документе'
Body 'Расширение «ВыборочноеПодписаниеФайлов» предназначено для 1С:Документооборот КОРП 3.0. Оно позволяет подписанту подписывать электронной подписью не все файлы документа сразу, а только выбранные.'

H1 '2. Требования перед началом работы'
Bullet 'Установлен КриптоПро CSP.'
Bullet 'Имеется действующий сертификат электронной подписи.'
Bullet 'Вы назначены подписантом в задаче «Подписать» по документу.'

H1 '3. Как подписать выбранные файлы (пошагово)'
Body '1. Откройте задачу «Подписать» по нужному документу.'
Body '2. Нажмите штатную команду результата «Подписано».'
Body '3. Откроется форма «Выбор файлов для подписания» со списком присоединённых файлов.'
Body '4. Отметьте галочками файлы, которые необходимо подписать.'
Body '5. При необходимости просмотрите файл командой «Открыть файл» или проверьте подписи командой «Проверить подписи».'
Body '6. Нажмите «Подписать выбранные».'
Body '7. Выберите сертификат и подтвердите подписание (при необходимости введите PIN-код).'
Body '8. Дождитесь завершения операции и проверьте итог: в нём указано, какие файлы подписаны.'

H1 '4. Команды формы выбора файлов'
Bullet 'Выбрать все — отметить все файлы списка.'
Bullet 'Снять все — снять все отметки.'
Bullet 'Открыть файл — открыть выделенный файл для просмотра.'
Bullet 'Проверить подписи — открыть карточку файла с разделом «Электронные подписи».'
Bullet 'Подписать выбранные — сформировать электронную подпись для отмеченных файлов.'
Bullet 'Отмена — отменить операцию (подписи не формируются).'

H1 '5. Колонки таблицы файлов'
Bullet 'Подписать — отметка, какие файлы будут подписаны.'
Bullet 'Файл — имя файла.'
Bullet 'Тип — расширение файла (например, PDF, DOCX).'
Bullet 'Размер — размер файла.'
Bullet 'Подписан ранее — сформирована ли уже электронная подпись по этому файлу.'

H1 '6. Типовые ситуации'
H2 'Ничего не выбрано'
Body 'Появляется предупреждение, подписание не выполняется, задача не завершается.'
H2 'Отмена выбора сертификата или ввода PIN-кода'
Body 'Операция отменяется без изменений: подписи не формируются, данные не повреждаются.'
H2 'Ошибка при подписании файла'
Body 'Выводится текст ошибки. Остальные выбранные файлы могут быть подписаны. Операция не считается полностью успешной, если часть файлов не подписана.'
H2 'Файл уже подписан ранее'
Body 'Новая подпись добавляется к уже существующим. Существующие подписи не удаляются.'

H1 '7. Частые вопросы'
H2 'Нужно ли подписывать все файлы документа?'
Body 'Нет. Можно подписать только нужные файлы. Остальные останутся в документе без новой подписи.'
H2 'Что произойдёт с невыбранными файлами?'
Body 'Они останутся в документе без электронной подписи текущего подписанта.'
H2 'Изменяются ли исходные файлы?'
Body 'Нет. Файлы не изменяются, не конвертируются и не заменяются.'
H2 'Можно ли подписать файл повторно?'
Body 'Да. Новая подпись добавляется к уже существующим.'
H2 'Где хранятся электронные подписи?'
Body 'Подписи хранятся штатным способом 1С:Документооборота и проверяются штатными средствами.'

$bodyXml = ($P -join '') + '<w:sectPr><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:top="1134" w:right="1134" w:bottom="1134" w:left="1134" w:header="708" w:footer="708" w:gutter="0"/></w:sectPr>'

$documentXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "`r`n" + '<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body>' + $bodyXml + '</w:body></w:document>'

$contentTypes = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "`r`n" + '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/></Types>'

$rels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "`r`n" + '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/></Relationships>'

$out = Join-Path (Split-Path -Parent $PSScriptRoot) 'Руководство_пользователя_ВыборочноеПодписаниеФайлов.docx'
if (-not $PSScriptRoot) { $out = 'C:\Users\Home\Documents\Default Project\Руководство_пользователя_ВыборочноеПодписаниеФайлов.docx' }
if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Force }
$enc = New-Object System.Text.UTF8Encoding($false)
$zip = [System.IO.Compression.ZipFile]::Open($out, [System.IO.Compression.ZipArchiveMode]::Create)
function AddEntry([string]$name, [string]$content) {
  $entry = $zip.CreateEntry($name)
  $s = $entry.Open()
  $bytes = $enc.GetBytes($content)
  $s.Write($bytes, 0, $bytes.Length)
  $s.Close()
}
AddEntry '[Content_Types].xml' $contentTypes
AddEntry '_rels/.rels' $rels
AddEntry 'word/document.xml' $documentXml
$zip.Dispose()
Write-Output ("written: " + (Get-Item -LiteralPath $out).Length + " bytes -> " + $out)
