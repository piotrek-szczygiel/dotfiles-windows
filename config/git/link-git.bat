@echo off
pushd %userprofile%
del /q .gitconfig
mklink .gitconfig %dotfiles%\config\git\.gitconfig
popd
