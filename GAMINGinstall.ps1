#Commande Check + créer un dossier
$path = "C:\TEST"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

#Install Redist
"Downloading DirectX"
$wc = New-Object net.webclient
$wc.Downloadfile("https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe", "C:\TEST\dxsetup.exe")
"Installing DirectX"
Start-Process -Wait -FilePath "C:\TEST\dxsetup.exe" 
"Downloading package redistribuable Microsoft Visual C ++ pour Visual Studio 2015, 2017 & 2019"
$wc = New-Object net.webclient
$wc.Downloadfile("https://aka.ms/vs/16/release/vc_redist.x64.exe", "C:\TEST\vcredist64.exe")
"Installing package redistribuable Microsoft Visual C ++ pour Visual Studio 2015, 2017 & 2019"
Start-Process -Wait -FilePath "C:\TEST\vcredist64.exe" 
"Downloading package redistribuable Microsoft Visual C ++ pour Visual Studio 2015, 2017 & 2019"
$wc = New-Object net.webclient
$wc.Downloadfile("https://aka.ms/vs/16/release/vc_redist.x86.exe", "C:\TEST\vcredist32.exe")
"Installing package redistribuable Microsoft Visual C ++ pour Visual Studio 2015, 2017 & 2019"
Start-Process -Wait -FilePath "C:\TEST\vcredist32.exe" 
"Downloading .NET 3.5 SP1"
$wc = New-Object net.webclient
$wc.Downloadfile("https://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe", "C:\TEST\dotnet.exe")
"Installing .NET 3.5 SP1"
Start-Process -Wait -FilePath "C:\TEST\dotnet.exe" 

#Install Bnet
Write-Host "============= Istall Blizzard Battle.net ? =============="
Write-Host "`t1. Press 'Y' for YES"
Write-Host "`t2. Press 'N' for NO"
Write-Host "========================================================="
$choice = Read-Host "`nEnter Choice"
switch ($choice) {
    'Y'{
        Write-Host "`nYou have selected YES"
        "Downloading B.net"
        $wc = New-Object net.webclient
        $wc.Downloadfile("https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live", "C:\TEST\bnet.exe")
        "Installing B.net"
        Start-Process -Wait -FilePath "C:\TEST\bnet.exe" -ArgumentList '/S','/v','/qn' -passthru
    }

    'N'{Return}
 }
 
 #Install Steam
 Write-Host "============= Istall STEAM ? =============="
 Write-Host "`t1. Press 'Y' for YES"
 Write-Host "`t2. Press 'N' for NO"
 Write-Host "==========================================="
 $choice = Read-Host "`nEnter Choice"
 
 switch ($choice) {
     'Y'{
         Write-Host "`nYou have selected YES"
         "Downloading Steam"
 $wc = New-Object net.webclient
 $wc.Downloadfile("https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe", "C:\TEST\steam.exe")
 "Installing Steam"
 Start-Process -Wait -FilePath "C:\TEST\steam.exe" -ArgumentList '/S','/v','/qn' -passthru
     }
 
     'N'{Return}
  }

#Install Epic Games Store
Write-Host "============= Istall EPIC GAMES STORE ? =============="
Write-Host "`t1. Press 'Y' for YES"
Write-Host "`t2. Press 'N' for NO"
Write-Host "======================================================"
$choice = Read-Host "`nEnter Choice"

switch ($choice) {
    'Y'{
        Write-Host "`nYou have selected YES"
        "Downloading Epic Games Store"
$wc = New-Object net.webclient
$wc.Downloadfile("https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi", "C:\TEST\epic.msi")
"Installing Epic Games Store"
Start-Process -Wait -FilePath "C:\TEST\epic.msi" -ArgumentList '/quiet','/passive'
    }

    'N'{Return}
 }

#Install Origin
Write-Host "============= Istall EA ORIGIN ? =============="
Write-Host "`t1. Press 'Y' for YES"
Write-Host "`t2. Press 'N' for NO"
Write-Host "======================================================"
$choice = Read-Host "`nEnter Choice"

switch ($choice) {
    'Y'{
        Write-Host "`nYou have selected YES"
        "Downloading Origin"
        $wc = New-Object net.webclient
        $wc.Downloadfile("https://www.dm.origin.com/download", "C:\TEST\origin.exe")
        "Installing Origin"
        Start-Process -Wait -FilePath "C:\TEST\origin.exe" -ArgumentList '/S','/v','/qn' -passthru
    }

    'N'{Return}
 }
#Install Ubisoft Connect
"Downloading Ubisoft Connect"
$wc = New-Object net.webclient
$wc.Downloadfile("https://ubi.li/4vxt9", "C:\TEST\uplay.exe")
"Installing Ubisoft Connect"
Start-Process -Wait -FilePath "C:\TEST\uplay.exe" -ArgumentList '/S','/v','/qn' -passthru