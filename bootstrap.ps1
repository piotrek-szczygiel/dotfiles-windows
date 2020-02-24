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
scoop bucket add extras
scoop bucket add java

# Install all the tools
$ScoopTools = @(
    "7zip",
    "autohotkey",
    "cmake",
    "everything",
    "fd",
    "git",
    "googlechrome",
    "jetbrains-toolbox",
    "megasync",
    "notepadplusplus",
    "openjdk",
    "potplayer",
    "putty",
    "python",
    "qbittorrent",
    "qnapi",
    "ripgrep",
    "rufus",
    "sudo",
    "vscode"
)

foreach ($Tool in $ScoopTools) {
    scoop install $Tool
}
