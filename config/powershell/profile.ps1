Import-Module Jump.Location

function global:prompt {
    "$($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";
}

function optimize {
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "Run this script as an Administrator!" -ForegroundColor Red
        return
    }

    Write-Host "Start optimization..." -ForegroundColor Yellow

    $ngen_path = Join-Path -Path $env:windir -ChildPath "Microsoft.NET"

    if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64") {
        $ngen_path = Join-Path -Path $ngen_path -ChildPath "Framework64\ngen.exe"
    } else {
        $ngen_path = Join-Path -Path $ngen_path -ChildPath "Framework\ngen.exe"
    }

    $ngen_application_path = (Get-ChildItem -Path $ngen_path -Filter "ngen.exe" -Recurse | Where-Object {$_.Length -gt 0} | Select-Object -Last 1).Fullname

    Set-Alias -Name ngen -Value $ngen_application_path
    [System.AppDomain]::CurrentDomain.GetAssemblies() | foreach { ngen install $_.Location /nologo /verbose }

    Write-Host "Optimization finished!" -ForegroundColor Green
}

function Remove-Alias ([string] $AliasName) {
    while (Test-Path Alias:$AliasName) {
        Remove-Item Alias:$AliasName -Force 2> $null
    }
}

Remove-Alias ex
function ex {
    explorer.exe .
}

Remove-Alias npp
function npp {
    notepad++.exe $args
}

Remove-Alias l
function l {
    ls.exe --color=auto $args
}

Remove-Alias ll
function ll {
    ls.exe --color=auto -la $args
}

Remove-Alias lg
function lg {
    lazygit.exe $args
}

Remove-Alias linux
function linux {
    run.exe wsl.exe xfce4-terminal
}

Remove-Alias ga
function ga {
    git add $args
}

Remove-Alias gus
function gus {
    git restore --staged $args
}

Remove-Alias gc
function gc {
    git commit $args
}

Remove-Alias gca
function gca {
    git commit --all $args
}

Remove-Alias gam
function gam {
    git commit --all --amend --no-edit $args
}

Remove-Alias gco
function gco {
    git checkout -- $args
}

Remove-Alias gd
function gd {
    git diff $args
}

Remove-Alias gl
function gl {
    git pull $args
}

Remove-Alias glg
function glg {
    git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit $args
}

Remove-Alias gp
function gp {
    git push $args
}

Remove-Alias gs
function gs {
    git status $args
}
