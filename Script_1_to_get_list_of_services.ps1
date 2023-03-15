#Run the below in Windows PowerShell (Admin) [ Right click on start menu icon and open this ]
#An excel will be created in the location from where the script is located
#Now get the service name list which you want to disable and change it into comma separated values with service names in double quotes

$services = Get-Service | Select-Object -Property Name, DisplayName, Description, Status, StartType
$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)
$worksheet.Name = "Services"
$worksheet.Cells.Item(1,1) = "Service Name"
$worksheet.Cells.Item(1,2) = "Display Name"
$worksheet.Cells.Item(1,3) = "Description"
$worksheet.Cells.Item(1,4) = "Status"
$worksheet.Cells.Item(1,5) = "Startup Type"
$row = 2
foreach ($service in $services) {
    $worksheet.Cells.Item($row,1) = $service.Name
    $worksheet.Cells.Item($row,2) = $service.DisplayName
    $worksheet.Cells.Item($row,3) = $service.Description
    $worksheet.Cells.Item($row,4) = $service.Status
    $worksheet.Cells.Item($row,5) = $service.StartType
    $row++
}
$filename = [System.IO.Path]::Combine((Get-Location).Path, "services.xlsx")
$workbook.SaveAs($filename)
$workbook.Close()
$excel.Quit()