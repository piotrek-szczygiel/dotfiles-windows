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
    lsd.exe $args
}

Remove-Alias ll
function ll {
    lsd.exe -la $args
}

Remove-Alias ga
function ga {
    git add $args
}

Remove-Alias gc
function gc {
    git commit $args
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

Invoke-Expression (&starship init powershell)
Import-Module ZLocation
