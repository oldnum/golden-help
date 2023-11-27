# -*- coding: utf-8 -*-
$version = "1.2"

function update {
    try {
        $latestVersion = irm https://raw.githubusercontent.com/oldnum/golden-help/main/setting/golden-help.ps1
        $lines = $latestVersion -split "`n"
        $secondLine = $lines[1]
        $versionString = $secondLine -match '\$version = "(.+)"'
        if ($versionString) {
            $stable_version = [float]$Matches[1]
            if ($stable_version -gt [float]$version) {
                return "false"
            } else {
                return "true"
            }
        } else {
            return "false"
        }
    }
    catch {
        return "false"
    } 
}


function logos {
    Clear-Host
    Write-Host "
╔═╗╔═╗╦  ╔╦╗╔═╗╔╗╔   ╦ ╦╔═╗╦  ╔═╗
║ ╦║ ║║   ║║║╣ ║║║───╠═╣║╣ ║  ╠═╝
╚═╝╚═╝╩═╝═╩╝╚═╝╝╚╝   ╩ ╩╚═╝╩═╝╩  
[author] @oldnum"
    $result = check_inet 1
    if ($result -eq "true") {
        $check_version = update
        if ($check_version -eq "true") {
            Write-Host "[stable version]" -ForegroundColor Green
            Write-Host "[internet connection]`n" -ForegroundColor Green
        } else {
            Write-Host "[old version] |new|-> https://github.com/oldnum/golden-help" -ForegroundColor Red
            Write-Host " |"
            Write-Host "[powershell] irm https://raw.githubusercontent.com/oldnum/golden-help/main/setting/auto-install.ps1 | iex" -ForegroundColor Red
            exit
        }
    } else {
        Write-Host "[old version] |new|-> https://github.com/oldnum/golden-help" -ForegroundColor Red
        Write-Host "[internet connection]`n"  -ForegroundColor Red
    }
}

function home {
    logos
    Write-Host "[1] - Activation [full]"
    Write-Host "[2] - Download/Install [standard programs]"
    Write-Host "[3] - Configuration tools"
    Write-Host "[4] - Information commands"
    Write-Host "[5] - Support"
    Write-Host "`n[0] - Exit"
    $choice = Read-Host "`n[number]"

    return $choice
}

function homepage {
    switch (home) {
        '1' {
            ActivationOption
            Read-Host "`n[x] Press Enter to return home :"
            homepage
        }
        '2' {
            DownloadOption
            Read-Host "`n[x] Press Enter to return home :"
            homepage
        }
        '3' {
            ConfigurationOption
            Read-Host "`n[x] Press Enter to return home :"
            homepage
        }
        '5' {
            Clear-Host
            logos
            Write-Host "[>] Support`n" -ForegroundColor Magenta
            Write-Host "[>] Contact the developer for assistance"
            Write-Host " |"
            Write-Host "[telegram] - https://t.me/oldnum"
            Write-Host " |"
            Write-Host "[>] Thank you for being with us" -ForegroundColor Magenta
            Read-Host "`n[x] Press Enter to exit :"
            exit


        }
        Default {
            exit
        }
    }
}

function check_inet($online){
    if (Test-Connection -ComputerName "google.com" -Count 1 -Quiet) {
        if ($online -eq 0){
            Start-Sleep -Seconds 2
            Write-Host " |"
            Write-Host "[>] Internet connection is true"
            Start-Sleep -Seconds 2
            Write-Host " |"
            Write-Host "[admin] Starting the process" -ForegroundColor Green
            Start-Sleep -Seconds 2
        } else {
            return "true"
        }
    } else {
        if ($online -eq 0){
            Start-Sleep -Seconds 2
            Write-Host " |"
            Write-Host "[>] Internet connection is false"
            Start-Sleep -Seconds 2
            Write-Host " |"
            Write-Host "[admin] Closing the process" -ForegroundColor Red
            Start-Sleep -Seconds 2
            Read-Host "`n[x] Press Enter to exit :...:..."
            exit
        } else {
            return "false"
        }
    }
}

