#création du dossier d'install
$TempDirectory = "$ENV:Temp\MainInstallScripts"
$path = $TempDirectory
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}
Clear-Host
$RunScriptSilent = $True

#Fonctions
Function DownloadChrome {
    Write-Host 'Downloading Google Chrome... ' -NoNewLine

    # Test internet connection
    if (Test-Connection google.com -Count 3 -Quiet) {
		if ($OSArchitecture -eq "64-Bit" -and $Installx64 -eq $True){
			$Link = 'http://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise64.msi'
		} ELSE {
			$Link = 'http://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'
		}
    

        # Download the installer from Google
        try {
	        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
	        (New-Object System.Net.WebClient).DownloadFile($Link, "$TempDirectory\Chrome.msi")
            Write-Host 'success!' -ForegroundColor Green
        } catch {
	        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
            if ($RunScriptSilent -NE $True){
                Read-Host 'Press [Enter] to exit'
            }
	        exit
        }
    } else {
        Write-Host "failed. Unable to connect to Google's servers." -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}
Function Install-Chrome {
    Write-Host 'Installing Chrome... ' -NoNewline

    # Install Chrome
    $ChromeMSI = """$TempDirectory\Chrome.msi"""
	$ExitCode = (Start-Process -filepath msiexec -argumentlist "/i $ChromeMSI /qn /norestart" -Wait -PassThru).ExitCode
    
    if ($ExitCode -eq 0) {
        Write-Host 'success!' -ForegroundColor Green
    } else {
        Write-Host "failed. There was a problem installing Google Chrome. MsiExec returned exit code $ExitCode." -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}
Function DownloadFirefox {
    Write-Host 'Downloading Mozilla Firefox... ' -NoNewLine
    $Link = 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=fr'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\Firefox.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-Firefox {
    Write-Host 'Installing Mozilla Firefox... ' -NoNewline
    $ExitCode = (Start-Process -Wait -FilePath "$TempDirectory\firefox.exe" -ArgumentList '/S','/v','/qn' -passthru).ExitCode
    if ($ExitCode -eq 0) {
        Write-Host 'success!' -ForegroundColor Green
    } else {
        Write-Host "failed. There was a problem installing Mozilla Firefox. MsiExec returned exit code $ExitCode." -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}
Function Downloadzip {
    Write-Host 'Downloading 7zip... ' -NoNewLine
    $Link = 'https://www.7-zip.org/a/7z1900-x64.exe'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\7zip.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-zip {
    Write-Host 'Installing 7zip... ' -NoNewline
    $ExitCode = (Start-Process -Wait -FilePath "$TempDirectory\7zip.exe" -ArgumentList '/S','/v','/qn' -passthru).ExitCode
    if ($ExitCode -eq 0) {
        Write-Host 'success!' -ForegroundColor Green
    } else {
        Write-Host "failed. There was a problem installing 7zip. MsiExec returned exit code $ExitCode." -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}
Function Downloaddrvbooster {
    Write-Host 'Downloading Driver Booster... ' -NoNewLine
    $Link = 'https://cdn.iobit.com/dl/driver_booster_setup.exe'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\drvbooster.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-drvbooster {
    Write-Host 'Installing Driver Booster... ' -NoNewline
    (Start-Process -FilePath "$TempDirectory\drvbooster.exe" -ArgumentList '/S','/v','/qn' -passthru)
    Write-Host 'success!' -ForegroundColor Green
}
Function Downloadvlc {
    Write-Host 'Downloading VLC... ' -NoNewLine
    $Link = 'https://get.videolan.org/vlc/3.0.12/win64/vlc-3.0.12-win64.exe'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\vlc-3.0.12-win64.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-vlc {
    Write-Host 'Installing VLC... ' -NoNewline
    Start-Process -Wait -FilePath "$TempDirectory\vlc-3.0.12-win64.exe" -ArgumentList '/S'
    Write-Host 'Installing VLC... ' -NoNewline
    Write-Host 'success!' -ForegroundColor Green
}
Function Downloaddiscord {
    Write-Host 'Downloading Discord... ' -NoNewLine
    $Link = 'https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\discord.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-discord {
    Write-Host 'Installing Discord... ' -NoNewline
    Start-Process -FilePath "$TempDirectory\discord.exe" -ArgumentList '/S'
    Write-Host 'success!' -ForegroundColor Green
}
Function Downloadaimp {
    Write-Host 'Downloading AIMP3... ' -NoNewLine
    $Link = 'https://www.aimp.ru/?do=download.file&id=4'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\aimp.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-aimp {
    Write-Host 'Installing AIMP3... ' -NoNewline
    & "$Tempdirectory\aimp.exe" /Silent /Auto /Wait
    Write-Host 'success!' -ForegroundColor Green
}
Function DownloadPlex {
    Write-Host 'Downloading Plex (player)... ' -NoNewLine
    $Link = 'https://downloads.plex.tv/plex-desktop/1.31.0.2254-43df1e6e/windows/Plex-1.31.0.2254-43df1e6e-x86_64.exe'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\plex.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-Plex {
    Write-Host 'Installing Plex... ' -NoNewline
    Start-Process -FilePath "$TempDirectory\plex.exe" -ArgumentList '/S'
    Write-Host 'success!' -ForegroundColor Green
}
Function DownloadqBittorrent{
    Write-Host 'Downloading qBittorrent... ' -NoNewLine
    $Link = 'https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-4.3.4.1/qbittorrent_4.3.4.1_x64_setup.exe/download'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\qBittorrent.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-qBittorrent {
    Write-Host 'Installing qBittorrent... ' -NoNewline
     & "$Tempdirectory\qBittorrent.exe" /Silent /Auto /Wait
    Write-Host 'success!' -ForegroundColor Green
}
Function Downloadghub {
    Write-Host 'Downloading Logitech G-HUB... ' -NoNewLine
    $Link = 'https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\lghub.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-ghub {
    Write-Host 'Installing Logitech G-HUB... ' -NoNewline
    Start-Process -FilePath "$TempDirectory\lghub.exe" -ArgumentList '/S','/v','/qn' -passthru

}
Function Downloadsynapse {
    Write-Host 'Downloading Razer Synapse 3... ' -NoNewLine
    $Link = 'https://rzr.to/synapse-3-pc-download'
    try {
        New-Item -ItemType Directory "$TempDirectory" -Force | Out-Null
        (New-Object Net.WebClient).DownloadFile($Link, "$TempDirectory\synapse.exe")
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host 'failed. There was a problem with the download.' -ForegroundColor Red
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
        exit
    }
}
Function Install-synapse {
    Write-Host 'Installing Razer Synapse 3... ' -NoNewline
    Start-Process -FilePath "$TempDirectory\synapse.exe"
    Write-Host 'success!' -ForegroundColor Green   
}
#Menu install
do {
    Write-Host "============= Install Google Chrome ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "===================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{DownloadChrome
            Install-Chrome}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install Mozilla Firefox ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "======================================================"
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{DownloadFirefox 
            Install-Firefox}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install 7zip ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "==========================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloadzip
            Install-zip}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install Driver Booster ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "====================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloaddrvbooster
            Install-drvbooster}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install VLC ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "=========================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloadvlc
            Install-vlc}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install Discord ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "=============================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloaddiscord
            Install-discord}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install AIMP3 ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "============================================"
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloadaimp
            Install-aimp}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install Plex (player) ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "===================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{DownloadPlex
            Install-Plex}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install qBittorrent ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "===================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{DownloadqBittorrent
            Install-qBittorrent}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install Logitech G-HUB ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "====================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloadghub
            Install-ghub}
        "N"{break}
    }
Write-Host ""
do {
    Write-Host "============= Install Razer Synapse 3 ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "====================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"{Downloadsynapse
            Install-synapse}
        "N"{break}
    }
Write-Host ""
Pause
Remove-Item "$ENV:Temp\MainInstallScripts" -Recurse
