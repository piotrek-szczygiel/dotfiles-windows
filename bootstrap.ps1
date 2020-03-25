$CloneUrl = "https://github.com/piotrek-szczygiel/dotfiles-windows"
$PushUrl = "git@github.com:piotrek-szczygiel/dotfiles-windows"
$Destination = "$env:USERPROFILE\dotfiles"

# Install scoop
if (-Not (Get-Command scoop)) {
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")
}

# Install programs
scoop install git
scoop bucket add extras

$UserTools = @(
    "7zip",
    "autohotkey",
    "bat",
    "clink",
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
    "winmerge",
    "wox"
)

foreach ($Tool in $UserTools) {
    scoop install $Tool
}

# Clone the dotfiles repository
Remove-Item "$Destination" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\.gitconfig" -ErrorAction SilentlyContinue
git clone "$CloneUrl" "$Destination"

# Set remote for pushing
Set-Location -Path "$Destination"
git remote set-url origin "$PushUrl"

# Point %DOTFILES% to correct directory
[Environment]::SetEnvironmentVariable("DOTFILES", "$Destination", "User")

# And launch linking script
sudo cmd /c "%DOTFILES%\link-all.bat"
