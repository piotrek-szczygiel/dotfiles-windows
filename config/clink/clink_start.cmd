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

doskey l=exa  --git --icons --group-directories-first $*
doskey ls=exa --git --icons --group-directories-first $*
doskey ll=exa --git --icons --group-directories-first -l $*
doskey la=exa --git --icons --group-directories-first -la $*

doskey tr=erd -IHL1 --dirs-first --no-git --hidden $*

doskey md=mkdir ""$*"" $T cd ""$*""
doskey sudo=gsudo --wait $*

doskey pn=pnpm $*
doskey px=pnpm exec $*

doskey q=exit /b 0
doskey exit=echo Use 'q' to exit

REM not needed, added only so the "z" and "zi" command are not highlighted red, as in non-existent command
doskey z=cd $*
doskey zi=cd $*
