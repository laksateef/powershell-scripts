$path = "C:\TEST"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}
Clear-Host
do {
    Write-Host "============= Install Chrome ? =============="
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host "============================================"
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
#Install Chrome
Write-Host 'Please allow several minutes for the install to complete. '
# Install Google Chrome x64 on 64-Bit systems? $True or $False
$Installx64 = $True
# Define the temporary location to cache the installer.
$TempDirectory = "$ENV:Temp\Chrome"
# Run the script silently, $True or $False
$RunScriptSilent = $True
# Set the system architecture as a value.
$OSArchitecture = (Get-WmiObject Win32_OperatingSystem).OSArchitecture
# Exit if the script was not run with Administrator priveleges
$User = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-not $User.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )) {
	Write-Host 'Please run again with Administrator privileges.' -ForegroundColor Red
    if ($RunScriptSilent -NE $True){
        Read-Host 'Press [Enter] to exit'
    }
    exit
}


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
        Clean-Up
        if ($RunScriptSilent -NE $True){
            Read-Host 'Press [Enter] to exit'
        }
	    exit
    }
}

Function CleanUp {
    Write-Host 'Removing Chrome installer... ' -NoNewline

    try {
        # Remove the installer
        Remove-Item "$TempDirectory\Chrome.msi" -ErrorAction Stop
        Write-Host 'success!' -ForegroundColor Green
    } catch {
        Write-Host "failed. You will have to remove the installer yourself from $TempDirectory\." -ForegroundColor Yellow
    }
}

DownloadChrome
Install-Chrome
CleanUp

if ($RunScriptSilent -NE $True){
    Read-Host 'Install complete! Press [Enter] to exit'
}
        }
        "N"{break}
    }
    Write-Host ""
do {
    Write-Host "============= Install Mozilla Firefox ? =============="
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
        "Y"
        {
            write-host "Download... " -nonewline
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=fr", "C:\TEST\firefox.exe")
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
            write-host "Installing... " -ForegroundColor Yellow
            Write-Host ""
            Start-Process -Wait -FilePath "C:\TEST\firefox.exe" -ArgumentList '/S','/v','/qn' -passthru
            Write-Host ""
            Write-Host "Installing... " -NoNewline
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
        }
        "N"{break}
    }
    Write-Host ""
    do {
        Write-Host "============= Install 7zip ? =============="
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
            "Y"
            {
                write-host "Download... " -nonewline
                [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                Invoke-WebRequest -Uri "https://www.7-zip.org/a/7z1900-x64.exe" -OutFile "C:\TEST\7zip.exe"
                Write-Host 'success!' -ForegroundColor Green
                Write-Host ""
                write-host "Installing... " -ForegroundColor Yellow
                Write-Host ""
                Start-Process -Wait -FilePath "C:\TEST\7zip.exe" -ArgumentList '/S','/v','/qn' -passthru
                Write-Host ""
                Write-Host "Installing... " -NoNewline
                Write-Host 'success!' -ForegroundColor Green
                Write-Host ""
            }
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
            "Y"
                {
                    write-host "Download... " -nonewline
                    $wc = New-Object net.webclient
                    $wc.Downloadfile("https://cdn.iobit.com/dl/driver_booster_setup.exe", "C:\TEST\driverbooster.exe")
                    Write-Host 'success!' -ForegroundColor Green
                    Write-Host ""
                    write-host "Installing... " -ForegroundColor Yellow
                    Write-Host ""
                    Start-Process -Wait -FilePath "C:\TEST\driverbooster.exe" -ArgumentList '/Q'
                    Write-Host ""
                    Write-Host "Installing... " -NoNewline
                    Write-Host 'success!' -ForegroundColor Green
                    Write-Host ""
                }
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
        "Y"
        {
            write-host "Download... " -nonewline
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://videolan.mirror.garr.it/mirrors/videolan/vlc/3.0.12/win64/vlc-3.0.12-win64.exe", "C:\TEST\VLC.exe")
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
            write-host "Installing... " -ForegroundColor Yellow
            Write-Host ""
            Start-Process -Wait -FilePath "C:\TEST\VLC.exe" -passthru
            Write-Host ""
            Write-Host "Installing... " -NoNewline
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
        }
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
        "Y"
        {
            write-host "Download... " -nonewline
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86", "C:\TEST\discord.exe")
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
            write-host "Installing... " -ForegroundColor Yellow
            Write-Host ""
            Start-Process -FilePath "C:\TEST\discord.exe" -ArgumentList '/S','/v','/qn' -passthru
            Write-Host ""
            Write-Host "Installing... " -NoNewline
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""         
        }
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
        "Y"
        {
            write-host "Download... " -nonewline
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://www.aimp.ru/?do=download.file&id=4", "C:\TEST\aimp.exe")
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
            write-host "Installing... " -ForegroundColor Yellow
            Write-Host ""
            Start-Process -Wait -FilePath "C:\TEST\aimp.exe" -ArgumentList '/S','/v','/qn' -passthru
            Write-Host ""
            Write-Host "Installing... " -NoNewline
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
        }
        "N"{break}
    }
    Write-Host ""
do {
    Write-Host "============= Install Plex (Player) ? =============="
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
        "Y"
        {
            write-host "Download... " -nonewline
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://downloads.plex.tv/plex-desktop/1.31.0.2254-43df1e6e/windows/Plex-1.31.0.2254-43df1e6e-x86_64.exe", "C:\TEST\plex.exe")
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
            write-host "Installing... " -ForegroundColor Yellow
            Write-Host ""
            Start-Process -FilePath "C:\TEST\plex.exe" -ArgumentList '/S','/v','/qn' -passthru
            Write-Host ""
            Write-Host "Installing... " -NoNewline
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""       
        }
        "N"{break}
    }
    Write-Host ""
do {
    Write-Host "============= Install qBittorrent ? =============="
    Write-Host ""
    Write-Host "`t1. Press 'Y' for YES"
    Write-Host "`t2. Press 'N' for NO"
    Write-Host ""
    Write-Host "=================================================="
    Write-Host ""
    write-host -nonewline "Type your choice and press Enter: "
        $choice = read-host
        write-host ""
        $ok = $choice -match '^[yn]+$'   
        if ( -not $ok) { write-host "Invalid selection" }
    } until ( $ok )
    switch -Regex ( $choice ) {
        "Y"
        {
            write-host "Download... " -nonewline
            $wc = New-Object net.webclient
            $wc.Downloadfile("https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-4.3.4.1/qbittorrent_4.3.4.1_x64_setup.exe/download", "C:\TEST\torrent.exe")
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
            write-host "Installing... " -ForegroundColor Yellow
            Write-Host ""
            Start-Process -Wait -FilePath "C:\TEST\torrent.exe" -ArgumentList '/S','/v','/qn' -passthru
            Write-Host ""
            Write-Host "Installing... " -NoNewline
            Write-Host 'success!' -ForegroundColor Green
            Write-Host ""
        }
        "N"{break}
    }
    Write-Host ""
    Remove-Item 'c:\TEST' -Recurse
Pause