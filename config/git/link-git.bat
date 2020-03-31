@echo off
pushd %userprofile%
del .gitconfig >nul 2>&1
del .gitconfig-ibm >nul 2>&1
mklink .gitconfig %dotfiles%\config\git\gitconfig
mklink .gitconfig-ibm %dotfiles%\config\git\gitconfig-ibm
popd
