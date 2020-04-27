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
    "autohotkey",
    "bat",
    "coreutils",
    "discord",
    "dos2unix",
    "everything",
    "fd",
    "freecommander",
    "keepassxc",
    "netcat",
    "notepadplusplus",
    "putty",
    "python",
    "ripgrep",
    "slack",
    "sudo",
    "vscode",
    "wget",
    "windows-terminal",
    "winmerge"
)

Write-Host "Installing scoop tools" -ForegroundColor Cyan
foreach ($Tool in $UserTools) {
    scoop install $Tool
}

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

Write-Host "Setting keyboard repeat speed and delay" -ForegroundColor Cyan
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardSpeed" 31
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardDelay" 0

Write-Host "Launching linking script with administrator rights" -ForegroundColor Cyan
sudo cmd /c "%DOTFILES%\bin\link-all.bat"

Write-Host "Installing PowerShell modules"
Install-Module Jump.Location -Scope CurrentUser -Force

Write-Host "Add to PATH: $Destination\bin" -ForegroundColor Cyan
Write-Host "Add to PATH: $env:USERPROFILE\OneDrive\Windows" -ForegroundColor Cyan

Write-Host "Configuration bootstraping finished!" -ForegroundColor Green
