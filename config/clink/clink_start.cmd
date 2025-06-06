@echo off

doskey e=explorer "%%cd%%"
doskey cat=bat --paging=never -p $*

doskey ga=git add $*
doskey gam=git commit --amend --no-edit $*
doskey gc=git commit $*
doskey gca=git commit --all $*
doskey gclean=git clean -ffxd :/ $*
doskey gco=git checkout -- $*
doskey gd=git diff $*
doskey gds=git diff --staged $*
doskey gl=git pull $*
doskey glg=git log --graph --pretty=format:"%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset" --abbrev-commit $*
doskey gp=git push $*
doskey gs=git status $*
doskey gus=git restore --staged $*

doskey l=eza  --git --icons --group-directories-first $*
doskey ls=eza --git --icons --group-directories-first $*
doskey ll=eza --git --icons --group-directories-first -l $*
doskey la=eza --git --icons --group-directories-first -la $*

doskey md=mkdir ""$*"" $T cd ""$*""

doskey q=exit /b 0
