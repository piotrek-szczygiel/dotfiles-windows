@echo off
mkdir %appdata%\Code\User
pushd %appdata%\Code\User
del settings.json >nul 2>&1
del keybindings.json >nul 2>&1
mklink settings.json %dotfiles%\config\vscode\settings.json
mklink keybindings.json %dotfiles%\config\vscode\keybindings.json
popd
