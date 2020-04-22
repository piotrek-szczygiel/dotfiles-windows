@echo off
pushd %userprofile%
del .spacemacs >nul 2>&1
mklink .spacemacs %dotfiles%\config\emacs\.spacemacs
popd
