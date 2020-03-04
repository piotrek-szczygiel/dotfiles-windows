$Url = "https://github.com/piotrek-szczygiel/dotfiles-windows/archive/master.zip"
$ZipFile = "$env:TEMP\" + $(Split-Path -Path $Url -Leaf)
$Destination = "$env:TEMP\"

# Download dotfiles
Invoke-WebRequest -Uri $Url -OutFile $ZipFile

# Unzip them
Expand-Archive -Force -Path $ZipFile -DestinationPath $Destination

# Copy them to home directory
Get-ChildItem "$Destination\dotfiles-windows-master\home" | Copy-Item -Destination "$HOME" -Recurse -Force

# Install Scoop
Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")

scoop install git
scoop bucket add extras
scoop bucket add java
scoop bucket add jetbrains

$UserTools = @(
    "7zip",
    "autohotkey",
    "clink",
    "coreutils",
    "everything",
    "fd",
    "freecommander",
    "gcc",
    "googlechrome",
    "jetbrains-toolbox",
    "megasync",
    "neovim",
    "netcat",
    "notepadplusplus",
    "p4merge",
    "putty",
    "python",
    "ripgrep",
    "sudo",
    "vscode",
    "wget"
)

foreach ($Tool in $UserTools) {
    scoop install $Tool
}

scoop install vcredist2012
scoop uninstall vcredist2012

