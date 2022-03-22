@echo off

doskey e=explorer "%%cd%%"

doskey cat=bat --paging=never -p $*

doskey q=exit /b 0
doskey exit=echo Use 'q' to exit

doskey l=lsd $*
doskey ls=lsd $*
doskey ll=lsd -l $*
doskey la=lsd -la $*
doskey sudo=gsudo --wait $*
doskey zf=z -I $*

doskey md=mkdir ""$*"" $T cd ""$*""

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
