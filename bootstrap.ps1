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

$UserTools = @(
    "autohotkey",
    "cmake",
    "everything",
    "fd",
    "googlechrome",
    "jetbrains-toolbox",
    "megasync",
    "mpv",
    "openjdk",
    "putty",
    "python",
    "qbittorrent",
    "qnapi",
    "ripgrep",
    "rufus",
    "sudo"
)

$SudoTools = @(
    "7zip",
    "notepadplusplus",
    "vscode"
)

foreach ($Tool in $UserTools) {
    scoop install $Tool
}

foreach ($Tool in $SudoTools) {
    sudo scoop install $Tool
}
