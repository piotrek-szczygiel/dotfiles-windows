# Install scoop
if (-Not (Get-Command scoop)) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")
}

# Install programs
scoop install git
scoop bucket add extras

$UserTools = @(
    "7zip",
    "archwsl",
    "autohotkey",
    "bat",
    "coreutils",
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
    "wox"
)

foreach ($Tool in $UserTools) {
    scoop install $Tool
}

# Clone the dotfiles repository
git clone https://github.com/piotrek-szczygiel/dotfiles-windows $env:userprofile\dotfiles
Set-Location -Path $env:userprofile\dotfiles
git remote set-url origin git@github.com:piotrek-szczygiel/dotfiles-windows
[Environment]::SetEnvironmentVariable("DOTFILES", "$env:userprofile\dotfiles", "User")
