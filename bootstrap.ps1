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
    "clink",
    "coreutils",
    "discord",
    "everything",
    "fd",
    "firefox",
    "freecommander",
    "gcc",
    "neovim",
    "netcat",
    "putty",
    "python",
    "ripgrep",
    "rustup",
    "sublime-merge",
    "sublime-text",
    "sudo",
    "uncap",
    "unlocker",
    "vscode",
    "wget",
    "winmerge",
    "wox"
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
[Environment]::SetEnvironmentVariable("dotfiles", "$Destination", "User")

if (-Not ($env:Path -Like "*$Destination\bin*")) {
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$Destination\bin", "User")
}

[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")


Write-Host "Setting keyboard repeat speed and delay"
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardSpeed" 31
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardDelay" 0

Write-Host "Launching linking script with administrator rights"
sudo cmd /c "%DOTFILES%\link-all.bat"
