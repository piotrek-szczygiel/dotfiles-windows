$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

if (-Not (Get-Command choco.exe)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    choco upgrade chocolatey
}

$ChocolateyPackages = @(
    "7zip",
    "correttojdk",
    "discord",
    "everything",
    "git",
    "gsudo",
    "lockhunter",
    "microsoft-windows-terminal",
    "neovim",
    "notepadplusplus",
    "powertoys",
    "python",
    "telegram",
    "totalcommander",
    "vlc",
    "vscode",
    "windirstat"
)

Write-Host "Installing applications using chocolatey" -ForegroundColor Cyan
foreach ($Package in $ChocolateyPackages) {
    choco install $Package --yes
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
[Environment]::SetEnvironmentVariable("FZF_DEFAULT_OPTS", "--height 40%", "User")

Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
gsudo --wait cmd /c "$Destination\bin\link-all.bat"

Write-Host "Enabling SSH Agent" -ForegroundColor Cyan
Start-Service ssh-agent
Set-Service -StartupType Automatic ssh-agent

Write-Host "Enabling WSL" -ForegroundColor Cyan
gsudo --wait dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
gsudo --wait dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Downloading Plugin Manager for Neovim"
Invoke-WebRequest -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" | New-Item "$HOME/vimfiles/autoload/plug.vim" -Force

Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
Write-Host "Download clink from https://github.com/chrisant996/clink/releases"
Write-Host ""
Write-Host "Remember to execute after rebooting"
Write-Host "    wsl --set-default-version 2" -ForegroundColor Yellow
