@echo off
mkdir "%appdata%\Sublime Text\Packages\User" >nul 2>&1
pushd "%appdata%\Sublime Text\Packages\User"
del Preferences.sublime-settings >nul 2>&1
mklink Preferences.sublime-settings %dotfiles%\config\sublime-text\Preferences.sublime-settings
popd
