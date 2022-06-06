@echo off

doskey e=explorer "%%cd%%"

doskey cat=bat --paging=never -p $*

doskey q=exit /b 0
doskey exit=echo Use 'q' to exit

doskey l=exa --icons --group-directories-first $*
doskey ls=exa --icons --group-directories-first $*
doskey ll=exa --icons --group-directories-first -l $*
doskey la=exa --icons --group-directories-first -la $*

doskey sudo=gsudo --wait $*

doskey tg=terragrunt $*

doskey md=mkdir ""$*"" $T cd ""$*""

doskey ga=git add $*
doskey gus=git restore --staged $*
doskey gc=git commit $*
doskey gca=git commit --all $*
doskey gclean=git clean -ffxd :/ $*
doskey gam=git commit --amend --no-edit $*
doskey gco=git checkout -- $*
doskey gd=git diff $*
doskey gl=git pull $*
doskey glg=git log --graph --pretty=format:"%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset" --abbrev-commit $*
doskey gp=git push $*
doskey gs=git status $*
