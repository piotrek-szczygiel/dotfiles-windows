@echo off

doskey ex=explorer.exe .
doskey md=mkdir ""$*"" $T cd ""$*""
doskey vs="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
doskey l=lsd $*
doskey ls=lsd $*
doskey ll=lsd -l $*
doskey la=lsd -la $*
doskey sudo=gsudo --wait $*
doskey zf=z -I $*

doskey ga=git add $*
doskey gus=git restore --staged $*
doskey gc=git commit $*
doskey gca=git commit --all $*
doskey gcl=git clean -ffxd :/ $*
doskey gam=git commit --all --amend --no-edit $*
doskey gco=git checkout -- $*
doskey gd=git diff $*
doskey gl=git pull $*
doskey glg=git log --graph --pretty=format:"%%Cred%%h%%Creset -%%C(yellow)%%d%%Creset %%s %%Cgreen(%%cr) %%C(bold blue)<%%an>%%Creset" --abbrev-commit $*
doskey gp=git push $*
doskey gs=git status $*
