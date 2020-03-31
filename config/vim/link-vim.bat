@echo off
pushd %userprofile%
rmdir /s /q vimfiles
mklink /d vimfiles %dotfiles%\config\vim\vimfiles
del _vimrc >nul 2>&1
del _gvimrc >nul 2>&1
mklink _vimrc %dotfiles%\config\vim\_vimrc
mklink _gvimrc %dotfiles%\config\vim\_gvimrc
popd
