$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

function Run-Bootstrap {
    if (-Not (Get-Command winget 2> $null)) {
        Write-Host "Unable to launch winget!" -ForegroundColor Red
        Write-Host "Install Windows Package Manager from https://github.com/microsoft/winget-cli/releases" -ForegroundColor Yellow
        return
    }

    $WingetPackages = @(
        "7zip.7zip",
        "Azul.Zulu.16",
        "CrystalRich.LockHunter",
        "Discord.Discord",
        "flux.flux",
        "gerardog.gsudo",
        "Ghisler.TotalCommander",
        "Microsoft.PowerToys",
        "Microsoft.VisualStudio.2019.BuildTools",
        "Microsoft.VisualStudioCode",
        "Microsoft.WindowsTerminal",
        "Notepad++.Notepad++",
        "SublimeHQ.SublimeMerge",
        "SublimeHQ.SublimeText.4",
        "Telegram.TelegramDesktop",
        "VideoLAN.VLC",
        "voidtools.Everything",
        "WinDirStat.WinDirStat"
    )

    Write-Host "Installing applications using winget" -ForegroundColor Cyan
    foreach ($Package in $WingetPackages) {
        Write-Host "Installing winget package $Package..." -ForegroundColor Yellow
        winget install --exact --silent --id=$Package
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
        "clink",
        "cmake",
        "delta",
        "dust",
        "fd",
        "fzf",
        "git",
        "jq",
        "less",
        "lsd",
        "lua",
        "neovim",
        "ninja",
        "python",
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
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\totalcmd;$env:USERPROFILE\OneDrive\Windows\bin;$env:LOCALAPPDATA\clink;C:\Program Files\Sublime Text", "User")

    Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
    gsudo --wait cmd /c "$Destination\bin\link-all.bat"

    Write-Host "Enabling SSH Agent" -ForegroundColor Cyan
    Set-Service -StartupType Automatic ssh-agent
    Start-Service ssh-agent

    Write-Host "Enabling WSL" -ForegroundColor Cyan
    gsudo --wait dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    gsudo --wait dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    Write-Host "Enabling clink autostart" -ForegroundColor Cyan
    clink autorun install

    Write-Host "Downloading Plugin Manager for Neovim"
    Invoke-WebRequest -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" |`
        New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

    Write-Host "Installing plugins for Neovim"
    nvim +PlugInstall +qall

    Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Remember to execute after rebooting"
    Write-Host "    wsl --set-default-version 2" -ForegroundColor Yellow
}

Run-Bootstrap
