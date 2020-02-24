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

# Install all the tools
$ScoopTools = @(
    "7zip",
    "autohotkey",
    "cmake",
    "everything",
    "fd",
    "googlechrome",
    "jetbrains-toolbox",
    "megasync",
    "notepadplusplus",
    "potplayer",
    "putty",
    "python",
    "qbittorrent",
    "qnapi",
    "ripgrep",
    "rufus",
    "vscode"
)

foreach ($Tool in $ScoopTools) {
    scoop install $Tool
}
