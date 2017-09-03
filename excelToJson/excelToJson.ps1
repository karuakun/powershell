Param (
    [parameter(mandatory=$true)] [string]$inExcelFilePath,
    [parameter(mandatory=$true)] [string]$outJsonFilePath,
    $worksheetNameOrNo = 1
)

if (! (Test-Path $inExcelFilePath)) {
    "ファイル:{0}が存在しません。" -f $inExcelFilePath
    return
}

Add-Type -Path (Join-Path $PSScriptRoot ClosedXML.dll)
$book = New-Object ClosedXML.Excel.XLWorkbook($inExcelFilePath);
$data = foreach($row in $book.Worksheet($worksheetNameOrNo).RangeUsed().AsTable().Rows()) {
    foreach($cell in $row.Cells()) {
        $prop = @{
            Address = $cell.Address.ColumnNumber.ToString() + ":" + $cell.Address.RowNumber.ToString()
            Value =  $cell.Value 
        }
        New-Object PSObject -Property $prop
    }
}
$data | select address, value | ConvertTo-Json | Out-File $outJsonFilePath

