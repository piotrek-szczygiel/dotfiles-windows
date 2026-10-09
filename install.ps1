#Requires -Version 7
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
    'Google.Chrome'
)
foreach ($id in $packages) {
    winget install --id $id --exact --silent --accept-package-agreements --accept-source-agreements
}
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')

function Set-Registry($Path, $Name, $Value) {
    if (-not (Test-Path $Path)) { New-Item $Path -Force | Out-Null }
    Set-ItemProperty $Path $Name $Value
}

function Get-Pending($Entries) {
    $Entries | Where-Object { (Get-ItemProperty $_[0] -ErrorAction SilentlyContinue).($_[1]) -ne $_[2] }
}

$machine = @(
    @('HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem', 'LongPathsEnabled', 1),
    # Developer Mode: symlinks without admin.
    @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock', 'AllowDevelopmentWithoutDevLicense', 1),
    # Widgets.
    @('HKLM:\SOFTWARE\Policies\Microsoft\Dsh', 'AllowNewsAndInterests', 0),
    # Recall.
    @('HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI', 'DisableAIDataAnalysis', 1),
    # Bing in Start search.
    @('HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer', 'DisableSearchBoxSuggestions', 1)
)
$pending = @(Get-Pending $machine)
if ($pending) {
    $elevated = "function Set-Registry {${function:Set-Registry}}`n" + (($pending | ForEach-Object { "Set-Registry '$($_[0])' '$($_[1])' $($_[2])" }) -join "`n")
    $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($elevated))
    Start-Process pwsh -Verb RunAs -Wait -ArgumentList '-NoProfile', '-EncodedCommand', $encoded
}

$advanced = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$content = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
$theme = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
$user = @(
    @($advanced, 'HideFileExt', 0),
    @($advanced, 'Hidden', 1),
    @($advanced, 'LaunchTo', 1),
    # Classic context menu.
    @('HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32', '(default)', ''),

    @($advanced, 'Start_TrackDocs', 0),
    @($advanced, 'Start_IrisRecommendations', 0),
    @($content, 'SilentInstalledAppsEnabled', 0),
    @($content, 'SystemPaneSuggestionsEnabled', 0),
    @($content, 'SubscribedContent-338387Enabled', 0),
    @($content, 'SubscribedContent-338388Enabled', 0),
    @($content, 'SubscribedContent-338389Enabled', 0),
    @($content, 'SubscribedContent-338393Enabled', 0),
    @($content, 'SubscribedContent-353694Enabled', 0),
    @($content, 'SubscribedContent-353696Enabled', 0),
    @('HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement', 'ScoobeSystemSettingEnabled', 0),
    @('HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo', 'Enabled', 0),

    @($advanced, 'TaskbarAl', 0),
    @($advanced, 'ShowTaskViewButton', 0),
    @('HKCU:\Software\Microsoft\Windows\CurrentVersion\Search', 'SearchboxTaskbarMode', 0),
    @("$advanced\TaskbarDeveloperSettings", 'TaskbarEndTask', 1),

    @($theme, 'AppsUseLightTheme', 0),
    @($theme, 'SystemUsesLightTheme', 0),
    @('HKCU:\Control Panel\Mouse', 'MouseSpeed', '0'),
    @('HKCU:\Control Panel\Mouse', 'MouseThreshold1', '0'),
    @('HKCU:\Control Panel\Mouse', 'MouseThreshold2', '0'),
    @('HKCU:\Control Panel\Keyboard', 'KeyboardSpeed', '31'),
    @('HKCU:\Control Panel\Keyboard', 'KeyboardDelay', '0'),
    # Sticky Keys off, including the Shift x5 shortcut.
    @('HKCU:\Control Panel\Accessibility\StickyKeys', 'Flags', '506')
)
$pending = @(Get-Pending $user)
foreach ($entry in $pending) { Set-Registry @entry }
if ($pending) { Stop-Process -Name explorer -Force }

Get-AppxPackage Microsoft.Copilot | Remove-AppxPackage

[Environment]::SetEnvironmentVariable('POWERSHELL_UPDATECHECK', 'Off', 'User')
[Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'User')

# Claude Code installs here without adding it to PATH.
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ }
if ("$HOME\.local\bin" -notin $userPath) {
    [Environment]::SetEnvironmentVariable('Path', (@($userPath) + "$HOME\.local\bin" -join ';'), 'User')
}

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

if (-not (Test-Path "$HOME\.ssh\id_ed25519")) {
    New-Item -ItemType Directory -Force "$HOME\.ssh" | Out-Null
    ssh-keygen -t ed25519 -C $env:COMPUTERNAME -f "$HOME\.ssh\id_ed25519" -q -N ''
}
# Cloned over HTTPS before the key existed.
git -C $repo remote set-url origin git@github.com:piotrek-szczygiel/dotfiles-windows.git

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

# Copied, not linked: Windows Terminal rewrites the file and would replace a symlink.
$terminal = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType Directory -Force $terminal | Out-Null
Copy-Item "$repo\windows-terminal\settings.json" "$terminal\settings.json" -Force
