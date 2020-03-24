@echo off
pushd %userprofile%
del .gitconfig >nul 2>&1
mklink .gitconfig %dotfiles%\config\git\.gitconfig
popd
