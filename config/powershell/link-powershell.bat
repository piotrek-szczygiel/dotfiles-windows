@echo off
mkdir %userprofile%\Documents\WindowsPowerShell
pushd %userprofile%\Documents\WindowsPowerShell
del profile.ps1 >nul 2>&1
mklink profile.ps1 %dotfiles%\config\powershell\profile.ps1
popd
