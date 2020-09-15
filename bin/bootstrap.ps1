$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

if (-Not (Get-Command scoop)) {
    Write-Host "Installing scoop" -ForegroundColor Cyan
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")
}

scoop install git
scoop bucket add extras

$UserTools = @(
    "7zip",
    "archwsl",
    "aria2",
    "autohotkey",
    "bat",
    "bitwarden",
    "coreutils",
    "discord",
    "fd",
    "firefox",
    "kitty",
    "latex",
    "netcat",
    "nodejs-lts",
    "notepadplusplus",
    "paint.net",
    "perl",
    "powertoys",
    "python",
    "ripgrep",
    "slack",
    "sudo",
    "vlc",
    "vscode",
    "wget"
)

Write-Host "Installing scoop tools" -ForegroundColor Cyan
foreach ($Tool in $UserTools) {
    scoop install $Tool
}

scoop hold archwsl

if (Test-Path "$Destination" -PathType Container) {
    Write-Host "Updating existing dotfiles" -ForegroundColor Cyan
    Set-Location -Path "$Destination"
    git pull
} else {
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

Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
sudo cmd /c "$Destination\bin\link-all.bat"

Write-Host "Installing PowerShell modules"
Install-Module Jump.Location -Scope CurrentUser -Force

Write-Host "Enabling WSL" -ForegroundColor Cyan
sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Add these directories to PATH manually:" -ForegroundColor Cyan
Write-Host "    $Destination\bin"
Write-Host "    $env:USERPROFILE\OneDrive\Windows"
Write-Host

Write-Host "wsl --set-default-version 2"

Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
