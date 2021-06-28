@echo off

doskey e=explorer "%%cd%%"
doskey t=totalcmd /o "%%cd%%"

doskey cat=bat $*
doskey catp=bat --paging=never -p $*

doskey l=ls --color=always $*
doskey ls=ls --color=always $*
doskey ll=ls --color=always -l $*
doskey la=ls --color=always -la $*
doskey sudo=gsudo --wait $*
doskey time=powershell -c "$x=Measure-Command { $* | Out-Default };Write-Host -ForegroundColor Green ""Elapsed: $($x.TotalMilliseconds)ms"""
doskey zf=z -I $*

doskey md=mkdir ""$*"" $T cd ""$*""
doskey vs="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

doskey nvimfd=powershell -c "nvim $(fd --type f . | fzf)"
doskey nvimrg=rg --column --line-number --no-heading --smart-case --color=always . $b fzf $b powershell -c "$a=$(Read-Host);if([string]::IsNullOrEmpty($a)){exit};$a=$a.split(':')[0..2];if($a.Length -ne 3){exit};$c=[string]::Format('nvim \"+call cursor({0}, {1})\" {2}', $a[1], $a[2], $a[0]);iex $c"

doskey codefd=powershell -c "code $(fd --type f . | fzf)"
doskey coderg=rg --column --line-number --no-heading --smart-case --color=always . $b fzf $b powershell -c "$a=$(Read-Host);if([string]::IsNullOrEmpty($a)){exit};$a=$a.split(':')[0..2];if($a.Length -ne 3){exit};$c=[string]::Format('code --goto \"{0}\"', $a -Join ':');iex $c"

doskey ga=git add $*
doskey gus=git restore --staged $*
doskey gc=git commit $*
doskey gca=git commit --all $*
doskey gclean=git clean -ffxd :/ $*
doskey gam=git commit --all --amend --no-edit $*
doskey gco=git checkout -- $*
doskey gd=git diff $*
doskey gl=git pull $*
doskey glg=git log --graph --pretty=format:"%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset" --abbrev-commit $*
doskey gp=git push $*
doskey gs=git status $*
