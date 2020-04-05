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
    "dos2unix",
    "everything",
    "fd",
    "firefox",
    "freecommander",
    "fzf",
    "gcc",
    "keepassxc",
    "lua",
    "netcat",
    "notepadplusplus",
    "putty",
    "python",
    "ripgrep",
    "rustup",
    "sublime-merge",
    "sudo",
    "unlocker",
    "vscode",
    "vswhere",
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
}
else {
    Write-Host "Downloading dotfiles"
    git clone "$CloneUrl" "$Destination"
    Set-Location -Path "$Destination"
    git remote set-url origin "$PushUrl"
}

Write-Host "Setting environment variables"
[Environment]::SetEnvironmentVariable("dotfiles", "$Destination", "User")
[Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")
[Environment]::SetEnvironmentVariable("PYTHONPATH", "$env:USERPROFILE\scoop\apps\python\current", "User")
[Environment]::SetEnvironmentVariable("FZF_DEFAULT_COMMAND", "fd --type file --follow --hidden --exclude .git", "User")
[Environment]::SetEnvironmentVariable("FZF_DEFAULT_OPTS", "--height=35%", "User")

Write-Host "Setting keyboard repeat speed and delay"
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardSpeed" 31
Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardDelay" 0

Write-Host "Launching linking script with administrator rights"
sudo cmd /c "%DOTFILES%\link-all.bat"

Write-Host "Add to PATH: $Destination\bin"
Write-Host "Add to PATH: $env:USERPROFILE\scoop\apps\clink\current\profile"
Write-Host "Add to PATH: $env:USERPROFILE\OneDrive\Windows"
