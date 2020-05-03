@echo off
mkdir %userprofile%\scoop\persist\sublime-text\Data\Packages\User
pushd %userprofile%\scoop\persist\sublime-text\Data\Packages\User
del Preferences.sublime-settings >nul 2>&1
del "Package Control.sublime-settings" >nul 2>&1
del Terminal.sublime-settings >nul 2>&1
mklink Preferences.sublime-settings %dotfiles%\config\sublime\Preferences.sublime-settings
mklink "Package Control.sublime-settings" "%dotfiles%\config\sublime\Package Control.sublime-settings"
mklink Terminal.sublime-settings %dotfiles%\config\sublime\Terminal.sublime-settings
popd
