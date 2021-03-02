$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

if (-Not (Get-Command winget)) {
    Write-Host "Install winget from https://github.com/microsoft/winget-cli/releases" -ForegroundColor Red
    exit 1
}

$UserTools = @(
    "7zip.7zip",
    "Amazon.Corretto",
    "CrystalRich.LockHunter",
    "Discord.Discord",
    "Fork.Fork",
    "gerardog.gsudo",
    "Git.Git",
    "Microsoft.PowerToys",
    "Microsoft.VisualStudioCode-User-x64",
    "Microsoft.WindowsTerminal",
    "Notepad++.Notepad++",
    "Python.Python",
    "Telegram.TelegramDesktop",
    "voidtools.Everything",
    "WinDirStat.WinDirStat",
    "WinSCP.WinSCP"
)

Write-Host "Installing applications using winget" -ForegroundColor Cyan
foreach ($Tool in $UserTools) {
    winget install --silent --exact --id="$Tool"
}

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

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

Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
gsudo --wait cmd /c "$Destination\bin\link-all.bat"

Write-Host "Installing PowerShell modules"
Install-Module Jump.Location -Scope CurrentUser -Force

Write-Host "Enabling WSL" -ForegroundColor Cyan
gsudo --wait dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
gsudo --wait dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
Write-Host "Remember to execute after rebooting"
Write-Host "    wsl --set-default-version 2" -ForegroundColor Yellow
