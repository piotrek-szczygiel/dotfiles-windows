@echo off
mkdir %userprofile%\scoop\persist\sublime-text\Data\Packages
pushd %userprofile%\scoop\persist\sublime-text\Data\Packages
rmdir /s /q User
mklink /d User %dotfiles%\config\sublime\User
popd
