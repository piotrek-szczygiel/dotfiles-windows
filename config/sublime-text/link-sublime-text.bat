@echo off
mkdir "%appdata%\Sublime Text\Packages\User" >nul 2>&1
pushd "%appdata%\Sublime Text\Packages\User"
del "Preferences.sublime-settings" >nul 2>&1
del "Package Control.sublime-settings" >nul 2>&1
del "Default (Windows).sublime-keymap" >nul 2>&1
mklink "Preferences.sublime-settings" "%dotfiles%\config\sublime-text\Preferences.sublime-settings"
mklink "Package Control.sublime-settings" "%dotfiles%\config\sublime-text\Package Control.sublime-settings"
mklink "Default (Windows).sublime-keymap" "%dotfiles%\config\sublime-text\Default (Windows).sublime-keymap"
popd
