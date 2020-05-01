@echo off
mkdir "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
pushd "%localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
del settings.json >nul 2>&1
mklink settings.json %dotfiles%\config\terminal\settings.json
popd
