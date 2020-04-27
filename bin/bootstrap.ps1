$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

if (-Not (Get-Command scoop)) {
    Write-Host "Installing scoop"
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
    "lsd",
    "netcat",
    "notepadplusplus",
    "putty",
    "python",
    "ripgrep",
    "slack",
    "sudo",
    "vscode",
    "wget",
    "winmerge"
)

Write-Host "Installing scoop tools"
foreach ($Tool in $UserTools) {
    scoop install $Tool
}

if (Test-Path "$Destination" -PathType Container) {
    Write-Host "Updating existing dotfiles"
    Set-Location -Path "$Destination"
    git pull
} else {
    Write-Host "Downloading dotfiles"
    git clone "$CloneUrl" "$Destination"
    Set-Location -Path "$Destination"
    git remote set-url origin "$PushUrl"
}

Write-Host "Setting environment variables"
[Environment]::SetEnvironmentVariable("HOME", "$env:USERPROFILE", "User")
[Environment]::SetEnvironmentVariable("dotfiles", "$Destination", "User")
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")
[Environment]::SetEnvironmentVariable("LC_ALL", "C.UTF-8", "User")

Write-Host "Setting keyboard repeat speed and delay"
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardSpeed" 31
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardDelay" 0

Write-Host "Launching linking script with administrator rights"
sudo cmd /c "%DOTFILES%\bin\link-all.bat"

Write-Host "Installing PowerShell modules"
Install-Module Jump.Location -Scope CurrentUser

Write-Host "Add to PATH: $Destination\bin"
Write-Host "Add to PATH: $env:USERPROFILE\OneDrive\Windows"