function pathget($name){
    Write-Host "[1] - Download in Desktop"
    Write-Host "[2] - Download in Downloads"
    Write-Host "[3] - Download in D:\"
    Write-Host "`n[0] - Exit"
    $choice_path = Read-Host "`n[number]"
    switch ($choice_path) {
        '1' {
            return "$(Resolve-Path ~/Desktop)\$name"
        }
        '2' {
            return "$([System.IO.Path]::Combine($env:USERPROFILE, 'Downloads'))\$name"
        }
        '3' {
            return "$((Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 -and $_.DeviceID -ne "C:" }).DeviceID)\$name"
        }
        '0' {
            exit
        }
        Default {
            exit 
        }
    }
}

function ActivationOption {
    logos
    Write-Host "[process] full activation" -ForegroundColor Magenta
    Write-Host "`n[>] Please wait for the startup process Microsoft Activation Scripts ..."
    Start-Sleep -Seconds 5
    Write-Host " |"
    Write-Host "[>] Checking the Internet connection ..."
    check_inet 0
    irm https://massgrave.dev/get | iex
}


function DownloadOption {
    logos
    $path_log = "setting\"
    Write-Host "[process] - Download/Install [standard programs]`n" -ForegroundColor Magenta
    Write-Host "[1] - Install Office 2021 [auto-install]"
    Write-Host "[2] - Download Windows [.iso]"
    Write-Host "[3] - Download Rufus"
    Write-Host "[4] - Download Google Chrome"
    Write-Host "[5] - Download MediaCreationTool"
    Write-Host "[6] - Download ESETNod32 Antivirus"
    Write-Host "`n[0] - Exit"
    $choice_office = Read-Host "`nnumber"

    switch ($choice_office) {
        '1' {
            logos
            $path_log += "install-office\"
            Write-Host "[process] - Install Office 2021 | 1/3`n" -ForegroundColor Magenta
            Write-Host "[1] - English Version"
            Write-Host "[2] - Ukrainian Version"
            Write-Host "`n[0] - Exit"
            $choice_office_lang = Read-Host "`nnumber"

            switch ($choice_office_lang) {
                '1' {
                    $path_log += "eu\"
                }
                '2' {
                    $path_log += "ua\"
                }
                '0' {
                    exit
                }
                Default {
                    return
                }
            }
            logos
            Write-Host "[process] - Install Office 2021 | 2/3`n" -ForegroundColor Magenta
            Write-Host "[1] - Maximum Office [Access/Excel/PowerPoint/Word/Publisher/Outlook/OneDrive Desktop]"
            Write-Host "[2] - Standart Office [Access/Excel/PowerPoint/Word/Publisher]"
            Write-Host "[3] - Minimal Office [Excel/PowerPoint/Word]"
            Write-Host "`n[0] - Exit"
            $choice_office_version = Read-Host "`nnumber"

            switch ($choice_office_version) {
                '1' {
                    $path_log += "maximum\"
                }
                '2' {
                    $path_log += "standart\"
                }
                '3' {
                    $path_log += "minimal\"
                }
                '0' {
                    exit
                }
                Default {
                    return
                }
            }
            logos
            Write-Host "[process] - Install Office 2021 | 3/3`n" -ForegroundColor Magenta
            $command = "setting\install-office\setup /configure $($path_log + 'configuration.xml')"
            Write-Host "[path] $path_log"
            Start-Sleep -Seconds 5
            Write-Host " |"
            Write-Host "[command] $command"
            check_inet 0
            Invoke-Expression $command
        }
        '2' {
            logos
            Write-Host "[process] Download Windows 10 1/2 `n"-ForegroundColor Magenta
            Write-Host "[1] - Windows 10x64 [22H2]"
            Write-Host "[2] - Windows 10x32 [22H2]"
            Write-Host "`n[0] - Exit"

            $choice_windows_version = Read-Host "`n[number]"
            logos
            Write-Host "[process] Download Windows 10 2/3 `n"-ForegroundColor Magenta
            switch ($choice_windows_version) {
                '1' {
                    $source = 'https://www.itechtics.com/?dl_id=173'
                    $destination = pathget 'win10x64.iso'
                    logos
                    Write-Host "[process] Download Windows 10 3/3 [22H2 (x64)]`n"-ForegroundColor Magenta
                }
                '2' {
                    $source += "https://www.itechtics.com/?dl_id=174"
                    $destination = pathget 'win10x32.iso'
                    logos
                    Write-Host "[process] Download Windows 10 3/3 [22H2 (x64)]`n"-ForegroundColor Magenta
                }
                '0' {
                    exit
                }
                Default {
                    return
                }
            }
            Write-Host "[site] https://www.itechtics.com/windows-10-download-iso/"
            Write-Host " |"
            Write-Host "[path] $destination"
            check_inet 0
            try {
                Invoke-WebRequest -Uri $source -OutFile $destination
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }

            
        }
        '3' {
            logos
            Write-Host "[process] Download Rufus [4.3v]`n"-ForegroundColor Magenta
            $source = "https://github.com/pbatard/rufus/releases/download/v4.3/rufus-4.3.exe"
            $destination = pathget "rufus-4.3.exe"
            logos
            Write-Host "[process] Download Rufus [4.3v] [~1.5mb]`n"-ForegroundColor Magenta
            Write-Host "[path] $destination"
            Write-Host " |"
            Write-Host "[site] $source"
            check_inet 0
            try {
                Invoke-WebRequest -Uri $source -OutFile $destination
                Write-Host " |"
                Write-Host "[admin] true" -ForegroundColor Green
            }
            catch {
                Write-Host " |"
                Write-Host "[admin] false" -ForegroundColor Red
            }

            
        }
        '4' {
            logos
            Write-Host "[process] Download Google Chrome 1/2`n"-ForegroundColor Magenta
            $source = "http://dl.google.com/chrome/install/chrome_installer.exe"
            $destination = pathget "google-chrome.exe"
            logos
            Write-Host "[process] Download Google Chrome 2/2 [~1.5mb]`n"-ForegroundColor Magenta
            Write-Host "[path] $destination"
            Write-Host " |"
            Write-Host "[site] $source"
            check_inet 0
            try {
                Invoke-WebRequest -Uri $source -OutFile $destination
                Write-Host " |"
                Write-Host "[admin] true" -ForegroundColor Green
            }
            catch {
                Write-Host " |"
                Write-Host "[admin] false" -ForegroundColor Red
            }

        }
        '5' {
            logos
            Write-Host "[process] Download MediaCreationTool 1/2`n"-ForegroundColor Magenta
            $source = "https://go.microsoft.com/fwlink/?LinkId=691209"
            $destination = pathget "MediaCreationTool.exe"
            logos
            Write-Host "[process] Download MediaCreationTool 2/2 [~20mb]`n"-ForegroundColor Magenta
            Write-Host "[path] $destination"
            Write-Host " |"
            Write-Host "[site] $source"
            check_inet 0
            try {
                Invoke-WebRequest -Uri $source -OutFile $destination
                Write-Host " |"
                Write-Host "[admin] true" -ForegroundColor Green
            }
            catch {
                Write-Host " |"
                Write-Host "[admin] false" -ForegroundColor Red
            }

        }
        '6' {
            logos
            Write-Host "[process] Download ESET NOD32 Antivirus 1/2`n"-ForegroundColor Magenta
            $source = "https://download.eset.com/com/eset/tools/installers/live_eav/latest/eset_nod32_antivirus_live_installer.exe"
            $destination = pathget "esetnod32antivirus_installer.exe"
            logos
            Write-Host "[process] Download ESET NOD32 Antivirus 2/2 [~10mb]`n"-ForegroundColor Magenta
            Write-Host "[path] $destination"
            Write-Host " |"
            Write-Host "[site] $source"
            check_inet 0
            try {
                Invoke-WebRequest -Uri $source -OutFile $destination
                Write-Host " |"
                Write-Host "[admin] true" -ForegroundColor Green
            }
            catch {
                Write-Host " |"
                Write-Host "[admin] false" -ForegroundColor Red
            }

        }
        '0' {
            return
        }
        Default {
            return
        }
    }


}


