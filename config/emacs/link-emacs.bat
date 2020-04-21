@echo off
mkdir %appdata%\.emacs.d
pushd %appdata%\.emacs.d
del init.el >nul 2>&1
mklink init.el %dotfiles%\config\emacs\init.el
popd
