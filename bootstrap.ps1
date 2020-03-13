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
    "archwsl",
    "autohotkey",
    "coreutils",
    "everything",
    "fd",
    "firefox",
    "freecommander",
    "gcc",
    "intellij-idea-ultimate",
    "megasync",
    "neovim",
    "netcat",
    "openjdk14",
    "p4merge",
    "putty",
    "python",
    "ripgrep",
    "rustup",
    "sudo",
    "uncap",
    "vscode",
    "wget"
)

foreach ($Tool in $UserTools) {
    scoop install $Tool
}

scoop install vcredist2012 vcredist2013
scoop uninstall vcredist2012 vcredist2013