function ConfigurationOption {
    logos
    Write-Host "[1] - Check and replace damaged files"
    Write-Host "[2] - Cleaning the %TEMP% folder"
    Write-Host "[3] - Disabling hibernation mode"
    Write-Host "[4] - Uninstall built-in applications in Windows 10 [Full]"
    Write-Host "[5] - Reinstall All Built-in Apps"
    Write-Host "[6] - Evaluation of device speed"
    Write-Host "[7] - View speed rating and device specs"
    Write-Host "[8] - Diskpart"
    Write-Host "`n[0] - Exit"
    $choice_office = Read-Host "`nnumber"

    switch ($choice_office) {
        '1' {
            logos
            Write-Host "[process] checking all system files and replacing damaged files"-ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command] sfc /scannow"
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
                Start-Process cmd -Verb RunAs -ArgumentList "/k echo [command] sfc /scannow && sfc /scannow && pause && exit"
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
            
        }
        '2' {
            logos
            Write-Host "[process] cleaning the %TEMP% folder"-ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command] del /s /f /q %temp%"
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
                Start-Process cmd -ArgumentList "/k echo [command] del /s /f /q %temp% && del /s /f /q %temp% && pause && exit"
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
        }
        '3' {
            logos
            Write-Host "[process] Disabling hibernation mode"-ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command]  powercfg.exe /hibernate off"
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
                Start-Process cmd -Verb RunAs -ArgumentList "/k echo [command]  powercfg.exe /hibernate off &&  powercfg.exe /hibernate off && pause && exit"
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
        }
        '4' {
            logos
            Write-Host "[process] Uninstall built-in applications in Windows 10 [Full]"-ForegroundColor Magenta
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
                Write-Host "[admin] starting the command" -ForegroundColor Green
                Start-Process powershell -Verb RunAs -ArgumentList "-NoExit","-Command","Write-Host '[process] Uninstall built-in applications in Windows 10 [Full]';Get-AppXPackage | Remove-AppxPackage ; Read-Host '[x] Press Enter to exit :'; exit"

            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
        }
        '5' {
            logos
            Write-Host "[process] Reinstall All Built-in Apps"-ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command]  Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ..."
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
               Start-Process powershell -Verb RunAs -ArgumentList "-NoExit","-Command","Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}; Read-Host '[x] Press Enter to exit :'; exit"
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
        }
        '8' {
            logos
            Write-Host "[process] diskpart" -ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command] diskpart"
            Start-Sleep -Seconds 1
            Write-Host " |"
            try {
                diskpart
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
            
        }
        '7' {
            logos
            Write-Host "[process] view speed rating and device specs" -ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command] Get-CimInstance Win32_WinSAT"
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
                Start-Process powershell -ArgumentList "-NoExit","-Command","Get-CimInstance Win32_WinSAT; Read-Host '[x] Press Enter to exit :'; exit"
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }
            
        }
        '6' {
            logos
            Write-Host "[process] evaluation of device speed" -ForegroundColor Magenta
            Write-Host " |"
            Write-Host "[command] winsat formal"
            Start-Sleep -Seconds 5
            Write-Host " |"
            try {
                Start-Process cmd -ArgumentList "-NoExit","-Command","winsat formal; Read-Host '[x] Press Enter to exit :'; exit"
                Write-Host "[admin] starting the command" -ForegroundColor Green
            }
            catch {
                Write-Host "[admin] false the command" -ForegroundColor Red
            }


        }
        '0' {
            return
        }
        Default {
            return
        }
    }

}


homepage