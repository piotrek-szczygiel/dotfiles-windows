@echo off
mkdir %userprofile%\.ssh
pushd %userprofile%\.ssh
del config >nul 2>&1
mklink config %dotfiles%\config\ssh\config
popd
