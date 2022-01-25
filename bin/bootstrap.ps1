$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

function Add-To-Path($Path) {
    [Environment]::SetEnvironmentVariable("Path", [System.Environment]::GetEnvironmentVariable("Path", "User") + ";" + $Path, "User")
}

function Run-Bootstrap {
    if (-Not (Get-Command winget 2> $null)) {
        Write-Host "Unable to launch winget!" -ForegroundColor Red
        Write-Host "Install App Installer from Microsoft Store!" -ForegroundColor Yellow
        return
    }

    $WingetPackages = @(
        "7zip.7zip",
        "chrisant996.Clink",
        "Discord.Discord",
        "gerardog.gsudo",
        "Git.Git",
        "Microsoft.PowerToys",
        "Microsoft.VisualStudioCode",
        "Python.Python.3",
        "Telegram.TelegramDesktop",
        "VideoLAN.VLC"
    )

    Write-Host "Installing applications using winget" -ForegroundColor Cyan
    foreach ($Package in $WingetPackages) {
        Write-Host "Installing winget package $Package..." -ForegroundColor Yellow
        winget install --exact --silent --id $Package
    }

    if (-Not (Get-Command scoop 2> $null)) {
        Write-Host "Installing scoop..." -ForegroundColor Cyan
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")
    } else {
        Write-Host "Scoop already installed. Updating..."
        scoop update
        scoop update *
    }

    $ScoopPackages = @(
        "bat",
        "fd",
        "fzf",
        "jq",
        "less",
        "lsd",
        "lua",
        "ripgrep",
        "tokei"
    )

    Write-Host "Installing scoop packages" -ForegroundColor Cyan
    foreach ($Package in $ScoopPackages) {
        Write-Host "Installing scoop package $Package..." -ForegroundColor Yellow
        scoop install $Package
    }

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    if (Test-Path "$Destination" -PathType Container) {
        Write-Host "Updating existing dotfiles" -ForegroundColor Cyan
        Set-Location -Path "$Destination"
        git pull
    }
    else {
        Write-Host "Downloading dotfiles" -ForegroundColor Cyan
        git clone "$CloneUrl" "$Destination"
        Set-Location -Path "$Destination"
        git remote set-url origin "$PushUrl"
    }

    Write-Host "Setting environment variables" -ForegroundColor Cyan
    [Environment]::SetEnvironmentVariable("HOME", "$env:USERPROFILE", "User")
    [Environment]::SetEnvironmentVariable("dotfiles", "$Destination", "User")
    [Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")
    [Environment]::SetEnvironmentVariable("LC_ALL", "C.UTF-8", "User")
    [Environment]::SetEnvironmentVariable("FZF_DEFAULT_OPTS", "--height 40% --ansi", "User")

    Add-To-Path "$env:USERPROFILE\OneDrive\Windows\bin"
    Add-To-Path "$env:LOCALAPPDATA\clink"

    Write-Host "Updating python packages" -ForegroundColor Cyan
    python -m pip install --upgrade pip
    pip install --upgrade black flake8

    gsudo cache on

    Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
    gsudo --wait python "$Destination\bin\link-all.py"

    Write-Host "Enabling SSH Agent" -ForegroundColor Cyan
    Set-Service -StartupType Automatic ssh-agent
    Start-Service ssh-agent

    gsudo cache off

    Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
}

Run-Bootstrap
