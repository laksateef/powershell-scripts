#Commande Check + créer un dossier
$path = "C:\tempscripts"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}
Clear-Host
#Install Redist
"Downloading DirectX"
$wc = New-Object net.webclient
$wc.Downloadfile("https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe", "C:\tempscripts\dxsetup.exe")
"Installing ..."
Start-Process -Wait -FilePath "C:\tempscripts\dxsetup.exe" -ArgumentList '/Q'
Clear-Host
"Downloading package redistribuable Microsoft Visual C ++ pour Visual Studio 2015, 2017 & 2019"
$wc = New-Object net.webclient
$wc.Downloadfile("https://aka.ms/vs/16/release/vc_redist.x64.exe", "C:\tempscripts\vcredist64.exe")
"Installing ..."
Start-Process -Wait -FilePath "C:\tempscripts\vcredist64.exe" -ArgumentList '/Q'
Clear-Host
"Downloading package redistribuable Microsoft Visual C ++ pour Visual Studio 2015, 2017 & 2019"
$wc = New-Object net.webclient
$wc.Downloadfile("https://aka.ms/vs/16/release/vc_redist.x86.exe", "C:\tempscripts\vcredist32.exe")
"Installing ..."
Start-Process -Wait -FilePath "C:\tempscripts\vcredist32.exe" -ArgumentList '/Q'
Clear-Host
"Downloading .NET 3.5 SP1"
$wc = New-Object net.webclient
$wc.Downloadfile("https://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe", "C:\tempscripts\dotnet.exe")
"Installing .NET 3.5 SP1"
Start-Process -Wait -FilePath "C:\tempscripts\dotnet.exe" 
Clear-Host

do {
    Write-Host "============= Install nVidia GeForce Experience ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "================================================================"
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            "Downloading nVidia GeForce Experience "
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://fr.download.nvidia.com/GFE/GFEClient/3.21.0.36/GeForce_Experience_v3.21.0.36.exe", "C:\tempscripts\gfe.exe")
            "Installing nVidia GeForce Experience "
            Start-Process -FilePath "C:\tempscripts\gfe.exe" -ArgumentList '/S','/v','/qn' -passthru
        }
        "N"{break}
    }
Clear-Host
do {
    Write-Host "============= Install Blizzard Battle.net ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "========================================================="
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            "Downloading B.net"
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live", "C:\tempscripts\bnet.exe")
            "Installing B.net"
            Start-Process -FilePath "C:\tempscripts\bnet.exe" -ArgumentList '/S','/v','/qn' -passthru
        }
        "N"{break}
    }
Clear-Host
do {
    Write-Host "============= Install Steam ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "==========================================="
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            "Downloading Steam"
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe", "C:\tempscripts\steam.exe")
            "Installing Steam"
            Start-Process -Wait -FilePath "C:\tempscripts\steam.exe" -ArgumentList '/S','/v','/qn' -passthru            
        }
        "N"{break}
    }
Clear-Host
do {
    Write-Host "============= Install EA Origin ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "==============================================="
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            "Downloading Origin"
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://www.dm.origin.com/download", "C:\tempscripts\origin.exe")
            "Installing Origin"
            Start-Process -FilePath "C:\tempscripts\origin.exe" -ArgumentList '/S','/v','/qn' -passthru            
        }
        "N"{break}
    }
Clear-Host
do {
    Write-Host "============= Install EPIC GAMES STORE ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "======================================================"
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            "Downloading Epic Games Store"
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi", "C:\tempscripts\epic.msi")
            "Installing Epic Games Store"
            Start-Process -Wait -FilePath "C:\tempscripts\epic.msi" -ArgumentList '/quiet','/passive'           
        }
        "N"{break}
    }
Clear-Host
do {
    Write-Host "============= Install Ubisoft Connect ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "======================================================"
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            "Downloading Ubisoft Connect"
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://ubi.li/4vxt9", "C:\tempscripts\uplay.exe")
            "Installing Ubisoft Connect"
            Start-Process -Wait -FilePath "C:\tempscripts\uplay.exe" -ArgumentList '/S','/v','/qn' -passthru       
        }
        "N"{break}
    }
Clear-Host
Remove-Item 'c:\tempscripts' -Recurse
Pause