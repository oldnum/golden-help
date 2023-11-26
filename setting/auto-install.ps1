$path_dk = Resolve-Path ~/Desktop
$path_dwn = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
$second_drive = (Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 -and $_.DeviceID -ne "C:" }).DeviceID
$TempFolderPath = [System.IO.Path]::GetTempPath()
$path_check = @("$path_dk\golden-help-main", "${second_drive}\golden-help-main", "$path_dwn\golden-help-main", "$TempFolderPath\golden-help-main")

foreach ($path in $path_check) {
    if (Test-Path $path -PathType Container) {
        Remove-Item -Path $path -Recurse -Force
    }
}

$zipUrl = "https://github.com/oldnum/golden-help/archive/main.zip"
$downloadPath = "${path_dwn}\golden-help.zip"

Invoke-WebRequest -Uri $zipUrl -OutFile $downloadPath
Expand-Archive -Path $downloadPath -DestinationPath "${path_dwn}\"
Remove-Item $downloadPath
Invoke-Item "${path_dwn}\golden-help-main"
Start-Sleep -Seconds 1
Start-Process -FilePath "$path_dwn\golden-help-main\start.bat"
exit
