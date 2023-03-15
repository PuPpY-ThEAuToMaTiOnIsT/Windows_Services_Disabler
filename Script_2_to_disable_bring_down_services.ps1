#Run the below in Windows PowerShell (Admin) [ Right click on start menu icon and open this ]
#Provide the list in the below program to stop and disable the services
#Example:
#$services = @(
#"SysMain",
#"wscsvc",
#"DiagTrack"
#)

$services = @(
#the array of services which you want to disable, change it into comma separated values 
#with service names in double quotes and place it here
)

foreach ($serviceName in $services) {
    if ($serviceName.StartsWith("#")) {
        Write-Host "Ignoring commented service: $serviceName"
        continue
    }

    if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
        Write-Host "Service $serviceName exists. Disabling service..."
        REG ADD HKLM\SYSTEM\CurrentControlSet\Services\$serviceName /v Start /f /t REG_DWORD /d 4
		Stop-Service $serviceName -Force
        $process = Get-Process -Name $serviceName -ErrorAction SilentlyContinue
        if ($process) {
            Write-Host "Process with PID $($process.Id) exists. Killing process..."
            Stop-Process -Id $process.Id -Force
        }
        sc stop $serviceName
    } else {
        Write-Host "Service $serviceName does not exist."
    }
}
