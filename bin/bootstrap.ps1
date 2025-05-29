$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

function Reset-Env {
    Set-Item -Path (('Env:', $args[0]) -Join '') -Value ((
            [System.Environment]::GetEnvironmentVariable($args[0], "Machine"),
            [System.Environment]::GetEnvironmentVariable($args[0], "User")
        ) -Match '.' -Join ';')
}

function Add-To-Path($Path) {
    [Environment]::SetEnvironmentVariable("Path", [System.Environment]::GetEnvironmentVariable("Path", "User") + ";" + $Path, "User")
}

function Start-Bootstrap {
    if (-Not (Get-Command winget 2> $null)) {
        Write-Host "Unable to launch winget!" -ForegroundColor Red
        Write-Host "Install App Installer from Microsoft Store!" -ForegroundColor Yellow
        return
    }

    $WingetPackages = @(
        @("7zip.7zip",                   "--silent"),
        @("Git.Git",                     "--interactive"),
        @("Microsoft.VisualStudioCode",  "--interactive"),
        @("Python.Python.3.13",          "--silent")
    )

    Write-Host "Installing applications using winget" -ForegroundColor Cyan
    foreach ($Package in $WingetPackages) {
        Write-Host "Installing winget package $($Package[0])..." -ForegroundColor Yellow
        winget install --exact --id $Package[0] $Package[1]
    }

    if (-Not (Get-Command scoop 2> $null)) {
        Write-Host "Installing scoop..." -ForegroundColor Cyan
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")
    }
    else {
        Write-Host "Scoop already installed. Updating..."
        scoop update
        scoop update *
    }

    $ScoopPackages = @(
        "bat",
        "bun",
        "clink",
        "clink-flex-prompt",
        "coreutils",
        "delta",
        "eza",
        "fd",
        "gh",
        "less",
        "lua",
        "make",
        "neovim",
        "ripgrep",
        "tokei",
        "zoxide"
    )

    Write-Host "Installing scoop packages" -ForegroundColor Cyan
    foreach ($Package in $ScoopPackages) {
        Write-Host "Installing scoop package $Package..." -ForegroundColor Yellow
        scoop install $Package
    }

    Reset-Env Path

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
    [Environment]::SetEnvironmentVariable("LC_ALL", "C.UTF-8", "User")

    Add-To-Path "$env:USERPROFILE\OneDrive\Windows\bin"
    Add-To-Path "$env:LOCALAPPDATA\clink"

    Reset-Env Path
    Reset-Env dotfiles

    Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
    sudo python "$Destination\bin\link-all.py"

    Write-Host "Enabling clink autorun" -ForegroundColor Cyan
    & "C:\Program Files (x86)\clink\clink_x64.exe" autorun install

    Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
}

Start-Bootstrap
