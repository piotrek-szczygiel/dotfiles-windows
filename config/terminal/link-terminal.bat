@echo off
mkdir "%localappdata%\Microsoft\Windows Terminal"
pushd "%localappdata%\Microsoft\Windows Terminal"
del settings.json >nul 2>&1
mklink settings.json %dotfiles%\config\terminal\settings.json
popd
