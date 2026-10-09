#Requires -Version 7
# Sets up this machine from the repo. Safe to re-run.
$ErrorActionPreference = 'Stop'
$repo = $PSScriptRoot

$packages = @(
    'Git.Git'
    'Microsoft.PowerShell'
    'ajeetdsouza.zoxide'
    'BurntSushi.ripgrep.MSVC'
    'sharkdp.fd'
    'eza-community.eza'
    'AgileBits.1Password'
)
foreach ($id in $packages) {
    winget install --id $id --exact --silent --accept-package-agreements --accept-source-agreements
}
# Pick up PATH changes from the installers (git is used below).
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')

# Long paths and Developer Mode (symlinks without admin) need one elevated call.
$fileSystem = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
$appModel = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
$longPaths = (Get-ItemProperty $fileSystem).LongPathsEnabled
$devMode = (Get-ItemProperty $appModel -ErrorAction SilentlyContinue).AllowDevelopmentWithoutDevLicense
if ($longPaths -ne 1 -or $devMode -ne 1) {
    $elevated = @"
Set-ItemProperty '$fileSystem' LongPathsEnabled 1 -Type DWord
if (-not (Test-Path '$appModel')) { New-Item '$appModel' | Out-Null }
Set-ItemProperty '$appModel' AllowDevelopmentWithoutDevLicense 1 -Type DWord
"@
    $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($elevated))
    Start-Process pwsh -Verb RunAs -Wait -ArgumentList '-NoProfile', '-EncodedCommand', $encoded
}

[Environment]::SetEnvironmentVariable('POWERSHELL_UPDATECHECK', 'Off', 'User')
[Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'User')

# Claude Code installs to ~\.local\bin but does not add it to PATH.
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ }
if ("$HOME\.local\bin" -notin $userPath) {
    [Environment]::SetEnvironmentVariable('Path', (@($userPath) + "$HOME\.local\bin" -join ';'), 'User')
}

# Maple Mono NF (latest release), installed per user.
$fonts = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
if (-not (Test-Path "$fonts\MapleMono-NF-Regular.ttf")) {
    $base = 'https://github.com/subframe7536/maple-font/releases/latest/download'
    $tmp = Join-Path $env:TEMP "maple-font-$(Get-Random)"
    New-Item -ItemType Directory $tmp | Out-Null
    Invoke-WebRequest "$base/MapleMono-NF.zip" -OutFile "$tmp\font.zip"
    Invoke-WebRequest "$base/MapleMono-NF.sha256" -OutFile "$tmp\font.sha256"
    $expected = (Get-Content "$tmp\font.sha256" -Raw).Trim().Split()[0]
    if ((Get-FileHash "$tmp\font.zip" -Algorithm SHA256).Hash -ne $expected) { throw 'Maple Mono NF checksum mismatch' }
    Expand-Archive "$tmp\font.zip" "$tmp\font"
    New-Item -ItemType Directory -Force $fonts | Out-Null
    foreach ($ttf in Get-ChildItem "$tmp\font" -Recurse -Filter *.ttf) {
        Copy-Item $ttf.FullName $fonts -Force
        Set-ItemProperty 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts' "$($ttf.BaseName) (TrueType)" "$fonts\$($ttf.Name)"
    }
    Remove-Item $tmp -Recurse -Force
}

# Per-machine key for GitHub and Forgejo. The repo is cloned over HTTPS before the key exists.
if (-not (Test-Path "$HOME\.ssh\id_ed25519")) {
    New-Item -ItemType Directory -Force "$HOME\.ssh" | Out-Null
    ssh-keygen -t ed25519 -C $env:COMPUTERNAME -f "$HOME\.ssh\id_ed25519" -q -N ''
}
git -C $repo remote set-url origin git@github.com:piotrek-szczygiel/dotfiles-windows.git

# Symlinks, so edits go straight into the repo. Anything else in the way is kept as .bak.
$links = [ordered]@{
    'git\.gitconfig'         = "$HOME\.gitconfig"
    'ssh\config'             = "$HOME\.ssh\config"
    'claude\settings.json'   = "$HOME\.claude\settings.json"
    'powershell\profile.ps1' = "$([Environment]::GetFolderPath('MyDocuments'))\PowerShell\Microsoft.PowerShell_profile.ps1"
}
foreach ($source in $links.Keys) {
    $target = Join-Path $repo $source
    $path = $links[$source]
    $item = Get-Item $path -Force -ErrorAction SilentlyContinue
    if ($item -and $item.LinkType -eq 'SymbolicLink' -and $item.Target -eq $target) { continue }
    if ($item) { Move-Item $path "$path.bak" -Force }
    New-Item -ItemType Directory -Force (Split-Path $path) | Out-Null
    New-Item -ItemType SymbolicLink -Path $path -Target $target | Out-Null
}

# Windows Terminal rewrites its settings file, which would replace a symlink, so copy it.
$terminal = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType Directory -Force $terminal | Out-Null
Copy-Item "$repo\windows-terminal\settings.json" "$terminal\settings.json" -Force
