Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Built-in aliases take precedence over functions.
Remove-Alias ls, gc, gl, gp -Force

function l { eza --git --icons --group-directories-first @args }
function ls { eza --git --icons --group-directories-first @args }
function ll { eza -lF --git --icons --group-directories-first @args }
function la { eza -laF --git --icons --group-directories-first @args }

function ga { git add @args }
function gb { git switch @args }
function gc { git commit @args }
function gco { git checkout -- @args }
function gd { git diff @args }
function gl { git pull @args }
function glg { git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit @args }
function gp { git push @args }
function gs { git status @args }

function q { exit }

# Read .git/HEAD directly; spawning git would slow every prompt.
function Get-GitBranch {
    $dir = $PWD.ProviderPath
    while ($dir) {
        $head = "$dir\.git\HEAD"
        if ([IO.File]::Exists($head)) {
            $ref = [IO.File]::ReadAllText($head).Trim()
            if ($ref -like 'ref: refs/heads/*') { return $ref.Substring(16) }
            return
        }
        $dir = Split-Path $dir -Parent
    }
}

$script:lastHistoryId = 0
function prompt {
    $ok = $?
    $path = $PWD.ProviderPath
    if ($path.StartsWith($HOME, 'OrdinalIgnoreCase')) { $path = '~' + $path.Substring($HOME.Length) }
    $parts = $path.Split('\')
    for ($i = 1; $i -lt $parts.Length - 1; $i++) {
        $n = if ($parts[$i].StartsWith('.')) { 2 } else { 1 }
        $parts[$i] = $parts[$i].Substring(0, [Math]::Min($parts[$i].Length, $n))
    }
    $out = "$($PSStyle.Foreground.Cyan)$($parts -join '\')$($PSStyle.Reset)"

    $branch = Get-GitBranch
    if ($branch) { $out += " $($PSStyle.Foreground.BrightBlack)$branch$($PSStyle.Reset)" }

    $last = Get-History -Count 1
    if ($last -and $last.Id -ne $script:lastHistoryId) {
        $script:lastHistoryId = $last.Id
        $took = ($last.EndExecutionTime - $last.StartExecutionTime).TotalSeconds
        if ($took -ge 1) { $out += " $($PSStyle.Foreground.Yellow)$([int]$took)s$($PSStyle.Reset)" }
    }

    $arrow = if ($ok) { $PSStyle.Foreground.Magenta } else { $PSStyle.Foreground.Red }
    "$out $arrow$([char]0x276F)$($PSStyle.Reset) "
}

# Must come after prompt, which zoxide wraps. Cached to avoid spawning zoxide
# on every start; delete the file after upgrading zoxide.
$zoxideInit = "$env:LOCALAPPDATA\zoxide\init.ps1"
if (-not (Test-Path $zoxideInit)) {
    New-Item -ItemType Directory -Force (Split-Path $zoxideInit) | Out-Null
    zoxide init powershell | Set-Content $zoxideInit -Encoding utf8
}
. $zoxideInit
