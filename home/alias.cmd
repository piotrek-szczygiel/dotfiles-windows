@echo off

DOSKEY alias=code %USERPROFILE%\alias.cmd

DOSKEY l=dir /B
DOSKEY ls=dir /B

DOSKEY ~=cd %USERPROFILE%
DOSKEY ..=cd..
DOSKEY ...=cd..\..
DOSKEY ....=cd..\..\..
DOSKEY .....=cd..\..\..\..

DOSKEY dl=cd %USERPROFILE%\Downloads
DOSKEY dev=cd C:\dev

DOSKEY e=explorer $*

DOSKEY ga=git add $*
DOSKEY gc=git commit $*
DOSKEY gca=git commit -a $*
DOSKEY gco=git checkout -- $*
DOSKEY gd=git diff $*
DOSKEY gl=git pull $*
DOSKEY glg=git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit $*
DOSKEY gp=git push $*
DOSKEY gs=git status $*
